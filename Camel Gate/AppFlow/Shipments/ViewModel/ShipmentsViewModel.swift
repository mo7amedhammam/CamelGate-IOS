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
    
    // MARK: - API Services
    func GetAppliedShipment(){
        print("here is upplied")
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.appliedShipMents)
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[ShipmentModel]> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    print("data is ")
                    print(data)
                    print(data.data ?? [])
//                    UserCreated = true
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
    func GetUpcomingShipment(){
        print("here is upcomming")
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.upComingShipments)
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[ShipmentModel]> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    print("data is ")
                    print(data)
                    print(data.data ?? [])
//                    UserCreated = true
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
    
    func GetCurrentShipment(){
        print("here is current")

        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.currentShipments)
        }.done({ [self] response in
            let result = response as! Response
//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[ShipmentModel]> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    print("data is ")
                    print(data)
                    print(data.data ?? [])
//                    UserCreated = true
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


