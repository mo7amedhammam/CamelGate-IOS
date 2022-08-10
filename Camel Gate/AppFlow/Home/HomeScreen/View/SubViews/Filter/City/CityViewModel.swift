//
//  CityViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 10/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit
import Alamofire


class CityViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[CityModel]>, Error>()
    private let authServices = MoyaProvider<HomeServices>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    
    @Published  var GovernorateId = 0
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedCitiesArray: [CityModel] = []
    @Published var isLogedin = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(EditProfileInfoView(taskStatus: .create, selectedDate: Date()))
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            DispatchQueue.main.async {
                publishedCitiesArray = modeldata.data ?? []
            }
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func GetCiities(){
        let params : [String : Any] =
        [
            "GovernorateId"                       : GovernorateId
        ]
        
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,HomeServices.GetCities(parameters: params))
        }.done({ [self] response in
            let result = response as! Response

            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<[CityModel]> = try BGDecoder.decode(data: result.data )
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
