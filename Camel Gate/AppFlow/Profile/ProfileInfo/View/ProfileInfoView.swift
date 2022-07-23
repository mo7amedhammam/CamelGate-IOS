//
//  ProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct ProfileInfoView: View {
    
    var body: some View {
        ZStack {
            ScrollView{
            //MARK:  --- Driver info
            VStack(spacing:10){
                HStack {
                    Text("Driver_info".localized(language))
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical,10)
                .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                
                HStack(){
                    Image(systemName: "person.fill")
                        .font(.system(size:25))
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)

                    HStack{
                        Text("User_Name_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text(  Helper.getpatientName() )
                            .foregroundColor(.secondary)
                    }
                    
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)
                
                HStack{
                    Image(systemName: "phone.fill")
                        .font(.system(size:25))
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("Patient_Number_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)
                
                HStack{
                    Image("x321")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("Driver_barcode_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)

                HStack{
                    Image("x321")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("CamelGate_Number_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
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
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical,10)
                .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                
                HStack(){
                    Image("x321")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)

                    HStack{
                        Text("Truck_Number:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text(  Helper.getpatientName() )
                            .foregroundColor(.secondary)
                    }
                    
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)
                
                HStack{
                    Image("truck")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("Patient_Type_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)
                
                HStack{
                    Image("x321")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("Driving_license_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)

                HStack{
                    Image("x321")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .scaledToFit()
                        .foregroundColor(Color("blueColor"))
                        .padding(.leading)
                    
                    HStack(){
                        Text("Expired_at_:".localized(language))
                            .foregroundColor(Color("blueColor"))
                        Text("\(Helper.getUserPhone() )" )
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    Spacer()
                }.padding(.leading)

            }
            .padding(.bottom,20)

                //MARK:  --- cargo Type
                VStack(spacing:10){
                    HStack {
                        Text("Cargo_Type".localized(language))
                            .bold()
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
                    
                    HStack(){
                        Image("Cargo")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .foregroundColor(Color("blueColor"))
                            .padding(.leading)

                        HStack{
                            Text("Cargo_I_can_handel_:".localized(language))
                                .foregroundColor(Color("blueColor"))
                            Text(  Helper.getpatientName() )
                                .foregroundColor(.secondary)
                        }
                        
                        .padding(.trailing)
                        Spacer()
                    }.padding(.leading)
                    
                    // cargo grid view is here 
                }
                .padding(.bottom,20)
            }
            TitleBar(Title: "Profile_info", navBarHidden: true, leadingButton: .backButton, trailingButton: .editButton, subText: "90%", trailingAction: {
                
            })
        }
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
