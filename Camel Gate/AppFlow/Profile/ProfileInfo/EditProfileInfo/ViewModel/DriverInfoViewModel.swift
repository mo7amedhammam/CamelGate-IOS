//
//  DriverInfoViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 04/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit

class DriverInfoViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<DriverInfoModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int = 14
    
    // ------- input
    @Published  var Drivername: String = ""
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber != "" && ( self.phoneNumber.count < characterLimit || self.phoneNumber.count > characterLimit) {
                validations = .PhoneNumber
                self.ValidationMessage = "Enter_a_valid_Phone_number"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.phoneNumber.count == characterLimit {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.phoneNumber == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    @Published  var DriverImage = UIImage()
    @Published  var Birthdate : Date? 
    @Published  var gender = 1
    @Published  var RedisentOptions = 1 // 1: CitizenId, 2:ResidentId , 3: Border
    @Published  var citizenId = ""
    @Published  var residentId = ""
    @Published  var borderId = ""
    @Published  var Email = ""
    @Published  var LicenseNumber = ""
    @Published  var LicenseExpireDate : Date?
    
    @Published  var TruckTypeId = ""
    @Published  var NumberofAxe = ""
    @Published  var TruckPlate = ""
    @Published  var TruckLicense = ""
    @Published  var TruckLicenseIssueDate : Date?
    @Published  var TruckLicenseExpirationDate : Date? 
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: DriverInfoModel? = nil
    @Published var UserCreated = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    
    @Published var destination = AnyView(TabBarView())
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self](modeldata) in
            publishedUserLogedInModel = modeldata.data
            UserCreated = true
            Helper.setUserData(DriverName: publishedUserLogedInModel?.name ?? "", DriverImage: publishedUserLogedInModel?.image ?? "")
        }.store(in: &cancellables)
        
    }
    
    // MARK: - API Services
    func CompleteProfile(){
        var params : [String : Any] =
        [
//            "Id"                                   : "\(8)" ,
            "DrivingLicense"                       : "\(LicenseNumber)",
            "Email"                                : "\(Email)",
            "Birthdate"                            :
//                "\(ConvertDateFormat(inp: Birthdate ?? Date(), FormatTo: "yyy-MM-dd'T'HH:mm:ss.sss"))"
            ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: Birthdate ?? Date() )
            ,
            "Gender"                               : "\(gender)",
            "CreateTruckDto.Plate"                 : "\(Int(TruckPlate) ?? 0)",
            "CreateTruckDto.License"               : "\(Int(TruckLicense) ?? 0)",
            "CreateTruckDto.LicenseIssueDate"      :
            ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: TruckLicenseIssueDate ?? Date() )
            ,
            "CreateTruckDto.LicenseExpirationDate" :
            ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: TruckLicenseExpirationDate ?? Date() )
            ,
            "CreateTruckDto.NumberofAxe"           : "\(Int( NumberofAxe ) ?? 0)",
            "CreateTruckDto.TruckTypeId"           : "\(Int( TruckTypeId ) ?? 0)",
            "DrivingLicenseExpirationDate"         :
            ChangeFormate(NewFormat: "yyy-MM-dd'T'HH:mm:ss.sss").string(from: LicenseExpireDate ?? Date() )
            ,
            "CreateTruckDto.ProductionYear"        : "\(2020)",
            "CreateTruckDto.TruckManufacturerId"   : "\(2)"
        ]
        // optional
        if citizenId != ""{
            params["CitizenId"] = citizenId
        }
        if residentId != ""{
            params["ResidentId"] = residentId
        }
        if borderId != ""{
            params["BorderId"] = borderId
        }
        let imgs = ["Image":DriverImage]
        
        firstly { () -> Promise<Any> in
            isLoading = true
            print(params)
            return BGServicesManager.CallApi(self.authServices,AuthServices.UpdateDriverInfo(parameters: params, images: imgs))
        }.done({ [self] response in
            let result = response as! Response
            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<DriverInfoModel> = try BGDecoder.decode(data: result.data )
            print(result)
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    UserCreated = true
                }
            }else {
                if data.messageCode == 400{
                    message = data.message ?? "error 400"
                }else if data.messageCode == 401{
                    message = data.message ??  "unauthorized"
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
    
    // MARK: - API Services
    func GetDriverInfo(){
     
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.GetDriverinfo)
        }.done({ [self] response in
            let result = response as! Response
            
//                        guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<DriverInfoModel> = try BGDecoder.decode(data: result.data )
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
}

