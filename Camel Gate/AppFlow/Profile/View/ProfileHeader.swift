//
//  ProfileHeader.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct ProfileHeader: View {
    
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @EnvironmentObject var imageVM : camelEnvironments
    @EnvironmentObject var driverRate : DriverRateViewModel

    var body: some View {
        VStack{
            ZStack (){
                Image("ProfileBackground")
                    .resizable()
                    .frame(height:280)
                    .padding(.horizontal,-2)
                    .shadow(color: .black.opacity(0.5), radius: 7)
                VStack {
                    ZStack(alignment:.bottomTrailing){
                        Button(action: {
                            // here if you want to preview image
                            imageVM.isPresented = true
                            imageVM.imageUrl = Constants.baseURL +  Helper.getDriverimage().replacingOccurrences(of: "\\",with: "/")
                        }, label: {
                            AsyncImage(url: URL(string: Constants.baseURL +  Helper.getDriverimage().replacingOccurrences(of: "\\",with: "/"))) { image in
                                image.resizable()
                            } placeholder: {
                                Image("face_vector")
                            }
                            .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                        })
                            .clipShape(Circle())
                            .frame(width: 95, height: 95, alignment: .center)
                    }
                    
                    Text(LoginManger.getUser()?.name ?? "")
                        .font(.camelBold(of: 20))
                        .foregroundColor(.white)
                    
                    HStack(){
                        HStack(){
                            Image(systemName:"star.fill").foregroundColor(.orange)
//                            Text( language.rawValue == "ar" ? String(driverRate.DriverRate).replacedArabicDigitsWithEnglish():String(driverRate.DriverRate).replacedArabicDigitsWithEnglish() )


// api returnes 5
//                            Text("\(String(format:"%.1f", locale:Locale(identifier: "en_US_POSIX"), driverRate.DriverRate)) ")
// this shows 5.0 in en and ٥٫٠ in ar
                            // wanted to show as 5.0 in both ar & en
                            //                            Text(verbatim: "\(driverRate.DriverRate)" )

                            
                            
                            Text(NSNumber(value: driverRate.DriverRate) , formatter: numberformatter)
                            

//                            Text("\(String(format:"%.1f", locale:Locale(identifier: "en"), driverRate.DriverRate)) ")
                                                        
                                .font(.camelRegular(of: 14))
                                .foregroundColor(Color.white)
                            
                        } .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(.white.opacity(0.35))
                            .cornerRadius(8)
                        
                    }
                    .padding(.top,-10)
                }
                
            }
            Spacer()
        }
        .environment(\.locale, .init(identifier: "en"))
        .ignoresSafeArea()
            .navigationBarHidden(true)

            .onAppear(perform: {
                print("pref lang:\(Locale.current.languageCode ?? "")")
                print("pref lang:\(Locale.preferredLanguages[0])")
                print("lang:\(language.rawValue)")
                print("\(String(format:"%.1f", locale:Locale(identifier: "en_US_POSIX"), driverRate.DriverRate)) ")
                
                print("\(String(format:"%.1f", locale:Locale(identifier: "en_US"), driverRate.DriverRate)) ")
                
                print("\(String(format:"%.1f", locale:Locale(identifier: "ar"), driverRate.DriverRate)) ")
            })
    }
    func checkLocal(){
        if language.rawValue == "en" {
            
        }
    }

}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader().environmentObject(camelEnvironments())
            .environmentObject(DriverRateViewModel())
        ProfileHeader().environmentObject(camelEnvironments())
            .environmentObject(DriverRateViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

    }
}
