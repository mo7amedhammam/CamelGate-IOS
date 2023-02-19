//
//  SignInView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignInView: View {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @StateObject var SignInVM = SignInViewModel()
    
    @State var active = false
    @State var destination = AnyView(SignUpView())
    @FocusState var inFocus: Int?

    var body: some View {
        ZStack{
            VStack{
                Image("signupheaderpng")
                    .resizable()
                    .padding(.top,hasNotch ? -50:-100)
                    .frame(height:hasNotch ? 320:280)
                
                ScrollView{
                    Image("LOGO")
                        .padding(.horizontal,90)
                    
                    Group{
                        InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"),fieldType: .Phone, placeholder: "Enter_your_phone_number".localized(language), text: $SignInVM.phoneNumber)
                            .focused($inFocus,equals: 1)
                            .onTapGesture(perform: {
                                inFocus = 1
                            })
                            .padding(.horizontal)
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth:SignInVM.validations == .PhoneNumber ? 1:0).padding(.horizontal)
                            )
                            .onChange(of: SignInVM.phoneNumber){ newval in
//                                print(newval.convertedDigitsToLocale(identifier: "en"))
//                                print(newval.convertedDigitsToLocale(identifier: "en_US"))
//                                print(newval.convertedDigitsToLocale(identifier: "en"))
//                                print(newval.convertedDigitsToLocale(identifier: "en_US"))
//                                DispatchQueue.main.async(execute: {
//                                }) {
                                SignInVM.phoneNumber =  String(newval.prefix(SignInVM.PhoneNumLength))
                                    .convertedDigitsToLocale(identifier: "en_US")
//                            })
                            }
                        
                        if SignInVM.validations == .PhoneNumber{
                            HStack{
                                Text(SignInVM.ValidationMessage.localized(language))
                                    .foregroundColor(.red)
                                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                                
                                Spacer()
                            }.padding(.horizontal)
                        }
                        
                        SecureInputTextField("Enter_your_password".localized(language), text: $SignInVM.password,iconName:"lockBlue")
                            .padding(.horizontal)
                            .focused($inFocus,equals: 2)
                            .onTapGesture(perform: {
                                inFocus = 2
                            })
                    }
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    
                    HStack{
                        Spacer()
                    Button(action: {
                        destination = AnyView(NoteScreenView(phoneNumber: SignInVM.phoneNumber))
                        active.toggle()
                    }, label: {

                            Text("Forgot_Password?".localized(language))
                                .foregroundColor(.red)
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                    })
                        }.padding(.horizontal)
                }
                .padding(.top,hasNotch ? -15:-30)
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture(perform: {
                hideKeyboard()
                inFocus = 0
            })
            
            
            //            .padding(.horizontal,-30)
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .clear, content: {
                VStack{
                    //                    Spacer()
                    GradientButton(action: {
                        SignInVM.Login()
                    }, Title: "Sign_In".localized(language),IsDisabled:.constant(  !((SignInVM.phoneNumber != "" && SignInVM.password != "")&&SignInVM.ValidationMessage == "")) )
                       
                    HStack {
                        Text("dont_have_an_Account?".localized(language)).foregroundColor(.secondary)
                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr14:Font.camelfonts.SemiBold14)
                        
                        Button("Sign_Up".localized(language)) {
                            active = true
                            destination = AnyView(SignUpView())
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
                        .padding(.bottom,hasNotch ? -25:-25)
                )
            })
            
                .overlay(content: {
                    VStack{
                        HStack{
                            Spacer()
                            Text("Sign_In".localized(language))
                                .foregroundColor(.white)
                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr22:Font.camelfonts.SemiBold22)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top,hasNotch ? 40:20)
                        Spacer()
                    }
                })
                .overlay(content: {
                    AnimatingGif(isPresented: $SignInVM.isLoading)
                })
            
                .overlay(
                    ZStack{
                    if SignInVM.isAlert{
                        CustomAlert(presentAlert: $SignInVM.isAlert,alertType: .error(title: "", message: SignInVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
    //                        if ApprovedShipmentVM.activeAlert == .unauthorized{
    //                            Helper.logout()
    //                            LoginManger.removeUser()
    //                            Helper.IsLoggedIn(value: false)
    //                            destination = AnyView(SignInView())
    //                            active = true
    //                        }
                            SignInVM.isAlert = false
                        })
                        }
                    }.ignoresSafeArea()
                        .edgesIgnoringSafeArea(.all)
    //                    .onChange(of: SignUpVM.isAlert, perform: {newval in
    //                        DispatchQueue.main.async {
//                    environments.isError = newval
//                    }
    //                    })
                )
            // Alert with no internet connection
//                .alert(isPresented: $SignInVM.isAlert, content: {
//                    Alert(title: Text(SignInVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
//                        SignInVM.isAlert = false
//                    }))
//                })
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
            
            NavigationLink(destination: destination.navigationBarHidden(true),isActive:$active , label: {
            })
            NavigationLink(destination: SignInVM.destination.navigationBarHidden(true),isActive:$SignInVM.isLogedin , label: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignInView()
        }
    }
}

