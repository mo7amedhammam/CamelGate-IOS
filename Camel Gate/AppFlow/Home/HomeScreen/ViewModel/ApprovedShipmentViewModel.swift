//
//  ApprovedShipmentViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 06/08/2022.
//
import Foundation
//import SwiftUI
import Combine
import Moya
import PromiseKit

enum approvedshipmentOperations {
case start, Upload, finish
}

enum GetShipmentsOperations{
    case fetchshipments, fetchmoreshipments
}

class ApprovedShipmentViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ApprovedShipmentModel>, Error>()
    let passToFilteredShipmentsObject = PassthroughSubject<BaseResponse<FilteredShipmentModel>, Error>()

    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var GetShipmentsOp : GetShipmentsOperations = .fetchshipments
    @Published var ApprovedShipmentsOp : approvedshipmentOperations = .start

    @Published var MaxResultCount                      :Int = 10
    @Published var SkipCount                            :Int = 0

    @Published var ApprovedshipmentId = 0
    @Published var CanRateApprovedshipment = false
    
    
    @Published var lat = 0.0
    @Published var lang = 0.0
    @Published var fromCityId = 0
    @Published var fromCityName = ""

    @Published var toCityId = 0
    @Published var toCityName = ""
    
    @Published var fromDate  = Date()
    @Published var toDate = Date()
    @Published var fromDateStr  = ""
    @Published var toDateStr = ""
    @Published var shipmentTypesIds:[Int] = []
    @Published var shipmentTypesNames:[String] = []

    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedapprovedShipmentModel: ApprovedShipmentModel? = nil
    @Published var publishedFilteredShipments: [ShipmentModel] = []

    @Published var UserCreated = false
    @Published var nodata = false
    @Published var nomoredata = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
//    @Published var destination = AnyView(TabBarView())
    init() {
        
//        GetApprovedShipment()
//        GetFilteredShipments(operation: .fetchshipments)
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            self?.publishedapprovedShipmentModel = modeldata.data
            self?.ApprovedshipmentId = self?.publishedapprovedShipmentModel?.id ?? 0
            if modeldata.success ?? false && self?.ApprovedShipmentsOp == .finish{
                self?.CanRateApprovedshipment = true
            }
        }.store(in: &cancellables)
        
        passToFilteredShipmentsObject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            self?.nodata = false
            DispatchQueue.main.async {
                if (modeldata.data?.items?.isEmpty ?? false || modeldata.data?.items == []) && self?.GetShipmentsOp == .fetchshipments{
//                    withAnimation{
                        self?.publishedFilteredShipments = []
//                    }
                    self?.nodata = true
                }else{
                    switch self?.GetShipmentsOp {
                    case .fetchshipments:
                        self?.publishedFilteredShipments = modeldata.data?.items ?? []
//                        if modeldata.data?.isEmpty ?? false || modeldata.data == []{
//                            nodata = true
//                        }
                    case .fetchmoreshipments:
                        if modeldata.data?.items?.count ?? 0 > 0{
                            self?.publishedFilteredShipments.append( contentsOf: modeldata.data?.items ?? [])
                        }else{
                            self?.nomoredata = true
//                            self?.SkipCount = self?.publishedFilteredShipments.count ?? 0
                        }
                    case .none:
                        return
                    }
                    
//                    withAnimation{
//                        publishedFilteredShipments = modeldata.data ?? []
//                    }
                }
            }
        }.store(in: &cancellables)
        
    }
    
    // MARK: - API Services
    func GetApprovedShipment(){
//        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
//            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.GetApprovedShipment)
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ApprovedShipmentModel> = try BGDecoder.decode(data: result.data )
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
//        }else{
//            message =  "Not_Connected".localized(language)

//            activeAlert = .NetworkError
//            isAlert = true
//        }
    }

    //MARK: ------ approved shipment operation -----
    func ApprovedAction(operation: approvedshipmentOperations){
        self.ApprovedShipmentsOp = operation
        let params : [String : Any] =
        [
            "shipmentId"                          : ApprovedshipmentId
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            print(operation)
            print(params)
            return BGServicesManager.CallApi(self.authServices, operation == .Upload ? HomeServices.UploadApprovedShipment(parameters: params): operation == .finish ? HomeServices.FinishApprovedShipment(parameters: params): HomeServices.StartApprovedShipment(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ApprovedShipmentModel> = try BGDecoder.decode(data: result.data )
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
    
    // MARK: - API Services
    func GetFilteredShipments(operation:GetShipmentsOperations){
        if Helper.isConnectedToNetwork(){
        
        
        self.GetShipmentsOp = operation
        var params : [String : Any] =
        [
            "maxResultCount": MaxResultCount,
            "skipCount":SkipCount
        ]
        if lat != 0.0{
            params["lat"] = lat
        }
        if lang != 0.0{
            params["lang"] = lang
        }
        if fromCityId != 0{
            params["fromCityId"] = fromCityId
        }
        if toCityId != 0{
            params["toCityId"] = toCityId
        }
        if fromDateStr != "" {
            params["fromDate"] = fromDate.DateToStr(format:"yyy-MM-dd'T'HH:mm:ss.sss")
        }
        if toDateStr != "" {
            params["toDate"] = toDate.DateToStr(format:"yyy-MM-dd'T'HH:mm:ss.sss")
        }
        if !shipmentTypesIds.isEmpty{
            params["shipmentTypes"] = shipmentTypesIds
        }
        
        firstly { () -> Promise<Any> in
            isLoading = true
            print(params)
            return BGServicesManager.CallApi(self.authServices,HomeServices.HomeShipmments(parameters: params))
        }.done({ [self] response in
            let result = response as! Response
            print(result)
            if result.statusCode == 401{
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }
            else{
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<FilteredShipmentModel> = try BGDecoder.decode(data: result.data )
            print(data)
                if data.messageCode == 200 {
                DispatchQueue.main.async {
                    passToFilteredShipmentsObject.send(data)
                }
            }else {
                    message = data.message ?? "error 400"
                isAlert = true
            }
            }
        }).ensure { [self] in
            isLoading = false
        }.catch { [self] (error) in
            print(error)
            print(error.localizedDescription)
//            isAlert = true
//            message = "\(error)"
            isLoading = false
        }
    }else{
        message =  "Not_Connected".localized(language)
        activeAlert = .NetworkError
        isAlert = true
    }
    }

    func resetFilter(){
        fromCityId = 0
        fromCityName = ""
        toCityId = 0
        toCityName = ""
        fromDate = Date()
        fromDateStr = ""
        toDate = Date()
        toDateStr = ""
        shipmentTypesIds   = []
        shipmentTypesNames = []
        GetFilteredShipments(operation: .fetchshipments)
    }
}
