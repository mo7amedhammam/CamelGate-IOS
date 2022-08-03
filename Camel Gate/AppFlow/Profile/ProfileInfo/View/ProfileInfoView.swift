//
//  ProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct ProfileInfoView: View {
    let columns =
    [
            GridItem(.adaptive(minimum: UIScreen.main.bounds.width)),
            GridItem(.adaptive(minimum: UIScreen.main.bounds.width))
    ]
    var Cargo = ["Metals","Cleaning materials","Wood","Cleaning materials1","Wood1","Wood2","Metals1","Cleaning materials2","Wood3","Cleaning materials3"]
    @State var goingToEditProfileInfo = false

    var body: some View {
        ZStack {
            ScrollView{
                //MARK:  --- Driver info
                VStack(spacing:10){
                    
                    HStack {
                        Text("Driver_barCode".localized(language))
                            .font(Font.camelfonts.SemiBold16)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                    
                        Image("driver-barcode")
                        .resizable()
                        .frame(height:30)
                        .padding(.vertical,5)
                        .padding(.horizontal,45)
                  
                    HStack {
                        Text("Driver_info".localized(language))
                            .font(Font.camelfonts.SemiBold16)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                    
                    HStack(spacing:0){
                        Image(systemName: "person.fill")
                            .font(.system(size:16))
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack{
                            Text("User_Name_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text(  Helper.getpatientName() )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image(systemName: "phone.fill")
                            .font(.system(size:17))
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("Phone_Number_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)

                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image("x321")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("Driver_barcode_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-7)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image("x321")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("CamelGate_Number_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-7)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                }
                .padding(.bottom,20)
                .padding(.top,110)
                
                //MARK:  --- Truck info
                VStack(spacing:10){
                    HStack {
                        Text("Truck_info".localized(language))
                            .font(Font.camelfonts.SemiBold16)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                    
                    HStack(spacing:0){
                        Image("x321")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack{
                            Text("Truck_Number:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text(  Helper.getpatientName() )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image("truck")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("Patient_Type_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image("x321")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("Driving_license_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    HStack(spacing:0){
                        Image("x321")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack(){
                            Text("Expired_at_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                            Text("\(Helper.getUserPhone() )" )
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                }
                .padding(.bottom,20)
                
                //MARK:  --- cargo Type
                VStack(spacing:10){
                    HStack {
                        Text("Cargo_Type".localized(language))
                            .font(Font.camelfonts.SemiBold16)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                    
                    HStack(spacing:0){
                        Image("Cargo")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.trailing)
                        
                        HStack{
                            Text("Cargo_I_can_handel_:".localized(language))
                                .font(Font.camelfonts.SemiBold16)
                                .foregroundColor(Color("blueColor"))
                        }
                        .padding(.leading,-5)
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(Cargo, id: \.self) { item in
                            Text(item)
                                .frame(minWidth:(UIScreen.main.bounds.width/2)-40)
                                .frame(height:15)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(.black.opacity(0.6))
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            TitleBar(Title: "Profile_info", navBarHidden: true, leadingButton: .backButton, trailingButton: .editButton, subText: "90%", trailingAction: {
                goingToEditProfileInfo = true
            })
        }
        NavigationLink(destination: EditProfileInfoView(taskStatus: .update),isActive:$goingToEditProfileInfo , label: {
        })
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
