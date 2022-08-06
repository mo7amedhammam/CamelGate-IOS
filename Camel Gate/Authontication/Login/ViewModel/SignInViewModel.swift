//
//  SignInViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit
import Alamofire


class SignInViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<LoginModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int = 14
    
    // ------- input
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber != "" && ( self.phoneNumber.count < characterLimit || self.phoneNumber.count > characterLimit) {
                validations = .PhoneNumber
                self.ValidationMessage = "Enter_a_valid_Phone_number"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.phoneNumber.count == characterLimit {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.phoneNumber == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    
    @Published  var password = ""
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: LoginModel? = nil
    @Published var isLogedin = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(EditProfileInfoView(taskStatus: .create, selectedDate: Date()))
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            DispatchQueue.main.async {
                publishedUserLogedInModel = modeldata.data
                if publishedUserLogedInModel?.profileStatusId == 1 {
                    destination = AnyView(EditProfileInfoView(taskStatus: .create)
                                            .navigationBarHidden(true))

                }else if publishedUserLogedInModel?.profileStatusId == 2{
                    destination = AnyView(TabBarView()
                                            .navigationBarHidden(true))
                }
                Helper.setUserData( DriverName: publishedUserLogedInModel?.name ?? "", DriverImage: publishedUserLogedInModel?.image ?? "" )
//                Helper.setUserimage(userImage: publishedUserLogedInModel?.image ?? "")
                Helper.setAccessToken(access_token: "Bearer " + "\(publishedUserLogedInModel?.token ?? "")" )
                isLogedin = true
            }
            
            
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func Login(){
        let params : [String : Any] =
        [
            "mobile"                       : phoneNumber ,
            "password"                    : password
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.Login(parameters: params))
        }.done({ [self] response in
            let result = response as! Response

//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<LoginModel> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
//                    isLogedin = true
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
            }


        }).ensure { [self] in
            isLoading = false
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }
}


