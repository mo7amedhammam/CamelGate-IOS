//
//  DriverRatesViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 18/12/2022.
//

import Combine
import Moya
import PromiseKit

class DriverRatesViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[DriverRatesModel]>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []

    // ------- input

    //------- output
//    @Published var validations: InvalidFields = .none
//    @Published var ValidationMessage = ""
    @Published var publishedRatesModel: [DriverRatesModel] = []
    @Published var noReviews = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        GetDriverRates()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            DispatchQueue.main.async {
//                self?.DriverRate = modeldata.data?.rate ?? 0
                self?.publishedRatesModel = modeldata.data ?? []
            }
            if modeldata.data == []{
                self?.noReviews = true
            }
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetDriverRates(){
        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.GetDriverRates)
        }.done({ [self] response in
            let result = response as! Response

//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[DriverRatesModel]> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
//                DispatchQueue.main.async {
                passthroughModelSubject.send(data)
//                    LoginManger.saveUser(data.data)
//                }
            }else {
                if data.messageCode == 400{
                message = data.message ?? "error 400"
                    isAlert = true

                }else if data.messageCode == 401{
                    message = "unauthorized"
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
