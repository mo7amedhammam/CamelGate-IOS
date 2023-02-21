//
//  SignUpView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var SignUpVM = SignUpViewModel()
    @State var presentPhoneVerify = false
    @State var gotoCompleteProfile = false
    @FocusState var inFocus: Int?
    @State var showsheet = false

    var body: some View {
        ZStack{
            VStack{
                Image("signupheaderpng")
                    .resizable()
                    .padding(.top,hasNotch ? -50:-80)
                    .frame(height:hasNotch ? 300:250)
                
                ScrollView{
                    Image("LOGO")
                        .padding(.horizontal,90)
                    
                    Group{
                        InputTextField(iconName: "person",iconColor: Color("blueColor"), placeholder: "Enter_your_name".localized(language), text: $SignUpVM.Drivername)
                            .focused($inFocus,equals:1)
                            .onTapGesture(perform: {
                                inFocus = 1
                            })
                        
                        InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"),fieldType: .Phone, placeholder: "Enter_your_phone_number".localized(language), text: $SignUpVM.phoneNumber)
                            .keyboardType(.phonePad)
                            .focused($inFocus,equals:2)
                            .onTapGesture(perform: {
                                inFocus = 2
                            })
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth:SignUpVM.validations == .PhoneNumber ? 1:0))
                            .onChange(of: SignUpVM.phoneNumber){ newval in
                                SignUpVM.phoneNumber =  String(newval.prefix(SignUpVM.PhoneNumLength))
                            }
                        
                        if SignUpVM.validations == .PhoneNumber{
                            HStack{
                                Text(SignUpVM.ValidationMessage.localized(language))
                                    .foregroundColor(.red)
                                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                                
                                Spacer()
                            }
                        }
                        
                        SecureInputTextField("Enter_your_password".localized(language), text: $SignUpVM.password, iconName: "lockBlue")
                            .focused($inFocus,equals: 3)
                            .onTapGesture(perform: {
                                inFocus = 3
                            })
//                            .onChange(of: SignUpVM.password, perform: {newval in
//                                if SignUpVM.confirmpassword != "" {
//
//                                }
//                            })
                        SecureInputTextField("Confirm_your_password".localized(language), text: $SignUpVM.confirmpassword, iconName: "lockBlue")
                            .focused($inFocus,equals:4)
                            .onTapGesture(perform: {
                                inFocus = 4
                            })
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth:SignUpVM.validations == .ConfirmPassword ? 1:0))
                        if SignUpVM.validations == .ConfirmPassword || SignUpVM.validations == .Password{
                            HStack{
                                Text(SignUpVM.ValidationMessage.localized(language))
                                    .foregroundColor(.red)
                                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                                
                                Spacer()
                            }.padding(.horizontal)
                        }
               
                            HStack{
                                Image(systemName: SignUpVM.IsTermsAgreed ?  "checkmark.square.fill":"square")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("blueColor"))
                                    .onTapGesture(perform: {
                                        SignUpVM.IsTermsAgreed.toggle()
                                    })
                                
                                Text("I_agree_all".localized(language))
                                Button(action: {
                                    showsheet = true
                                }, label: {
                                    Text("Terms_&_Conditions".localized(language))
                                        .underline()
                                        .foregroundColor(Color("blueColor"))
                                })
                                    .sheet(isPresented: $showsheet){
                                        // Terms and Conditions here
                                        ZStack {
                                            CamelWebView(url: URL(string:Constants().TermsAndConditionsURL)!, isPresented: $showsheet)
                                            
                                            VStack {
                                                Spacer()
                                                GradientButton(action: {
//                                                    SignUpVM.IsTermsAgreed.toggle()
                                                    showsheet = false
                                                }, Title:"Approve_".localized(language), IsDisabled: .constant(false))
                                            }
                                        }
                                    }
                                Spacer()
                            }.padding(.vertical)
                    }
                    .padding(.horizontal)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    
                    Spacer().frame(height:30)
                }
                .padding(.top,hasNotch ? -15:-30)
            }
            .padding(.bottom,120)
            .onTapGesture(perform: {
                inFocus = 0
                hideKeyboard()
            })
         
            .fullScreenCover(isPresented: $presentPhoneVerify , onDismiss: {
//                    SignUpVM.accountCreated = false
//                    if SignUpVM.isMatchedOTP {
//                    SignUpVM.VerifyUser()
//                    }
                gotoCompleteProfile = true
                }, content: {
                    PhoneVerificationView(op: .signup, phoneNumber: $SignUpVM.phoneNumber, CurrentOTP: $SignUpVM.currentOTP ,validFor: $SignUpVM.SecondsCount , matchedOTP: $SignUpVM.isMatchedOTP, isPresented: $presentPhoneVerify)
                        .environmentObject(ResendOTPViewModel())
                })
        
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false,  forgroundColor: .clear, content: {
                VStack{
                    GradientButton(action: {
                        SignUpVM.CreateUser()
                    }, Title: "Create_account".localized(language), IsDisabled: .constant(  !((SignUpVM.Drivername != "" && SignUpVM.phoneNumber != "" && SignUpVM.password != "" && SignUpVM.confirmpassword != "" && SignUpVM.IsTermsAgreed)&&SignUpVM.ValidationMessage == "")))
                        .padding(.top)
                    
                    HStack {
                        Text("have_an_Account?".localized(language)).foregroundColor(.secondary)
                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr14:Font.camelfonts.SemiBold14)
                        
                        Button("Sign_In".localized(language)) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                        .foregroundColor(Color("blueColor"))
                    }
                    .padding(.top,-10)
                    SwitchLanguageButton()
                }
                .padding(.bottom,10)
                .background(
                    Image("bottomBackimg")
                        .resizable()
                        .padding(.horizontal, -30)
                        .padding(.bottom,-250)
                )
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
        .navigationBarHidden(true)
        .overlay(content: {
            
            VStack{
                HStack{
                    BackButtonView()
                    Spacer()
                    Text("Sign_Up".localized(language))
                        .foregroundColor(.white)
                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr22:Font.camelfonts.SemiBold22)
                    Spacer()
                    Spacer().frame(width:50)
                }
                .padding(.horizontal)
                .padding(.top,hasNotch ? 20:10)
                Spacer()
            }
        })
        .overlay(content: {
            AnimatingGif(isPresented: $SignUpVM.isLoading)
            
            ZStack{
            if SignUpVM.isAlert{
                CustomAlert(presentAlert: $SignUpVM.isAlert,alertType: .error(title: "", message: SignUpVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                    SignUpVM.isAlert = false
                })
                }
            }
        })
        .onChange(of: SignUpVM.accountCreated , perform: {newval in
            if newval == true{
                presentPhoneVerify.toggle()
            }
        })
    
        NavigationLink(destination: EditProfileInfoView(taskStatus: .create,enteredDriverName: SignUpVM.Drivername, selectedDate: Date()) .navigationBarHidden(true),isActive:$gotoCompleteProfile , label: {
        })
  
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
        }
    }
}
