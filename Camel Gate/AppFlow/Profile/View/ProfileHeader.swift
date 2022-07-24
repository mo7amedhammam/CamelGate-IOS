//
//  ProfileHeader.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct ProfileHeader: View {
    @State var name : String?
    @State var rate : String?
    @State var tolatrate : String?

    var body: some View {
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
                    
                    Text(name ?? "Mohamed Hammam")
                        .font(Font.camelfonts.Bold20)
                        .foregroundColor(.white)
                    
                    HStack(){
                        HStack(){
                            Image(systemName:"star.fill").foregroundColor(.orange)
                            Text(rate ?? "4.5")
                                .font(Font.camelfonts.Reg14)
                                .foregroundColor(Color.white)
                            
                        } .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(.white.opacity(0.35))
                            .cornerRadius(8)
                        
                        Text(tolatrate ?? "( 250 Reviews )")
                            .font(Font.camelfonts.Reg14)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top,-10)
                }
            }
            Spacer()
        }.ignoresSafeArea()
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
    }
}
