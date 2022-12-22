//
//  SignInViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import Foundation
import SwiftUI
import Combine
import Moya
import PromiseKit
import Alamofire


class SignInViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<LoginModel>, Error>()
    private let authServices = MoyaProvider<AuthServices>()
    private var cancellables: Set<AnyCancellable> = []
    let PhoneNumLength: Int = 9

    // ------- input
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
    
    @Published  var password = ""
    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
    @Published var publishedUserLogedInModel: LoginModel? = nil
    @Published var isLogedin = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var destination = AnyView(EditProfileInfoView(taskStatus: .create, selectedDate: Date()))
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [weak self](modeldata) in
            DispatchQueue.main.async {
                self?.publishedUserLogedInModel = modeldata.data
                if self?.publishedUserLogedInModel?.profileStatusId == 1 {
                    self?.destination = AnyView(EditProfileInfoView(taskStatus: .create,enteredDriverName: modeldata.data?.name ?? "")
                                            .navigationBarHidden(true))

                }else if self?.publishedUserLogedInModel?.profileStatusId == 2{
                    self?.destination = AnyView(TabBarView()
                                            .navigationBarHidden(true))
                    Helper.setUserData( DriverName: self?.publishedUserLogedInModel?.name ?? "", DriverImage: self?.publishedUserLogedInModel?.image ?? "" )
                    LoginManger.saveUser(modeldata.data)
                    Helper.IsLoggedIn(value: true)
                }
                Helper.setAccessToken(access_token: "Bearer " + "\(self?.publishedUserLogedInModel?.token ?? "")" )
                self?.isLoading = false
                self?.isLogedin = true
            }
            
        }.store(in: &cancellables)
    }
    
    // MARK: - API Services
    func Login(){
        let params : [String : Any] =
        [
            "roleId"                       : 8,
            "mobile"                       : phoneNumber ,
            "password"                    : password
        ]
        firstly { () -> Promise<Any> in
            isLoading = true
            return BGServicesManager.CallApi(self.authServices,AuthServices.Login(parameters: params))
        }.done({ [self] response in
            let result = response as! Response

            guard BGNetworkHelper.validateResponse(response: result) else{return}
            let data : BaseResponse<LoginModel> = try BGDecoder.decode(data: result.data )
            print(data)
            if data.success == true {
                DispatchQueue.main.async {
                    passthroughModelSubject.send(data)
                    LoginManger.saveUser(data.data)
//                    isLogedin = true
                }
            }else {
                if data.messageCode == 400{
                message = data.message ?? "error 400"
                    isAlert = true

                }else if data.messageCode == 401{
                    message = "unauthorized"
                }else{
                    message = "Bad Request"
                    isAlert = true
                }
                isLoading = false
            }


        }).ensure {
//            isLoading = false
//            message = "success"
        }.catch { [self] (error) in
            isAlert = true
            message = "\(error)"
        }
    }
}


public extension String {
    
    func replacedArabicDigitsWithEnglish()-> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        let engNumber = numberFormatter.number(from: self)
        return "\(engNumber ?? 0)"
    }

    /// To convert English numbers to Arabic / Persian
    /// - Returns: returns Arabic number
    func replacedEnglishDigitsWithArabic()-> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ar")
        let arabicNumber = numberFormatter.number(from: self)
        return "\(arabicNumber ?? 0)"
    }
    
    
    
//    var replacedArabicDigitsWithEnglish: String {
//    var str = self
//    let map = ["٠": "0",
//               "١": "1",
//               "٢": "2",
//               "٣": "3",
//               "٤": "4",
//               "٥": "5",
//               "٦": "6",
//               "٧": "7",
//               "٨": "8",
//               "٩": "9"]
//    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
//    return str
//}
//    var replacedEnglishDigitsWithArabic: String {
//    var str = self
//    let map = ["0": "٠",
//               "1": "١",
//               "2": "٢",
//               "3": "٣",
//               "4": "٤",
//               "5": "٥",
//               "6": "٦",
//               "7": "٧",
//               "8": "٨",
//               "9": "٩"]
//    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
//    return str
//}
}
