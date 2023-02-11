//
//  DeleteAcoountViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 15/01/2023.
//

import Combine
import Moya
import PromiseKit

class DeleteAcoountViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<RemoveAccountModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []

    // ------- input
    @Published  var CanDeleteaccount = false

    @Published  var DriverDeleted = false
    //------- output
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        CanDeleteAccount()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
//            DispatchQueue.main.async {
            if modeldata.success == true{
                self?.isLoading = false
                self?.DriverDeleted = true
            }
            //                }
        }.store(in: &cancellables)
    }

    // MARK: - API Services
    func CanDeleteAccount(){
        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
//            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.CanDeleteAccount)
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<RemoveAccountSetting> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
//                DispatchQueue.main.async {
//                    passthroughModelSubject.send(data)
                if data.data?.deleteAccountButtonVisible ?? false{
                    self.CanDeleteaccount = true
                }
//                    LoginManger.saveUser(data.data)
//                }
            }else {
                if data.messageCode == 400{
//                message = data.message ?? "error 400"
//                    isAlert = true

                }else if data.messageCode == 401{
//                    message = "unauthorized"
                }else{
//                    message = "Bad Request"
//                    isAlert = true
                }
                isLoading = false
            }


        }).ensure {
//            isLoading = false
//            message = "success"
        }.catch {  (error) in
//            isAlert = true
//            message = "\(error)"
        }
        }else{
            message =  "Not_Connected".localized(language)
            activeAlert = .NetworkError
//            isAlert = true

            }
    }
    // MARK: - API Services
    func DeleteAccount(){
        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
//            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.DeleteAccount)
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<RemoveAccountModel> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
//                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
//                    LoginManger.saveUser(data.data)
//                }
            }else {
                if data.messageCode == 400{
//                message = data.message ?? "error 400"
//                    isAlert = true

                }else if data.messageCode == 401{
//                    message = "unauthorized"
                }else{
//                    message = "Bad Request"
//                    isAlert = true
                }
                isLoading = false
            }


        }).ensure {
//            isLoading = false
//            message = "success"
        }.catch {  (error) in
//            isAlert = true
//            message = "\(error)"
        }
        }else{
            message =  "Not_Connected".localized(language)
            activeAlert = .NetworkError
            isAlert = true

            }
    }
}
