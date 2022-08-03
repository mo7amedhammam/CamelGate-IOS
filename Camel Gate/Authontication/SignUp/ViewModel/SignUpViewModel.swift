//
//  SignUpViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

class SignUpViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<SignUpModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int = 14
    
    // ------- input
    @Published  var Drivername: String = ""
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
    @Published  var confirmpassword = "" {
        didSet{
            if confirmpassword != "" && ( password !=  confirmpassword) {
                validations = .ConfirmPassword
                self.ValidationMessage = "Passwords_does_not_match"
            }else{
                validations = .none
                self.ValidationMessage = ""
            }
        }
     }

    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
//    @Published var inlineErrorPassword = ""
    @Published var publishedUserLogedInModel: SignUpModel? = nil
    @Published var UserCreated = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    @Published var destination = AnyView(TabBarView())
    init() {

        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            publishedUserLogedInModel = modeldata.data
            UserCreated = true
            
//            if publishedUserLogedInModel?.statusId == 1 {
//                destination = AnyView(PersonalDataView())
//            }else if publishedUserLogedInModel?.ProfileStatus == 1{
//                destination = AnyView(MedicalStateView())
//
//            }else if self.publishedUserLogedInModel?.ProfileStatus == 2{
//                Helper.setUserData(Id: publishedUserLogedInModel?.Id ?? 0, PhoneNumber: publishedUserLogedInModel?.Phone ?? "", patientName: publishedUserLogedInModel?.Name ?? "" )
//                Helper.setUserimage(userImage: URLs.BaseUrl+"\(publishedUserLogedInModel?.Image ?? "")")
//                destination = AnyView(TabBarView())
//            }
            Helper.setAccessToken(access_token: "Bearer " + "\(publishedUserLogedInModel?.token ?? "")" )
//
        }.store(in: &cancellables)
        
    }

    // MARK: - API Services
    func CreateAccount(){
        let params : [String : Any] =
        [
            "roleId"                       : 8,
            "name"                          : Drivername,
            "mobile"                       : phoneNumber ,
            "password"                    : password
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.createAccount(parameters: params))
        }.done({ [self] response in
            let result = response as! Response

//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<SignUpModel> = try BGDecoder.decode(data: result.data )
            print(params)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    UserCreated = true
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

