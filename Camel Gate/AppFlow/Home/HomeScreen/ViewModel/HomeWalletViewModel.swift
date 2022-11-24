//
//  HomeWalletViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 24/11/2022.
//

import Combine
import Moya
import PromiseKit


class HomeWalletViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<HomePageWalletModel>, Error>()

    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input


    //------- output
    @Published var PublishedHomePageWalletModel: HomePageWalletModel? = nil


    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        GetHomePageWallet()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            self?.PublishedHomePageWalletModel = modeldata.data
        }.store(in: &cancellables)
        
    }
    
    // MARK: - API Services
    func GetHomePageWallet(){
        firstly { () -> Promise<Any> in
//            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.getHomePageWallet)
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<HomePageWalletModel> = try BGDecoder.decode(data: result.data )
            print(result)
            print(data)
            if data.success == true {
//                DispatchQueue.main.async {
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
