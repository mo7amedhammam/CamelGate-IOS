//
//  ShipmentDetailsViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/08/2022.
//

import Foundation
//import SwiftUI
import Combine
import Moya
import PromiseKit

class ShipmentDetailsViewModel : ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ShipmentModel>, Error>()
    private let Services = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var shipmentId = 0

    @Published var driverOffer = ""
    @Published var shipmentOfferId = 0
    @Published var CancelationReasonId = 0
    @Published var CancelationReasonStr = ""

    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: ShipmentModel = ShipmentModel.init()
    @Published var UserCreated = false
    @Published var nodata = false
    @Published var OfferSent = false
    @Published var OfferCanceled = false

    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
//    @Published var destination = AnyView(TabBarView())
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            DispatchQueue.main.async {
                self?.publishedUserLogedInModel = modeldata.data ?? ShipmentModel.init()
                self?.UserCreated = true
//                print(self?.publishedUserLogedInModel )
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetShipmentDetails(){
        if Helper.isConnectedToNetwork(){
        let param = ["shipmentId":shipmentId]
        print("Details")
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.ShipmentDetails(parameters: param))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<ShipmentModel> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
//                    print("data is ")
//                    print(data)
//                    print(data.data ?? [])
                }
            }else {
                if data.messageCode == 400{
                    message = data.message ?? "error 400"
                }else if data.messageCode == 401{
                    message = data.message ?? "unauthorized"
                }else{
                    message = data.message ?? "Bad Request"
                }
                isAlert = true
            }
        }).ensure { [self] in
            isLoading = false
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
        }else{
            message =  "Not_Connected".localized(language)

            activeAlert = .NetworkError
            isAlert = true
        }
    }
    
    func SendOffer() {
        let param : [String : Any] = ["shipmentId":shipmentId,"driverOfferValue":Int(driverOffer) ?? 0]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.setOffer(parameters: param))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<SetOfferModel> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    print(data)
                    OfferSent = true
                }
            }else {
                if data.messageCode == 400{
                    message = data.message ?? "error 400"
                }else if data.messageCode == 401{
                    message = data.message ?? "unauthorized"
                }else{
                    message = data.message ?? "Bad Request"
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
    
    func CancelOffer() {
        let param : [String : Any] = ["shipmentOfferId":shipmentOfferId,"shipmentCancelationReasonId":CancelationReasonId]
        print(param)
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services,HomeServices.CancelOffer(parameters: param))
        }.done({ [self] response in
            let result = response as! Response
            if result.statusCode == 401 {
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }else{
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<CancelOfferModel> = try BGDecoder.decode(data: result.data )
            if data.success == true {
                DispatchQueue.main.async {
                    print(data)
                    OfferCanceled = true
                }
            }else {
                    message = data.message ?? "Bad Request"
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
