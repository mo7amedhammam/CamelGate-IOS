//
//  EditProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

enum ProfileStep{
    case create, update
}

struct EditProfileInfoView: View {
     var taskStatus:ProfileStep
    @State var ageeTerms = false

    var body: some View {
        ZStack{
            
            ScrollView{
                
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

                Group{
                Text("Driver_Info".localized(language))
                        .font(Font.camelfonts.Med16)
                        .foregroundColor(Color("blueColor"))
                        .padding(.vertical,10)

                if taskStatus == .update{
                    // card is here
                }


//                InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Name".localized(language), text: .constant("mohamed"))
//                InputTextField(iconName: "Phone",iconColor: Color("OrangColor"), placeholder: "Phone_Number".localized(language), text: .constant("01101201322"))
                    
                    HStack{
                    InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: .constant("01 / 01 / 1111"))
                    
                    InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Gender".localized(language), text: .constant("Male"))
                            .frame(width:130)
                        .overlay(content: {
                            Menu {
                                Button("Male", action: {})
                                Button("Female", action: {})
                            } label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.trailing)
                            }
                        })
                }

                    HStack{
    
                        InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "resident".localized(language), text: .constant("resident"))
                            .frame(width:130)
                            .disabled(true)
                            .overlay(content: {
                                Menu {
                                    Button("Citizen Id", action: {})
                                    Button("Resident Id", action: {})
                                    Button("Border Id", action: {})

                                } label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                    }
                                    .padding(.trailing)
                                    
                                }

                               
                                
                            })
                            

                        InputTextField(iconName: "", placeholder: "Id".localized(language), text: .constant("123456789101112"))
                    }
                    
                    InputTextField(iconName: "Shipments",iconColor: Color("OrangColor"), placeholder: "Email".localized(language), text: .constant("email@mail.com"))
                    
                    

                InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "Driving_Licence".localized(language), text: .constant("254158881848292474"))
                    
                    InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Licence_Expiration_Date".localized(language), text: .constant("01 / 01 / 1111"))
                    
//                    InputTextField(iconName: "ic_pin_orange",iconColor: Color("OrangColor"), placeholder: "Location".localized(language), text: .constant("25 ehsan st., Aggamy, Alexandria"))
//                        .overlay(content: {
//                            HStack{
//                                Spacer()
//                                Image("LocationVector")
//                            }.padding()
//                        })
                }
                HStack(){
                    Color.gray.opacity(0.2).frame(height:2)
                        Image("TruckInfo")
                        .overlay(
                            Circle().stroke(.white.opacity(0.7), lineWidth: 4)
                        )
                        .clipShape(Circle())
                        .frame(width: 95, height: 95, alignment: .center)
                        .cornerRadius(10)
                    
                    Color.gray.opacity(0.2).frame(height:2)
                   
                }.padding(.top)
                    .frame(width:350)
                
                Group{
                Text("Truck_Info".localized(language))
                        .font(Font.camelfonts.Med16)
                        .foregroundColor(Color("blueColor"))
                        .padding(.vertical,10)
                
                InputTextField(iconName: "X321Orange2", placeholder: "Plate_Number".localized(language), text: .constant("GTA123"))
                InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Truck_Type".localized(language), text: .constant("Open jumbo truck"))
                
                InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "License_Number".localized(language), text: .constant("254158881848292474"))
                    HStack{
                        InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Start_Date".localized(language), text: .constant("01 / 01 / 1111"))

                        InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Expiration_Date".localized(language), text: .constant("01 / 01 / 1111"))

                    }
                
                InputTextField(iconName: "ic_box",iconColor: Color("OrangColor"), placeholder: "Cargos_I_Can_Handle".localized(language), text: .constant("Metals, Cleaning materials, Wood, M... +12"))
                }
                
                HStack{
                    Image(systemName: ageeTerms ?  "checkmark.square.fill":"square")
                        .font(.system(size: 20))
                        .foregroundColor(Color("blueColor"))
                        .onTapGesture(perform: {
                            ageeTerms .toggle()
                        })
                    
                    Text("I_agree_all".localized(language))
                    
                    Text("Terms_&_Conditions".localized(language))
                        .underline()
                        .foregroundColor(Color("blueColor"))
                        Spacer()
                }.padding(.vertical)
                Spacer(minLength: 30)

            }.padding(.top,hasNotch ? 140:130)
                .padding(.bottom, 90)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
            TitleBar(Title: taskStatus == .create ? "Create_an_account".localized(language) : "Profile_info".localized(language), navBarHidden: true, leadingButton: .backButton, subText: "70%", trailingAction: {})
        
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .white, content: {
                Button(action: {
                    DispatchQueue.main.async{
//                        switch taskStatus {
//                        case .create:
//                            <#code#>
//                        case .update:
//                            <#code#>
//                        }
                    }
                }, label: {
                    HStack {
                        Text(taskStatus == .create ? "Create_account".localized(language) : "Save_Changes".localized(language))
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
        EditProfileInfoView(taskStatus: .update)
        EditProfileInfoView(taskStatus: .update)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

