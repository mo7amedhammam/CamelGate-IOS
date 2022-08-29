//
//  SignUpView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignUpView: View {
    var language = LocalizationService.shared.language

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var SignUpVM = SignUpViewModel()

    var body: some View {
        ZStack{
         
            VStack{
                Image("signupheaderpng")
                    .resizable()
//                    .frame(width:500)
                
                    .padding(.top,-50)
                    .frame(height:320)
                
                ScrollView{
                    Image("LOGO")
                        .padding(.horizontal,90)
                    
                    Group{
                        InputTextField(iconName: "person",iconColor: Color("blueColor"), placeholder: "Enter_your_name".localized(language), text: $SignUpVM.Drivername)

                        InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"),fieldType: .Phone, placeholder: "Enter_your_phone_number".localized(language), text: $SignUpVM.phoneNumber)
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth:SignUpVM.validations == .PhoneNumber ? 1:0))
                            .onChange(of: SignUpVM.phoneNumber){ newval in
                                SignUpVM.phoneNumber =  String(newval.prefix(SignUpVM.characterLimit))
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
                        SecureInputTextField("Confirm_your_password".localized(language), text: $SignUpVM.confirmpassword, iconName: "lockBlue")
                            .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.red, lineWidth:SignUpVM.validations == .ConfirmPassword ? 1:0))
                    if SignUpVM.validations == .ConfirmPassword{
                        HStack{
                            Text(SignUpVM.ValidationMessage.localized(language))
                                .foregroundColor(.red)
                                                                               .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                            Spacer()
                        }.padding(.horizontal)
                    }
                    }
                    .padding(.horizontal)
.font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)

                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture(perform: {
                hideKeyboard()
            })
//            .padding(.horizontal,-30)
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false,  forgroundColor: .clear, content: {
                VStack{
                    GradientButton(action: {
                        SignUpVM.CreateAccount()
                    }, Title: "Create_account".localized(language), IsDisabled: .constant(  !((SignUpVM.Drivername != "" && SignUpVM.phoneNumber != "" && SignUpVM.password != "" && SignUpVM.confirmpassword != "")&&SignUpVM.ValidationMessage == "")))
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
                }
                .padding(.bottom,30)
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
                .padding(.top,20)
                Spacer()
            }
        })
//        .overlay(content: {
//            // showing loading indicator
//            ActivityIndicatorView(isPresented: $SignUpVM.isLoading)
//        })
        .overlay(content: {
            AnimatingGif(isPresented: $SignUpVM.isLoading)
        })
        
        NavigationLink(destination: EditProfileInfoView(taskStatus: .create, selectedDate: Date()) .navigationBarHidden(true),isActive:$SignUpVM.UserCreated , label: {
        })

    // Alert with no internet connection
        .alert(isPresented: $SignUpVM.isAlert, content: {
            Alert(title: Text(SignUpVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                SignUpVM.isAlert = false
            }))
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
