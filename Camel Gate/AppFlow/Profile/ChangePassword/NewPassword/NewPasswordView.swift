//
//  NewPasswordView.swift
//  Camel Gate
//
//  Created by wecancity on 25/07/2022.
//

import SwiftUI

struct NewPasswordView: View {

    @State var newpass = ""
    @State var Confirmnewpass = ""
    @State var showBottomSheet = false

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
                    SecureInputTextField("new_Password".localized(language), text: $newpass)
                    SecureInputTextField("Confirm_new_Password".localized(language), text: $newpass)
                        
                    }
                    .font(Font.camelfonts.Reg16)
                    if (Confirmnewpass != "" && (newpass != Confirmnewpass )){
                    HStack {
                        Text("Passwords_does_not_match".localized(language) )
                            .font(Font.camelfonts.Reg14)
                            .multilineTextAlignment(.center)
                            .padding( .leading)
                            .foregroundColor(.red)
                        
                        Spacer()
                    }
                    }
                    
                
                    //                NavigationLink(destination: PersonalDataView(),isActive: $matchedOTP, label: {
                    //                })
                    
                    
                    Spacer()
                }.onTapGesture(perform: {
                    hideKeyboard()
                    withAnimation{
                        showBottomSheet.toggle()
                    }
                })
                
                Button(action: {
                 showBottomSheet = true
                }, label: {
                    HStack {
                        Text("Confirm".localized(language))
                            .font(Font.camelfonts.Reg14)
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
                            .opacity((Confirmnewpass == "" || (newpass != Confirmnewpass )) ? 0.5:1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 25)
                }).padding(.top, 120)
                .disabled((Confirmnewpass == "" || (newpass != Confirmnewpass )))
            }.padding(.bottom,0)
                    
            
            TitleBar(Title: "Change_Password", navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
        }
            .blur(radius: showBottomSheet ? 5:0)
            
            if showBottomSheet{
                
                    BottomSheetView(IsPresented: $showBottomSheet, withcapsule: true, content: {

                        Text("Password_Changed".localized(language))
                            .font(Font.camelfonts.Reg20)

                        Image("success-orange")

                        Text("You_just_changed_your_password".localized(language))
                            .font(Font.camelfonts.Reg16)
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.bottom,50)

                        Button(action: {
                            DispatchQueue.main.async{
            // Action
                                showBottomSheet.toggle()
                            }
                        }, label: {
                            HStack {
                                Text("Ok".localized(language))
                                    .font(Font.camelfonts.Med18)
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

        
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
        
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
