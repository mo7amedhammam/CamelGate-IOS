//
//  ViewModelSendFirebaseToken.swift
//  Camel Gate
//
//  Created by wecancity on 12/02/2023.
//

import Foundation
import Combine
import Moya
import PromiseKit
import Alamofire
import FirebaseMessaging


class ViewModelSendFirebaseToken: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ModelFirebaseToken>, Error>()
    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    let PhoneNumLength: Int = 9

    static let shared = ViewModelSendFirebaseToken()
    // ------- input
    @Published  var firebaseDeviceToken: String =  Messaging.messaging().fcmToken ?? ""
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var FirebaseTokensent = false
    
    @Published var isLogedin = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
                if modeldata.success == true{
                    self?.FirebaseTokensent = true
                    Helper.IsFirebaseTokenSent(value: true)
                }
            
        }.store(in: &cancellables)
    }
}


extension ViewModelSendFirebaseToken{
        
    // MARK: - API Services
    func SendFirebaseToken(){
        // Register to receive notification in your class
        let params : [String : Any] =
        [
            "firebaseDeviceToken"                       : firebaseDeviceToken,
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.sendFirebaseToken(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ModelFirebaseToken> = try BGDecoder.decode(data: result.data )
            print(params)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
//                    LoginManger.saveUser(data.data)
//                    isLogedin = true
                }
            }else {
                if data.messageCode == 400{
                message = data.message ?? "error 400"
                    isAlert = true
                }else if data.messageCode == 401{
                    message = "unauthorized"
                }else{
                    message = "Bad Request"
                    isAlert = true
                }
                isLoading = false
            }
        }).ensure {
//            isLoading = false
//            message = "success"
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }
    
    func RemoveFirebaseToken(){
        // Register to receive notification in your class
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.removeFirebaseToken)
        }.done({ [self] response in
            let result = response as! Response

            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ModelFirebaseToken> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
//                    passthroughModelSubject.send(data)
                }
            }else {
                if data.messageCode == 400{
                message = data.message ?? "error 400"
                    isAlert = true
                }else if data.messageCode == 401{
                    message = "unauthorized"
                }else{
                    message = "Bad Request"
                    isAlert = true
                }
                isLoading = false
            }
        }).ensure {
//            isLoading = false
//            message = "success"
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }

}

