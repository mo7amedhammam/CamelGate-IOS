//
//  SignInViewModel.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import Foundation
import SwiftUI
import Combine


class SignInViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
//    let passthroughModelSubject = PassthroughSubject<BaseResponse<LoginModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int = 14
    
    // ------- input
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
    
    @Published  var password = ""
    
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
    init() {

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


