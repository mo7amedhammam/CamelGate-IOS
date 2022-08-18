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
    @Published  var DriverImageStr = Helper.getDriverimage()

    @Published  var Birthdate = Date()
    @Published  var BirthdateStr = ""
    @Published  var gender = 1
    @Published  var RedisentOptions = 1 // 1: CitizenId, 2:ResidentId , 3: Border
    @Published  var citizenId = ""
    @Published  var residentId = ""
    @Published  var borderId = ""
    @Published  var Email = ""
    @Published  var LicenseNumber = ""
    @Published  var LicenseExpireDate = Date()
    @Published  var LicenseExpireDateStr = ""

    @Published  var TruckTypeId = ""
    @Published  var TruckTypeName = ""
    @Published  var TruckManfacturerId = ""
    @Published  var TruckManfacturerName = ""
    @Published  var TruckManfactureYear = ""

    @Published  var NumberofAxe = ""
    @Published  var TruckPlate = ""
    @Published  var TruckLicense = ""
    @Published  var TruckLicenseIssueDate = Date()
    @Published  var TruckLicenseIssueDateStr = ""

    @Published  var TruckLicenseExpirationDate = Date()
    @Published  var TruckLicenseExpirationDateStr = ""
    
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
        GetDriverInfo()
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
            "StatusId"                         :"\(LoginManger.getUser()?.profileStatusId ?? 0)",
            "DrivingLicense"                       : "\(LicenseNumber)",
            "Email"                                : "\(Email)",
            "Birthdate"                            :
                Birthdate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss")
            ,
            "Gender"                               : "\(gender)",
            "CreateTruckDto.Plate"                 : "\(Int(TruckPlate) ?? 0)",
            "CreateTruckDto.License"               : "\(Int(TruckLicense) ?? 0)",
            "CreateTruckDto.LicenseIssueDate"      :
                TruckLicenseIssueDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss")
            ,
            "CreateTruckDto.LicenseExpirationDate" :
                TruckLicenseExpirationDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss")
            ,
            "CreateTruckDto.NumberofAxe"           : "\(Int( NumberofAxe ) ?? 0)",
            "CreateTruckDto.TruckTypeId"           : "\(Int( TruckTypeId ) ?? 0)",
            "DrivingLicenseExpirationDate"         :
                LicenseExpireDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss")
            ,
            "CreateTruckDto.ProductionYear"        : "\(TruckManfactureYear)",
            "CreateTruckDto.TruckManufacturerId"   : "\(Int( TruckManfacturerId ) ?? 0)"
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

//                    DispatchQueue.main.async { [self] in
                self.DriverImageStr = data.data?.image ?? ""
                    LicenseNumber = data.data?.drivingLicense ?? ""
                    Email = data.data?.email ?? ""
                    gender =  data.data?.gender ?? 1
                    TruckPlate = "\( data.data?.truckInfo?.plate ?? 0)"
                    TruckTypeId = "\( data.data?.truckInfo?.truckTypeId ?? 0)"
                    TruckManfacturerId = "\( data.data?.truckInfo?.truckManufacturerId ?? 0)"
                    TruckManfactureYear = "\( data.data?.truckInfo?.productionYear ?? 0)"
                        
                    NumberofAxe = "\( data.data?.truckInfo?.numberofAxe ?? 0)"
                    TruckLicense = "\( data.data?.truckInfo?.license ?? 0)"
                      
                    LicenseExpireDate = convDateToDate(input: data.data?.drivingLicenseExpirationDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                    LicenseExpireDateStr = LicenseExpireDate.DateToStr(format: "dd-MM-yyyy")
                    
                    TruckLicenseIssueDate = convDateToDate(input: data.data?.truckInfo?.licenseIssueDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                    TruckLicenseIssueDateStr = TruckLicenseIssueDate.DateToStr(format: "dd-MM-yyyy")
                
                    TruckLicenseExpirationDate = convDateToDate(input: data.data?.truckInfo?.licenseExpirationDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                    TruckLicenseExpirationDateStr = TruckLicenseExpirationDate.DateToStr(format: "dd-MM-yyyy")

                    Birthdate = convDateToDate(input: data.data?.birthdate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                    BirthdateStr = Birthdate.DateToStr(format: "dd-MM-yyyy")
                    
//                    }
                
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

