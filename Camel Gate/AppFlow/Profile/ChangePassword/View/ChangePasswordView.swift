//
//  ChangePasswordView.swift
//  Camel Gate
//
//  Created by wecancity on 20/08/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    var language = LocalizationService.shared.language
    @StateObject var ChangePasswordVM = ChangePasswordViewModel()

    @State var showBottomSheet = false
//    @ObservedObject private var keyboard = KeyboardResponder()
    @State var phoneNumber = ""
    @State var operation : passwordOperations = .change
    @State var active = false
    @State var destination = AnyView(SignUpView())

    var body: some View {
        ZStack{
            Group{
            VStack{
                ScrollView{
                    Spacer().frame(height:120)
                    Image("lock-orange")
                    
                    Text("Please_enter_the_new_password_\nand_remember_that_it_needs_to_be_\ndifferent_from_the_last_one".localized(language) )
                        .font(Font.camelfonts.Reg18)
                        .multilineTextAlignment(.center)
                        .padding(.vertical,30)
                    
                    Group{
                        if ChangePasswordVM.operation == .change{
                        SecureInputTextField("Current_Password".localized(language), text: $ChangePasswordVM.CurrentPassword, iconName: "")
                            .padding(.bottom)
                        }
                        SecureInputTextField("new_Password".localized(language), text: $ChangePasswordVM.NewPassword, iconName: "")
                        SecureInputTextField("Confirm_new_Password".localized(language), text: $ChangePasswordVM.ConfirmNewPassword, iconName: "")
                    }
                    .padding(.horizontal)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    if (ChangePasswordVM.ConfirmNewPassword != "" && (ChangePasswordVM.NewPassword != ChangePasswordVM.ConfirmNewPassword )){
                    HStack {
                        Text("Passwords_does_not_match".localized(language) )
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .multilineTextAlignment(.center)
                            .padding( .leading)
                            .foregroundColor(.red)
                        
                        Spacer()
                    }
                    }
                    Spacer()
                }
                .onTapGesture(perform: {
                    hideKeyboard()
                })
                
                Button(action: {
                    withAnimation{
                        ChangePasswordVM.ChangePassword()
                    }
                }, label: {
                    HStack {
                        Text("Confirm".localized(language))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height:22)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                            .opacity(((operation == .change && ChangePasswordVM.CurrentPassword == "") || (ChangePasswordVM.ConfirmNewPassword == "" || (ChangePasswordVM.NewPassword != ChangePasswordVM.ConfirmNewPassword ))) ? 0.5:1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 25)
                })
                    .disabled(((operation == .change && ChangePasswordVM.CurrentPassword == "") || (ChangePasswordVM.ConfirmNewPassword == "" || (ChangePasswordVM.NewPassword != ChangePasswordVM.ConfirmNewPassword ))))
            }
            .padding(.bottom)
            
                TitleBar(Title: "Change_Password".localized(language), navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
        }
            .blur(radius: showBottomSheet ? 5:0)
            .onChange(of: ChangePasswordVM.PasswordChanged, perform: {newval in
                if newval == true{
                    showBottomSheet = true
                }
            })
            
            if showBottomSheet{
                
                BottomSheetView(IsPresented: $showBottomSheet, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {

                        Text("Password_Changed".localized(language))
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr20:Font.camelfonts.Reg20)

                        Image("success-orange")

                        Text("You_just_changed_your_password".localized(language))
    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.bottom,50)

                        Button(action: {
                            DispatchQueue.main.async{
                                showBottomSheet.toggle()
                                if operation == .forget {
                                    destination = AnyView(SignInView())
                                    active.toggle()
                                }
                            }
                        }, label: {
                            HStack {
                                Text("Ok".localized(language))
                                    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)

                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height:22)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                    startPoint: .trailing,
                                    endPoint: .leading
                                ))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.bottom)
                        })
                    })
                        .transition(.move(edge: .bottom))
            }
        }
        .onAppear(perform: {
            ChangePasswordVM.operation = operation
            ChangePasswordVM.phoneNumber = phoneNumber
        })
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

//        .padding(.bottom, keyboard.currentHeight)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
        
//        .overlay(content: {
//            // showing loading indicator
//            ActivityIndicatorView(isPresented: $ChangePasswordVM.isLoading)
//        })
        .overlay(content: {
            AnimatingGif(isPresented: $ChangePasswordVM.isLoading)
        })
    // Alert with no internet connection
        .alert(isPresented: $ChangePasswordVM.isAlert, content: {
            Alert(title: Text(ChangePasswordVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                ChangePasswordVM.isAlert = false
            }))
        })
        NavigationLink(destination: destination.navigationBarHidden(true),isActive:$active , label: {
        })

    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
