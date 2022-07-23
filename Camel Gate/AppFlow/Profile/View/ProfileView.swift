//
//  ProfileView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct ProfileView: View {
    @State var islogout:Bool = false
    @State var goToLogin:Bool = false
    
    @State var goingToPatientUpdate = false
    @State var goingToResetPassword = false
    @State var aboutApp = false
    @State var TermsAndConditions = false
    
    @State var name : String?
    @State var rate : String?
    @State var tolatrate : String?
    var language = LocalizationService.shared.language
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing:1) {
                    ScrollView( showsIndicators: false){
                        VStack(alignment: .leading,spacing:12){
                            Group{
                                Button(action: {
                                    self.goingToPatientUpdate.toggle()
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "person.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Profile_info".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        
                                        Spacer()
                                        
                                        Text("70%".localized(language))
                                            .foregroundColor(.red)
                                        
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                })
                                //                                    .opacity(Helper.userExist() ? 1 : 0.6)
                                //                                    .disabled(!Helper.userExist())
                                
                                Button(action: {
                                    //                                    TermsAndConditions = true
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "star.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Rating_and_Reviews".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                })
                                
                                Button(action: {
                                    self.goingToResetPassword.toggle()
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "lock.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Change_Password".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                })
                                //                                    .opacity(Helper.userExist() ? 1 : 0.6)
                                //                                .disabled(!Helper.userExist())
                                
                                VStack{
                                    HStack(spacing: 10){
                                        Image(systemName: "network")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Change_Language".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                    HStack{
                                        //                                LanguageView(selection: $patientCreatedVM.GenderId)
                                    }
                                }
                                
                                Button(action: {
                                    Helper.MakePhoneCall(PhoneNumber: "0221256299")
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "phone.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Get_in_Touch".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                })
                                
                                Button(action: {
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(Color("blueColor"))
                                        
                                        Text("Help".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                            .font(.system(size:18))
                                    }
                                })
                                Button(action: {
                                    if Helper.userExist(){
                                        Helper.logout()
                                        islogout = true
                                    }else{
                                        goToLogin = true
                                    }
                                }, label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "arrow.left.square.fill")
                                            .font(.system(size:25))
                                            .foregroundColor(.red.opacity(0.7))
                                        
                                        Text( "Logout".localized(language))
                                            .foregroundColor(Color("lightGray"))
                                        Spacer()
                                    }
                                })
                            }
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .font(.system(size: 13))
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
                .padding(.top,260)
                                VStack{
                                    ZStack (){
                                        Image("ProfileBackground")
                                            .resizable()
                                            .frame(height:280)
                                            .padding(.leading,-1)
                                            .shadow(color: .black.opacity(0.5), radius: 7)
                                        VStack {
                                            ZStack(alignment:.bottomTrailing){
                                                Button(action: {
                                                    // here if you want to preview image
                                                }, label: {
                                                    AsyncImage(url: URL(string:  Helper.getUserimage())) { image in
                                                        image.resizable()
                                                    } placeholder: {
                                                        Color("lightGray").opacity(0.2)
                                                    }
                                                    .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                                                })
                                                    .clipShape(Circle())
                                                    .frame(width: 95, height: 95, alignment: .center)
                                                    .cornerRadius(10)
                                                
                                                CircularButton(ButtonImage:Image("pencil") , forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
//                                                    self.showImageSheet = true
                                                }
                                            }
                                            
                                            Text(name ?? "mohamed hammam")
                                                .font(.title)
                                                .bold()
                                                .foregroundColor(.white)
                                            
                                            HStack(){
                                                HStack(){
                                                Image(systemName:"star.fill").foregroundColor(.orange)
                                                Text(rate ?? "4.5")
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color.white)
                                                
                                            } .padding(.horizontal)
                                                .padding(.vertical,5)
                                                .background(.white.opacity(0.35))
                                                .cornerRadius(8)

                                                Text(tolatrate ?? "(250 Reviews)")
                                                    .fontWeight(.regular)
                                                    .foregroundColor(Color.white)
                                            }
                                            .padding(.top,-10)
                                        }
                                    }
                                        Spacer()
                                }
            }
            .edgesIgnoringSafeArea(.vertical)
//            .background(.red)
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileView()
        }
    }
}


