//
//  RateViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 27/11/2022.
//

import Combine
import Moya
import PromiseKit

class RateViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<rateModel>, Error>()

    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var shipmentId = 0
    @Published var shipmentOfferId = 0
    @Published var rate = 0

    //------- output
    @Published var PublishedHomePageWalletModel: rateModel? = nil
    @Published var rateSentSucces = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        sendRate()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
//            self?.PublishedHomePageWalletModel = modeldata.data
            if modeldata.success ?? false{
                self?.rateSentSucces = true
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func sendRate(){
        firstly { () -> Promise<Any> in
            isLoading = true
            let params : [String : Any] =
            [
                "shipmentId"                             : shipmentId,
                "shipmentOfferId"                       : shipmentOfferId,
                "rate"                                    : rate
            ]
            return BGServicesManager.CallApi(self.authServices,HomeServices.RateApprovedShipment(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<rateModel> = try BGDecoder.decode(data: result.data )
            print(result)

            if data.success == true {
//                DispatchQueue.main.async {
                print(data)
                    passthroughModelSubject.send(data)
//                }
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
//            isAlert = true
//            message = "\(error)"
            isLoading = false
        }
    }
 }
