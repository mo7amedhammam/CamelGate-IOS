//
//  SignUpView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignUpView: View {
    
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

                        InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"), placeholder: "Enter_your_phone_number".localized(language), text: $SignUpVM.phoneNumber)
                            .keyboardType(.numberPad)
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
                                    .font(Font.camelfonts.Reg14)
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
                                .font(Font.camelfonts.Reg14)
                            Spacer()
                        }.padding(.horizontal)
                    }

                    }
                    .font(Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    
                  

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
                    GradientButton(action: {
                    }, Title: "Create_account".localized(language))
                    .padding(.top)
                    HStack {
                        Text("have_an_Account? ".localized(language)).foregroundColor(.secondary)
                        
                        Button("Sign_In".localized(language)) {
                            self.presentationMode.wrappedValue.dismiss()
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
                        .padding(.bottom,-250)
                )

            })
            
        }
        .overlay(content: {
            VStack{
                HStack{
                    BackButtonView()
                    Spacer()
                    Text("Sign_Up".localized(language))
                        .foregroundColor(.white)
                        .font(Font.camelfonts.Med20)
                       Spacer()
                    Spacer().frame(width:50)
                }
                .padding(.horizontal)
                .padding(.top,20)
                Spacer()
            }
        })
        
        
        .navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
