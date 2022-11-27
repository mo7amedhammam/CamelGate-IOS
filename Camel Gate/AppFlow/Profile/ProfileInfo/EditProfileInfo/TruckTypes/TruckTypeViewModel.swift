//
//  TruckTypeViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 13/08/2022.
//
import Foundation
//import SwiftUI
import Combine
import Moya
import PromiseKit
//import Alamofire

class TruckTypeViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[TruckTypeModel]>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    //------- output
    @Published var publishedTypesArray: [TruckTypeModel] = []
    @Published var isLogedin = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        GetTruckTypes()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
//            DispatchQueue.main.async {
            self?.publishedTypesArray = modeldata.data ?? []
//            }
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetTruckTypes(){
        
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.GetTruckType)
        }.done({ [self] response in
            let result = response as! Response

//            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[TruckTypeModel]> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
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
