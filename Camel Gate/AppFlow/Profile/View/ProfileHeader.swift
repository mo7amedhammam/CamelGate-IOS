//
//  ProfileHeader.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct ProfileHeader: View {
//    @State var name : String?
//    @State var rate : String?
//    @State var tolatrate : String?
    @EnvironmentObject var imageVM : camelEnvironments

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
//                            .cornerRadius(10)
                        
//                        CircularButton(ButtonImage:Image("pencil") , forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                            //                                                    self.showImageSheet = true
//                        }
                    }
                    
                    Text(LoginManger.getUser()?.name ?? "")
                        .font(Font.camelfonts.Bold20)
                        .foregroundColor(.white)
                    
                    HStack(){
                        HStack(){
                            Image(systemName:"star.fill").foregroundColor(.orange)
                            Text("\(String(format:"%.1f", LoginManger.getUser()?.rate?.rate ?? 0 )) ")
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                                .foregroundColor(Color.white)
                            
                        } .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(.white.opacity(0.35))
                            .cornerRadius(8)
                        
                        Text("("+" \(LoginManger.getUser()?.rate?.ratesCount ?? 0 ) "+"\("Reviews".localized(language))"+" )")
                                                                
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top,-10)
                }
                
            }
            Spacer()
        }.ignoresSafeArea()
            .navigationBarHidden(true)
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader().environmentObject(camelEnvironments())
        ProfileHeader().environmentObject(camelEnvironments())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

    }
}
