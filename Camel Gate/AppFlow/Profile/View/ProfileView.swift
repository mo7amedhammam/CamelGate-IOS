//
//  ProfileView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct ProfileView: View {
    //    @State var rootView = AnyView(ProfileView())
    @State var islogout:Bool = false
    @State var goToLogin:Bool = false
    
    @State var aboutApp = false
    @State var TermsAndConditions = false
    
    @State var active = false
    @State var destination = AnyView(ProfileInfoView())
    
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @EnvironmentObject var imageVM : camelEnvironments
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing:1) {
                    ScrollView( showsIndicators: false){
                        VStack(alignment: .leading,spacing:12){
                            Group{
                                Button(action: {
                                    active = true
                                    destination = AnyView(EditProfileInfoView(taskStatus: .update)
                                                            .environmentObject(imageVM))
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "person.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Profile_info".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:15))
                                    }
                                })
                                
                                Button(action: {
                                    active = true
                                    destination = AnyView(RatingView())
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "star.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Rating_and_Reviews".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:15))
                                    }
                                })
                                
                                Button(action: {
                                    active = true
//                                    destination = AnyView(NoteScreenView()) //verification
                                    destination = AnyView(ChangePasswordView())
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "lock.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Change_Password".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:15))
                                    }
                                })
                            }
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                            .frame(height:33)
                            .padding(12)
                                .disableAutocorrection(true)
                                .background(
                                    Color.white
                                ).cornerRadius(8)
                                .foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 8)
                            
                            Section(header: Text("Change_Language".localized(language))
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                                        .foregroundColor(Color("lightGray"))
                            ){
                                HStack(spacing:15){
                                    Group{
                                        Button(action:{
                                            withAnimation {
                                                DispatchQueue.main.async(execute: {
                                                LocalizationService.shared.language = .english_us
                                                Helper.setLanguage(currentLanguage: "en")
                                                })
                                                }
                                        },label:{
                                            HStack(spacing: 10){
                                                Image("usaFlag")
                                                    .frame(width: 20, height: 20)
                                                    .padding(.horizontal).foregroundColor(Color("blueColor"))

                                                Text("English".localized(language))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                                                    .foregroundColor(Color("lightGray"))
                                                Spacer()
                                            }
                                        })
                                        
                                        Button(action:{
                                            withAnimation {
                                                DispatchQueue.main.async(execute: {
                                                LocalizationService.shared.language = .arabic
                                                Helper.setLanguage(currentLanguage: "ar")
                                            })
                                            }
                                        },label:{
                                            HStack(spacing: 10){
                                                Image("saudiFlag")
                                                    .frame(width: 20, height: 20)
                                                    .padding(.horizontal)
                                                    .foregroundColor(Color("blueColor"))
                                                Text("العربية".localized(language))
                            .font( language.rawValue == "en" ? Font.camelfonts.RegAr16:Font.camelfonts.RegAr16)
                                                    .foregroundColor(Color("lightGray"))
                                                Spacer()
                                            }
                                        })
                                    }
                                    .frame(height:33)
                                    .padding(12)
                                    .disableAutocorrection(true)
                                    .background(
                                        Color.white
                                    ).cornerRadius(8)
                                        .foregroundColor(Color("blueColor"))
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.099), radius: 8)
                                }
                            }
                            Group{
                                Button(action: {
//                                    Helper.MakePhoneCall(PhoneNumber: "00000000")
                                    openWhatsApp(number:nil)
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "phone.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Get_in_Touch".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:15))
                                    }
                                })
                                
                                Button(action: {
                                    openWhatsApp(number:nil)
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Help".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:15))
                                    }
                                })
                                Button(action: {
                                    //                                    if Helper.userExist(){
                                    Helper.logout()
                                    Helper.IsLoggedIn(value: false)
                                    //                                        islogout = true
                                    //                                    }else{
                                    //                                        goToLogin = true
                                    //                                    }
                                    LoginManger.removeUser()
                                    active = true
                                    destination = AnyView(SignInView())
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "arrow.left.square.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(.red.opacity(0.7))
                                        
                                        Text( "Logout".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                    }
                                })
                            }
    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                            .frame(height:33)
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).cornerRadius(8)
                                .foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 8)
                        }
                        .environmentObject(imageVM)

                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }
                }
                .background(Color.clear)
                //                .padding(.bottom,20)
                .padding(.top,hasNotch ? 240:230 )
                ProfileHeader()
                    .padding(.top,hasNotch ? -20:-30 )
            }
            .navigationBarHidden(true)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        }
//        .onChange(of: LocalizationService.shared.language, perform: {newval in
//            print(Helper.getLanguage())
//print(newval)
//            DispatchQueue.main.async(execute: {
//                Helper.setLanguage(currentLanguage: newval.rawValue)
//            })
//            print(Helper.getLanguage())
//        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $islogout, content: {
            Alert(title: Text("you_signed_out".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                islogout = false
            }))
        })
        
        NavigationLink(destination: destination,isActive:$active , label: {
        })
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileView().environmentObject(camelEnvironments())
        }
        ZStack {
            ProfileView().environmentObject(camelEnvironments())
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

