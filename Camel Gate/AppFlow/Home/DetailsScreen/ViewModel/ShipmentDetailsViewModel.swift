//
//  ShipmentDetailsViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/08/2022.
//

import Foundation
import SwiftUI
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

    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: ShipmentModel = ShipmentModel.init()
    @Published var UserCreated = false
    @Published var nodata = false

    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            DispatchQueue.main.async {
              
                publishedUserLogedInModel = modeldata.data ?? ShipmentModel.init()
                UserCreated = true
                print(publishedUserLogedInModel )
                
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetShipmentDetails(){
        
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
