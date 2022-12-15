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
    let PhoneNumLength: Int = 9
    let LicenseNumLength: Int = 10
    
    
    // ------- input
    @Published  var Drivername: String = ""
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber != "" && ( self.phoneNumber.count < PhoneNumLength || self.phoneNumber.count > PhoneNumLength) {
                validations = .PhoneNumber
                self.ValidationMessage = "Enter_a_valid_Phone_number"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.phoneNumber.count == PhoneNumLength {
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
    @Published  var NationalityId = 1
    @Published  var nationalityName = ""
    
    @Published  var RedisentOptions = 1 // 1: CitizenId, 2:ResidentId , 3: Border
    @Published  var RedisentNumLength: Int = 10 //10:CitizenId(start by 1), 16:ResidentId(start by 2), 16:Border(start by 5)
    @Published  var RedisentHint = "Hint:_Citizen_ID_should_start_with_1_with_maximum_10_Numbers"
    @Published  var LicenseHint = "Hint:_License_Number_should_Be_10_Numbers"
    
    @Published  var citizenId = ""{
        didSet{
            let filtered = citizenId.filter {$0.isNumber}
            if citizenId != filtered {
                citizenId = filtered
            }
            if self.citizenId != "" && ( self.citizenId.count < RedisentNumLength || self.citizenId.count > RedisentNumLength) || self.citizenId.prefix(1) != "1" {
                validations = .ResidentId
                self.ValidationMessage = "Id_must_be_10_Starting_with_1"
            }
            else if self.citizenId.count == RedisentNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.citizenId == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    @Published  var residentId = ""{
        didSet{
            let filtered = residentId.filter {$0.isNumber}
            if residentId != filtered {
                residentId = filtered
            }
            if self.residentId != "" && ( self.residentId.count < RedisentNumLength || self.residentId.count > RedisentNumLength) || self.residentId.prefix(1) != "2"{
                validations = .ResidentId
                self.ValidationMessage = "Id_must_be_16_Starting_with_2"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.residentId.count == RedisentNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.residentId == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    @Published  var borderId = ""{
        didSet{
            let filtered = borderId.filter {$0.isNumber}
            if borderId != filtered {
                borderId = filtered
            }
            if self.borderId != "" && ( self.borderId.count < RedisentNumLength || self.borderId.count > RedisentNumLength) || self.borderId.prefix(1) != "5" {
                validations = .ResidentId
                self.ValidationMessage = "Id_must_be_16_Starting_with_5"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.borderId.count == RedisentNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.borderId == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    
    @Published  var Email = ""
    @Published  var LicenseNumber = ""{
        didSet{
            let filtered = LicenseNumber.filter {$0.isNumber}
            if LicenseNumber != filtered {
                LicenseNumber = filtered
            }
            if (self.LicenseNumber != "" && ( self.LicenseNumber.count < LicenseNumLength || self.LicenseNumber.count > LicenseNumLength)) || self.LicenseNumber.prefix(1) != "1" {
                validations = .DriverLicense
                self.ValidationMessage = "Enter_a_valid_License_number"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.LicenseNumber.count == LicenseNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.LicenseNumber == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    
    @Published  var LicenseExpireDate = Date()
    @Published  var LicenseExpireDateStr = ""
    
    @Published  var TruckTypeId = ""
    @Published  var TruckTypeName = ""
    @Published  var TruckManfacturerId = ""
    @Published  var TruckManfacturerName = ""
    @Published  var TruckManfactureYear = ""
    
    @Published  var NumberofAxe = ""
    @Published  var TruckPlate = ""
    @Published  var TruckLicense = ""{
        didSet{
            let filtered = TruckLicense.filter {$0.isNumber}
            if TruckLicense != filtered {
                TruckLicense = filtered
            }
            if (self.TruckLicense != "" && ( self.TruckLicense.count < LicenseNumLength || self.TruckLicense.count > LicenseNumLength)) || self.TruckLicense.prefix(1) != "1" {
                validations = .TruckLicense
                self.ValidationMessage = "Enter_a_valid_License_number"
            }
            //            else if self.phoneNumber.isEmpty {
            //                validations = .PhoneNumber
            //                self.ValidationMessage = "*"
            //            }
            else if self.TruckLicense.count == LicenseNumLength {
                validations = .none
                self.ValidationMessage = ""
            }
            else if self.TruckLicense == "" {
                validations = .none
                self.ValidationMessage = ""
            }
        }
    }
    @Published  var TruckLicenseIssueDate = Date()
    @Published  var TruckLicenseIssueDateStr = ""
    
    @Published  var TruckLicenseExpirationDate = Date()
    @Published  var TruckLicenseExpirationDateStr = ""
    
    @Published var IsTermsAgreed = false
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
//    @Published var publishedUserLogedInModel: DriverInfoModel? = nil
    @Published var UserCreated = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(TabBarView())
    init() {
        GetDriverInfo()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
//            self?.publishedUserLogedInModel = modeldata.data
            self?.UserCreated = true
            Helper.setUserData(DriverName: modeldata.data?.name ?? "", DriverImage: modeldata.data?.image ?? "")
            Helper.IsLoggedIn(value: true)
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func CompleteProfile(){
        if Helper.isConnectedToNetwork(){
        var params : [String : Any] =
        [
            "StatusId"                         :"\(LoginManger.getUser()?.profileStatusId ?? 0)",
            "DrivingLicense"                       : LicenseNumber,
            "Email"                                : Email,
            "Name"                                : Drivername,
            "Birthdate"                            :
                Birthdate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss",isPost: true)
            ,
            "Gender"                               : gender,
            "NationalityId"                        : NationalityId,
            "CreateTruckDto.Plate"                 : "\(Int(TruckPlate) ?? 0)",
            "CreateTruckDto.License"               : Int(TruckLicense) ?? 0,
            "CreateTruckDto.LicenseIssueDate"      :
                TruckLicenseIssueDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss",isPost: true)
            ,
            "CreateTruckDto.LicenseExpirationDate" :
                TruckLicenseExpirationDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss",isPost: true)
            ,
            "CreateTruckDto.NumberofAxe"           : Int( NumberofAxe ) ?? 0,
            "CreateTruckDto.TruckTypeId"           : Int( TruckTypeId ) ?? 0,
            "DrivingLicenseExpirationDate"         :
                LicenseExpireDate.DateToStr(format: "yyyy-MM-dd'T'HH:mm:ss.sss",isPost: true)
            ,
            "CreateTruckDto.ProductionYear"        : TruckManfactureYear,
            "CreateTruckDto.TruckManufacturerId"   : Int( TruckManfacturerId ) ?? 0
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
//            print(result)
//            print(data)
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
                isAlert.toggle()
            }
        }).ensure { [self] in
            isLoading = false
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }else{
        message =  "Not_Connected"
        activeAlert = .NetworkError
        isAlert = true
    }
    }
    
    // MARK: - API Services
    func GetDriverInfo(){
        if Helper.isConnectedToNetwork(){
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.GetDriverinfo)
        }.done({ [self] response in
            let result = response as! Response
            if result.statusCode == 401 {
                activeAlert = .unauthorized
                message = "You_have_To_Login_Again".localized(language)
                isAlert = true
            }else{
                //                        guard BGNetworkHelper.validateResponse(response: result) else{return}
                let data : BaseResponse<DriverInfoModel> = try BGDecoder.decode(data: result.data )
//                print(result)
                print(data)
                if data.success == true {
//                    DispatchQueue.main.async { [self] in
                        Drivername = data.data?.name ?? ""
                        DriverImageStr = data.data?.image ?? ""
                        LicenseNumber = data.data?.drivingLicense ?? ""
                        Email = data.data?.email ?? ""
                        gender =  data.data?.gender ?? 1
                        TruckPlate = "\( data.data?.truckInfo?.plate ?? "")"
                        TruckTypeId = "\( data.data?.truckInfo?.truckTypeId ?? 0)"
                        TruckTypeName = data.data?.truckInfo?.truckTypeName ?? ""
                        TruckManfacturerId = "\( data.data?.truckInfo?.truckManufacturerId ?? 0)"
                        TruckManfacturerName = data.data?.truckInfo?.truckManufacturerName ?? ""
                        TruckManfactureYear = "\( data.data?.truckInfo?.productionYear ?? 0)"
                        NationalityId = data.data?.nationalityId ?? 0
                        nationalityName = data.data?.nationalityName ?? ""
                        NumberofAxe = "\( data.data?.truckInfo?.numberofAxe ?? 0)"
                        TruckLicense = "\( data.data?.truckInfo?.license ?? 0)"
                        
                        LicenseExpireDate = convDateToDate(input: data.data?.drivingLicenseExpirationDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                        LicenseExpireDateStr = LicenseExpireDate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
                        
                        TruckLicenseIssueDate = convDateToDate(input: data.data?.truckInfo?.licenseIssueDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                        TruckLicenseIssueDateStr = TruckLicenseIssueDate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
                        
                        TruckLicenseExpirationDate = convDateToDate(input: data.data?.truckInfo?.licenseExpirationDate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                        TruckLicenseExpirationDateStr = TruckLicenseExpirationDate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
                        
                        Birthdate = convDateToDate(input: data.data?.birthdate ?? "" , format: "yyyy-MM-dd'T'HH:mm:ss")
                        BirthdateStr = Birthdate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
                        
                        if data.data?.citizenId != nil{
//                            RedisentNumLength = 10
                            RedisentOptions = 1
                            citizenId = data.data?.citizenId ?? ""
                        } else if data.data?.residentId != nil{
//                            RedisentNumLength = 10
                            RedisentOptions = 2
                            residentId = data.data?.residentId ?? ""
                        } else if data.data?.borderId != nil{
//                            RedisentNumLength = 16
                            RedisentOptions = 3
                            borderId = data.data?.borderId ?? ""
                        }
                        
//                    }
                    
                }else {
                    //                if data.messageCode == 400{
                    //                    message = data.message ?? "error 400"
                    //                }else if data.messageCode == 401{
                    //                    message = "unauthorized"
                    //                }else{
                    message = data.message ?? "Bad Request"
                    //                }
                    isAlert = true
                }
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
}

