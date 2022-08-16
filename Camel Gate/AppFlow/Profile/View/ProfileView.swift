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

    var language = LocalizationService.shared.language
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing:1) {
                    ScrollView( showsIndicators: false){
                        VStack(alignment: .leading,spacing:12){
                            Group{
                                Button(action: {
                                    active = true
//                                    destination = AnyView(ProfileInfoView())
                                    destination = AnyView(EditProfileInfoView(taskStatus: .update))
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "person.fill")
                                            .font(.system(size:20))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Profile_info".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        
                                        Spacer()
                                        
//                                        Text("70%".localized(language))
//                                            .foregroundColor(.red)
                                        
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
                                    destination = AnyView(NoteScreenView())
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
                                
                                Button(action:{
                                    active = true
                                    destination = AnyView(ChangeLanguageView())
                                },label:{
                                    VStack{
                                        HStack(spacing: 10){
                                            Image(systemName: "network")
                                                .font(.system(size:20))
                                                .foregroundColor(Color("blueColor"))
                                            
                                            Text("Change_Language".localized(language))
                                                .foregroundColor(Color("lightGray"))
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color("lightGray"))
                                                .font(.system(size:15))
                                        }
                                        HStack{
                                        }
                                    }
                                })
                                
                                
                                Button(action: {
                                    Helper.MakePhoneCall(PhoneNumber: "0221256299")
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
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .font(Font.camelfonts.Reg14)
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).cornerRadius(8)
                            .foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 8)
                        }
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
            .edgesIgnoringSafeArea(.vertical)
            .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))

        }
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
            ProfileView()
        }
        ZStack {
            ProfileView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

