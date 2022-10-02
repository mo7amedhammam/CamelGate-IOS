//
//  NoteScreenView.swift
//  Camel Gate
//
//  Created by wecancity on 26/07/2022.
//

import SwiftUI

struct NoteScreenView: View {
    var language = LocalizationService.shared.language
    
    @StateObject var resendOTPVM = ResendOTPViewModel()

    @State var presentPhoneVerify = false
    @State var gotonewpassword = false

//    var op : operations
    @State var phoneNumber : String = ""
//    @Binding var CurrentOTP : Int
//    @Binding var validFor : Int
    @State var matchedOTP : Bool = false
//    @Binding var isPresented : Bool
    var body: some View {
        ZStack{
            VStack{
                Image("lock-orange")
                Text("We_have_to_confirm_your\n_identity_by_sending_a_code_to_\nyour_phone_number".localized(language))
                    .font(Font.camelfonts.Reg18)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                
                HStack{
                    Text("Code_will_be_sent_to_+699".localized(language))
                                        
                    Text(resendOTPVM.phoneNumber)
                        .foregroundColor(Color("Second_Color"))
                }
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                .multilineTextAlignment(.center)

                    InputTextField(iconName: "phoneBlue", fieldType: .Phone, placeholder: "Enter_your_phone_number".localized(language), text: $resendOTPVM.phoneNumber)
                        .padding(.horizontal)
                        .onChange(of: resendOTPVM.phoneNumber){ newval in
                            resendOTPVM.phoneNumber =  String(newval.prefix(resendOTPVM.PhoneNumLength))
                        }

                GradientButton(action: {
                                            resendOTPVM.phoneNumber = phoneNumber
                                            resendOTPVM.SendOTP()
                }, Title: "Send_OTP".localized(language),IsDisabled:.constant(resendOTPVM.phoneNumber == "" || resendOTPVM.ValidationMessage != "") )
                    .padding(.top,50)
            }
            
            TitleBar(Title: "Change_Password".localized(language), navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
        .onChange(of: resendOTPVM.verifyUser , perform: {newval in
            if newval == true{
                presentPhoneVerify.toggle()
            }
        })
        .onAppear(perform: {
            resendOTPVM.phoneNumber = phoneNumber
        })
        
        .fullScreenCover(isPresented: $presentPhoneVerify , onDismiss: {
            if resendOTPVM.isMatchedOTP == true {
                gotonewpassword.toggle()
            }
        }, content: {
            PhoneVerificationView(op: .password, phoneNumber: $phoneNumber, CurrentOTP: $resendOTPVM.NewCode ,validFor: $resendOTPVM.NewSecondsCount , matchedOTP: $resendOTPVM.isMatchedOTP, isPresented: $presentPhoneVerify)
        })
        
        
        NavigationLink(destination: ChangePasswordView(phoneNumber:resendOTPVM.phoneNumber,operation: .forget),isActive:$gotonewpassword, label: {
                })
    }
}

struct NoteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NoteScreenView( phoneNumber: "")
    }
}
