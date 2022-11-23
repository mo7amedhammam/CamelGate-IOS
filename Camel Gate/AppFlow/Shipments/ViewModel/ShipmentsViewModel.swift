//
//  ShipmentsViewModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/7/22.
//

//import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

enum DriverShipments{
    case current, Upcomming, applied
}
class ShipmentsViewModel : ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<FilteredShipmentModel>, Error>()
    private let Services = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var GetShipmentsOp : GetShipmentsOperations = .fetchshipments

    @Published var MaxResultCount                      :Int = 10
    @Published var SkipCount                            :Int = 0

    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedShipmentsArr: [ShipmentModel] = []
    @Published var UserCreated = false
    @Published var nodata = false
    @Published var shipmentscount = 0
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        GetShipment(type: .applied, operation: .fetchshipments)
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            self?.nodata = false
//            withAnimation{
//                publishedShipmentsArr = []
//            }
            DispatchQueue.main.async {
                if modeldata.data?.items?.isEmpty ?? false || modeldata.data?.items == []{
                    self?.nodata = true
                }else{
                    switch self?.GetShipmentsOp {
                    case .fetchshipments:
                        if modeldata.data?.items?.isEmpty ?? false || modeldata.data?.items == []{
                            self?.nodata = true
                        }else{
                            self?.publishedShipmentsArr = modeldata.data?.items ?? []
                        }
                    case .fetchmoreshipments:
                        if modeldata.data?.items?.count ?? 0 > 0{
                            self?.publishedShipmentsArr.append( contentsOf: modeldata.data?.items ?? [])
                        }else{
                        }
                    case .none:
                        return
                    }
                    
//                    withAnimation{
//                        publishedUserLogedInModel = modeldata.data ?? []
//                        shipmentscount = modeldata.data?.count ?? 0
//                    }
                    self?.UserCreated = true
                    print(self?.publishedShipmentsArr )
                }
            }
        }.store(in: &cancellables)
    }
    
    func GetShipment(type:DriverShipments,operation:GetShipmentsOperations){
        self.GetShipmentsOp = operation
        print("here is \(type)")
        let param = [
            "maxResultCount":MaxResultCount,
            "skipCount" : SkipCount
//            ,"offerStatusId":offerStatusId
        ]

        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.Services, type == .current ?  HomeServices.currentShipments(parameters: param) : type == .Upcomming ? HomeServices.upComingShipments(parameters: param) : HomeServices.appliedShipMents(parameters: param) )
        }.done({ [self] response in
            let result = response as! Response
            
            if result.statusCode == 401 {
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }else{
                //            guard BGNetworkHelper.validateResponse(response: result) else{return}
                let data : BaseResponse<FilteredShipmentModel> = try BGDecoder.decode(data: result.data )
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



