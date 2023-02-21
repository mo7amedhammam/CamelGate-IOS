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

enum usreCreationOP {
case Verify,CreateUser
}
class SignUpViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<SignUpPhoneVerify>, Error>()
    let passthroughCreateModel = PassthroughSubject<BaseResponse<SignUpModel>, Error>()

    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    let PhoneNumLength: Int = 9
    
    // ------- input
    @Published  var Drivername: String = ""
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber != "" && ( self.phoneNumber.count < PhoneNumLength || self.phoneNumber.count > PhoneNumLength) {
                validations = .PhoneNumber
                self.ValidationMessage = "Enter_a_valid_Phone_number"
            }
//            else if self.phoneNumber.isEmpty {
//                validations = .PhoneNumber
//                self.ValidationMessage = "*"
//            }
            else if self.phoneNumber.count == PhoneNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.phoneNumber == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    
    @Published  var password = ""{
        didSet{
            if confirmpassword != "" {
                if password !=  confirmpassword {
                    validations = .ConfirmPassword
                    self.ValidationMessage = "Passwords_does_not_match"
                }else{
                    validations = .none
                    self.ValidationMessage = ""
                }
            }
        }
    }
    @Published  var confirmpassword = "" {
        didSet{
            if password != "" {
            if confirmpassword != "" && ( password !=  confirmpassword) {
                validations = .ConfirmPassword
                self.ValidationMessage = "Passwords_does_not_match"
            }else{
                validations = .none
                self.ValidationMessage = ""
            }
            }else{
                validations = .Password
                self.ValidationMessage = "Password_Empty"
            }
        }
     }

    @Published  var currentOTP = 0
    @Published  var SecondsCount = 0
    var typedOtp = ""

    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var IsTermsAgreed = false
//    @Published var inlineErrorPassword = ""
//    @Published var publishedUserLogedInModel: SignUpPhoneVerify? = nil
//    @Published var publishedUserCreatedModel: SignUpModel? = nil

    @Published var accountCreated = false
    @Published var isMatchedOTP = false
    @Published var accountVerified = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {

        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
//            publishedUserLogedInModel = modeldata.data
            currentOTP = modeldata.data?.otp ?? 0
            SecondsCount = modeldata.data?.secondsCount ?? 0

            DispatchQueue.main.async {
                accountCreated = true
            }
        }.store(in: &cancellables)
        
        passthroughCreateModel.sink { (completion) in
        } receiveValue: { [self](modeldata) in
//            publishedUserCreatedModel = modeldata.data
            accountVerified = true
            Helper.setAccessToken(access_token: "Bearer " + "\(modeldata.data?.token ?? "")" )
//            Helper.setUserData(DriverName: modeldata.data?.name ?? "", DriverImage: modeldata.data?.image ?? "")
        }.store(in: &cancellables)
    }

    // MARK: - API Services
    func CreateUser(){
        let params : [String : Any] =
        [
            "roleId"                       : 8,
            "name"                          : Drivername,
            "mobile"                       : phoneNumber ,
            "password"                    : password
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.CreateUser(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<SignUpPhoneVerify> = try BGDecoder.decode(data: result.data )
            print(params)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    accountCreated = true
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
    
    // MARK: - API Services
    func VerifyUser(){
        let params : [String : Any] =
        [
            "otp"                       : typedOtp ,
            "mobile"                       : phoneNumber
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices, AuthServices.VerifyUser(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<SignUpModel> = try BGDecoder.decode(data: result.data )
            print(params)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughCreateModel.send(data)
                    accountVerified = true
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

