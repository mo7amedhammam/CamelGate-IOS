//
//  ChangePasswordViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 20/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit
import Alamofire


class ChangePasswordViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ChangePasswordModel>, Error>()
    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var operation : passwordOperations = .change
    @Published  var phoneNumber = ""

    @Published  var CurrentPassword = ""
    @Published  var NewPassword = ""
    @Published  var ConfirmNewPassword = ""
    

    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedChangePasswordModel: ChangePasswordModel? = nil
    @Published var PasswordChanged = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            DispatchQueue.main.async {
                publishedChangePasswordModel = modeldata.data
      
                    isLoading = false
                PasswordChanged = true
            }
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func ChangePassword(){
        let params : [String : Any] = operation == .change ?
        [
//            "id"                              : 8,
            "currentPassword"               : CurrentPassword ,
            "newPassword"                    : NewPassword
        ]:[
            "mobile"               : phoneNumber ,
            "newPassword"                    : NewPassword
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices, operation == .change ? HomeServices.ChangePassword(parameters: params) : HomeServices.ChangeForgetPassword(parameters: params))
        }.done({ [self] response in
            let result = response as! Response

            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ChangePasswordModel> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                }
            }else {
                if data.messageCode == 400{
                message = data.message ?? "error 400"
                }else if data.messageCode == 401{
                    message = "unauthorized"
                }else{
                    message = "Bad Request"
                }
                isAlert = true
                isLoading = false
            }


        }).ensure { [self] in
            isLoading = false

        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }
}
