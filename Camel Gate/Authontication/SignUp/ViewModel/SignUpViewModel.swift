//
//  SignUpViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
//    let passthroughModelSubject = PassthroughSubject<BaseResponse<LoginModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int
    
    // ------- input
    @Published  var Drivername: String = ""
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber != "" && ( self.phoneNumber.count < 11 || self.phoneNumber.count > 11) {
                validations = .PhoneNumber
                self.ValidationMessage = "Enter_a_valid_Phone_number"
            }
//            else if self.phoneNumber.isEmpty {
//                validations = .PhoneNumber
//                self.ValidationMessage = "*"
//            }
            else if self.phoneNumber.count == 11 {
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
    @Published  var confirmpassword = "" {
        didSet{
            if confirmpassword != "" && ( password !=  confirmpassword) {
                validations = .ConfirmPassword
                self.ValidationMessage = "Passwords_does_not_match"
            }else{
                validations = .none
                self.ValidationMessage = ""
            }
        }
     }

    
    //------- output
    @Published var validations: InvalidFields = .none
    @Published var ValidationMessage = ""
//    @Published var inlineErrorPassword = ""
//    @Published var publishedUserLogedInModel: LoginModel? = nil
    @Published var isLogedin = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    @Published var destination = AnyView(TabBarView())
    init(limit: Int = 11) {
        characterLimit = limit

//        passthroughModelSubject.sink { (completion) in
//        } receiveValue: { [self](modeldata) in
//            publishedUserLogedInModel = modeldata.data
//            if publishedUserLogedInModel?.ProfileStatus == 0 {
//                destination = AnyView(PersonalDataView())
//            }else if publishedUserLogedInModel?.ProfileStatus == 1{
//                destination = AnyView(MedicalStateView())
//
//            }else if self.publishedUserLogedInModel?.ProfileStatus == 2{
//                Helper.setUserData(Id: publishedUserLogedInModel?.Id ?? 0, PhoneNumber: publishedUserLogedInModel?.Phone ?? "", patientName: publishedUserLogedInModel?.Name ?? "" )
//                Helper.setUserimage(userImage: URLs.BaseUrl+"\(publishedUserLogedInModel?.Image ?? "")")
//                destination = AnyView(TabBarView())
//            }
//            Helper.setAccessToken(access_token: "Bearer " + "\(publishedUserLogedInModel?.Token ?? "")" )
//
//        }.store(in: &cancellables)
        
    }
}
