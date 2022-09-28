//
//  ResendOTPViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 28/09/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

class ResendOTPViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<SignUpPhoneVerify>, Error>()

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
    
    @Published  var NewCode: Int = 0
    @Published  var NewSecondsCount: Int = 0
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
//    @Published var publishedOTPModel: SignUpPhoneVerify? = nil

    @Published var verifyUser = false
    @Published var isMatchedOTP = false
    @Published var isUserCreated = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
//            publishedOTPModel = modeldata.data
            NewCode = modeldata.data?.otp ?? 0
            NewSecondsCount = modeldata.data?.secondsCount ?? 0
            
//            verifyUser = true
        }.store(in: &cancellables)

    }

    // MARK: - API Services
    func SendOTP(){
        let params : [String : Any] =
        [
            "mobile"                       : phoneNumber
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.ResendOTP(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<SignUpPhoneVerify> = try BGDecoder.decode(data: result.data )
            print(params)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    verifyUser = true
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
