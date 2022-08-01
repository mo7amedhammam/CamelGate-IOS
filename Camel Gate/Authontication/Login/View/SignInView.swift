//
//  SignInView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignInView: View {
    
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
                            
                            InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"), placeholder: "Enter_your_phone_number".localized(language), text: .constant(""))
                            

                            SecureInputTextField("Enter_your_password".localized(language), text: .constant(""),iconName:"lockBlue")
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
                        }, Title: "Create_account".localized(language))
                        
                        HStack {
                            Text("dont_have_an_Account? ".localized(language)).foregroundColor(.secondary)
                            
                            Button("Sign_Up".localized(language)) {
                                print("goto signup")
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
                
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            .overlay(content: {
                VStack{
                    HStack{
    //                    BackButtonView()
                        Spacer()
                        Text("Sign_In".localized(language))
                            .foregroundColor(.white)
                            .font(Font.camelfonts.Med20)
                           Spacer()
    //                    Spacer().frame(width:50)
                    }
                    .padding(.horizontal)
                    .padding(.top,40)
                    Spacer()
                }
            })
        .navigationBarHidden(true)
           
            NavigationLink(destination: destination,isActive:$active , label: {
            })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
