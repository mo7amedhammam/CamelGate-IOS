//
//  ShipmentsViewModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/7/22.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

enum DriverShipments{
    case current, Upcomming, applied
}
class ShipmentsViewModel : ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[ShipmentModel]>, Error>()
    private let Services = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: [ShipmentModel] = []
    @Published var UserCreated = false
    @Published var nodata = false
    @Published var shipmentscount = 0
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            nodata = false
            withAnimation{
                publishedUserLogedInModel = []
            }
            DispatchQueue.main.async {
                if modeldata.data?.isEmpty ?? false || modeldata.data == []{
                    nodata = true
                }else{
                    withAnimation{
                        publishedUserLogedInModel = modeldata.data ?? []
                        shipmentscount = modeldata.data?.count ?? 0
                    }
                    UserCreated = true
                    print(publishedUserLogedInModel )
                }
            }
        }.store(in: &cancellables)
    }
    
    func GetShipment(type:DriverShipments){
        print("here is current")
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services, type == .current ?  HomeServices.currentShipments : type == .Upcomming ? HomeServices.upComingShipments : HomeServices.appliedShipMents )
        }.done({ [self] response in
            let result = response as! Response
            
            if result.statusCode == 401 {
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }else{
                //            guard BGNetworkHelper.validateResponse(response: result) else{return}
                let data : BaseResponse<[ShipmentModel]> = try BGDecoder.decode(data: result.data )
                if data.messageCode == 200 {
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



