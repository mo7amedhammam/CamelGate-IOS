//
//  SignInView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignInView: View {
    var language = LocalizationService.shared.language

    @StateObject var SignInVM = SignInViewModel()
    
    @State var active = false
    @State var destination = AnyView(SignUpView())
    
    var body: some View {
        ZStack{
            VStack{
                Image("signupheaderpng")
                    .resizable()
                    .padding(.top,-50)
                    .frame(height:320)
                
                ScrollView{
                    Image("LOGO")
                        .padding(.horizontal,90)
                    
                    Group{
                        
                        InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"),fieldType: .Phone, placeholder: "Enter_your_phone_number".localized(language), text: $SignInVM.phoneNumber)
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth:SignInVM.validations == .PhoneNumber ? 1:0).padding(.horizontal)
                            )
                        
                            .onChange(of: SignInVM.phoneNumber){ newval in
                                SignInVM.phoneNumber =  String(newval.prefix(SignInVM.characterLimit))
                            }
                        
                        if SignInVM.validations == .PhoneNumber{
                            HStack{
                                Text(SignInVM.ValidationMessage.localized(language))
                                    .foregroundColor(.red)
                                    .font(Font.camelfonts.Reg14)
                                Spacer()
                            }.padding(.horizontal)
                        }
                        
                        
                        SecureInputTextField("Enter_your_password".localized(language), text: $SignInVM.password,iconName:"lockBlue")
                            .padding(.horizontal)
                    }
                    .font(Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    
                    HStack{
                        Spacer()
                        Text("Forgot_Password?".localized(language))
                            .foregroundColor(.red)
                            .font(Font.camelfonts.Reg14)
                        
                    }.padding(.horizontal)
                    
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture(perform: {
                hideKeyboard()
            })
            
            
            //            .padding(.horizontal,-30)
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .clear, content: {
                VStack{
                    //                    Spacer()
                    GradientButton(action: {
                        SignInVM.Login()
                    }, Title: "Sign_In".localized(language))
                    
                    HStack {
                        Text("dont_have_an_Account? ".localized(language)).foregroundColor(.secondary)
                        
                        Button("Sign_Up".localized(language)) {
                            active = true
                            destination = AnyView(SignUpView())
                        }
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color("blueColor"))
                    }
                    .padding(.top,-10)
                }
                .padding(.bottom,30)
                .background(
                    Image("bottomBackimg")
                        .resizable()
                        .padding(.horizontal, -30)
                        .padding(.bottom,-25)
                )
                
            })
            
                .overlay(content: {
                    VStack{
                        HStack{
                            //                    BackButtonView()
                            Spacer()
                            Text("Sign_In".localized(language))
                                .foregroundColor(.white)
                                .font(Font.camelfonts.SemiBold20)
                            Spacer()
                            //                    Spacer().frame(width:50)
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        Spacer()
                    }
                })
            
                .overlay(content: {
                    // showing loading indicator
                    ActivityIndicatorView(isPresented: $SignInVM.isLoading)
                    AnimatingGif(isPresented: $SignInVM.isLoading)

                })
            // Alert with no internet connection
                .alert(isPresented: $SignInVM.isAlert, content: {
                    Alert(title: Text(SignInVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        SignInVM.isAlert = false
                    }))
                })
            
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
            
            NavigationLink(destination: destination.navigationBarHidden(true),isActive:$active , label: {
            })
            NavigationLink(destination: SignInVM.destination.navigationBarHidden(true),isActive:$SignInVM.isLogedin , label: {
            })
        }                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
