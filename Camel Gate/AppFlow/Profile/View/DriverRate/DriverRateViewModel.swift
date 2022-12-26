//
//  DriverRateViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 08/12/2022.
//

import Combine
import Moya
import PromiseKit

class DriverRateViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<DriverRateModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []

    // ------- input
    @Published  var DriverRate = 0.0
    
    @Published  var DriverRatesCount = 0
    //------- output
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
//        GetDriverRate()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            DispatchQueue.main.async {
                self?.DriverRate = modeldata.data?.rate ?? 0
                self?.DriverRatesCount = modeldata.data?.ratesCount ?? 0
                }
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetDriverRate(){
        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
//            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.GetDriverOverAllRate)
        }.done({ [self] response in
            let result = response as! Response

//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<DriverRateModel> = try BGDecoder.decode(data: result.data )
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
//                isLoading = false
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
