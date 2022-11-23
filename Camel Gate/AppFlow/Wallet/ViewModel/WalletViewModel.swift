//
//  WalletViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/11/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

enum WalletTypes{
    case Gained, Withdrawn
}
class WalletViewModel : ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<WalletModel>, Error>()
    private let Services = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserWalletModel: WalletModel = WalletModel.init()
    @Published var UserCreated = false
    @Published var nodata = false
    @Published var shipmentscount = 0
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        GetWallet(type: .Gained)
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            self?.nodata = false
            withAnimation{
                self?.publishedUserWalletModel.shipmentPayments = []
            }
            DispatchQueue.main.async {
                    withAnimation{
                        self?.publishedUserWalletModel = modeldata.data ?? WalletModel.init()
                    }
            }
        }.store(in: &cancellables)
    }
    
    func GetWallet(type:WalletTypes){
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services, type == .Gained ?  HomeServices.getGainedWallet : HomeServices.getWithdrawnWallet )
        }.done({ [self] response in
            let result = response as! Response
            
            if result.statusCode == 401 {
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }else{
//                            guard BGNetworkHelper.validateResponse(response: result) else{return}
                let data : BaseResponse<WalletModel> = try BGDecoder.decode(data: result.data )
                if data.messageCode == 200 {
                    print(data)

                    DispatchQueue.main.async {
                        passthroughModelSubject.send(data)
                    }
                }else{
                    message = data.message ?? "there is an error"
                    isAlert = true
                }
            }
        }).ensure { [self] in
            isLoading = false
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }
}
