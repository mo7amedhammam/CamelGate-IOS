//
//  ApprovedShipmentViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 06/08/2022.
//
import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

class ApprovedShipmentViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ApprovedShipmentModel>, Error>()
    let passToFilteredShipmentsObject = PassthroughSubject<BaseResponse<[ShipmentModel]>, Error>()

    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var lat = 0
    @Published var lang = 0
    @Published var fromCityId = 0
    @Published var toCityId = 0
    @Published var fromDate  = Date()
    @Published var toDate = Date()
    @Published var shipmentTypes = []
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: ApprovedShipmentModel? = nil
    @Published var publishedFilteredShipments: [ShipmentModel] = []

    @Published var UserCreated = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
//        GetFilteredShipments()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            publishedUserLogedInModel = modeldata.data
//            UserCreated = true
        }.store(in: &cancellables)
        
        
        passToFilteredShipmentsObject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            publishedFilteredShipments = modeldata.data ?? []
        }.store(in: &cancellables)
        
    }
    
    // MARK: - API Services
    func GetApprovedShipment(){
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.GetApprovedShipment)
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ApprovedShipmentModel> = try BGDecoder.decode(data: result.data )
            print(result)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
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
    
    // MARK: - API Services
    func GetFilteredShipments(){
        let params : [String : Any] =
        [
            "lat"                       : lat ,
            "lang"                    : lang,
            "fromCityId"                       : fromCityId ,
            "toCityId"                    : toCityId,
            "fromDate"                       :  ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: fromDate)  ,
            "toDate"                    : ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: toDate),
            "shipmentTypes": shipmentTypes
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            print(params)
            return BGServicesManager.CallApi(self.authServices,HomeServices.HomeShipmments(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[ShipmentModel]> = try BGDecoder.decode(data: result.data )
            print(result)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passToFilteredShipmentsObject.send(data)
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
