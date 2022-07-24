//
//  EditProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct EditProfileInfoView: View {
    @State var name = ""
    var body: some View {
        ZStack{
            
            ScrollView{
                HStack{
                    Text("Driver_Info".localized(language))
                        .font(Font.camelfonts.Reg14)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                InputTextField(imagename: "person", placeholder: "Name".localized(language), text: $name)
                InputTextField(imagename: "Phone", placeholder: "Phone_Number".localized(language), text: .constant("01101201322"))
                
                HStack{
                    Text("Truck_Info".localized(language))
                        .font(Font.camelfonts.Reg14)
                        .foregroundColor(.secondary)
                    Spacer()
                }.padding(.top)
                
                InputTextField(imagename: "x321gray", placeholder: "Plate_Number".localized(language), text: .constant("GTA123"))
                InputTextField(imagename: "truckgray", placeholder: "Truck_Type".localized(language), text: .constant("Open jumbo truck"))
               
                HStack{
                    Text("Cargo_types".localized(language))
                        .font(Font.camelfonts.Reg14)
                        .foregroundColor(.secondary)
                    Spacer()
                }.padding(.top)
                
                InputTextField(imagename: "ic_box", placeholder: "Cargos_I_Can_Handle".localized(language), text: .constant("Metals, Cleaning materials, Wood, M... +12"))
                
            }.padding(.top,120)
                .padding(.horizontal)
            
            TitleBar(Title: "Profile_info", navBarHidden: true, leadingButton: .backButton, subText: "70%", trailingAction: {})
        
            PopUpView(IsPresented: .constant(true), withcapsule: false, content: {
                Button(action: {
                    DispatchQueue.main.async{
// Action
                    }
                }, label: {
                    HStack {
                        Text("Save_Changes".localized(language))
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
                        ))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                })
            })

            
        }.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoView()
    }
}
