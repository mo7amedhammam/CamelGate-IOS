//
//  EditProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI
import Alamofire

enum ProfileStep{
    case create, update
}
//enum FocusElement: Hashable {
//    case name
//    case email
//}


struct EditProfileInfoView: View {
//    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    @StateObject var profileVM = DriverInfoViewModel()
    @StateObject var trucktypesVM = TruckTypeViewModel()
    @StateObject var truckmanfacturersVM = TruckManfacturerViewModel()
    @StateObject var nationalityVM = nationalityViewModel()

    var taskStatus:ProfileStep
    @State private var isEditing = false
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
    
    @State var enteredDriverName = ""

    @State var ageeTerms = false
    @State var showsheet = false
    @State var ShowCalendar  = false
    @State var showBottomSheet  = false
    
    @State var selectedDate:Date?
    @State var active = false
    @State var destination = AnyView( TabBarView().navigationBarHidden(true))
    @EnvironmentObject var imageVM : imageViewModel
  
    var years:[String] = []
    @FocusState var inFocus: Int?

    var body: some View {
        ZStack{
            ScrollView(showsIndicators:false){
                ZStack(alignment:.bottomTrailing){
                    Button(action: {
                        // here if you want to preview image
                    }, label: {
                        ZStack{
                            if profileVM.DriverImage.size.width == 0 {
                                AsyncImage(url: URL(string: Constants.baseURL +  profileVM.DriverImageStr.replacingOccurrences(of: "\\",with: "/"))) { image in
                                    image.resizable()
                                        .onTapGesture(perform: {
                                            imageVM.isPresented = true
                                            imageVM.imageUrl = Constants.baseURL +  profileVM.DriverImageStr.replacingOccurrences(of: "\\",with: "/")
                                        })
                                } placeholder: {
                                    Color("lightGray").opacity(0.2)
                                }
                            }else{
                                Image(uiImage: profileVM.DriverImage)
                                    .resizable()
                            }
                        }
                        .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                    })
                        .clipShape(Circle())
                        .frame(width: 95, height: 95, alignment: .center)
                    
                    if (taskStatus == .update && isEditing == true) || taskStatus == .create{
                        CircularButton(ButtonImage:Image("pencil") , forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                            self.showImageSheet = true
                        }
                    }
                }
                Group{
                    Group{
                        Text("Driver_Info".localized(language))
                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                            .foregroundColor(Color("blueColor"))
                            .padding(.vertical,10)
                        if taskStatus == .update{
                            // card is here
                        }
                        
                        VStack{
                        InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "name".localized(language), text: $profileVM.Drivername)
                                .focused($inFocus,equals:1)
                                .onTapGesture(perform: {
                                    inFocus = 1
                                })
//                                .textFieldStyle(RoundedBorderTextFieldStyle())

//                        InputTextField1(iconName: "person",iconColor: Color("OrangColor"), placeholder: "name".localized(language), text: $profileVM.Drivername)
                            
//                            InputTextField1(iconName: "person",iconColor: Color("OrangColor"), placeholder: "name".localized(language), text: $profileVM.Drivername)
//                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr24:Font.camelfonts.Reg24)
//
//                            InputTextField1(iconName: "person",iconColor: Color("OrangColor"), placeholder: "name".localized(language), text: $profileVM.Drivername)
//                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr24:Font.camelfonts.Reg24)

//                        InputTextField22(iconName: "person",iconColor: Color("OrangColor"), placeholder: "name".localized(language), text: $profileVM.Drivername)
                        }
                        
                        //MARK: - birthdate and gender -
                        HStack{
//                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: $profileVM.BirthdateStr)
//                                                    .disabled(true)
//                                .overlay(content: {
//                                    HStack{
//                                        DatePicker("           ", selection: $profileVM.Birthdate,in: ...(Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()) ,displayedComponents: [.date])
//                                            .opacity(0.02)
//                                            .labelsHidden()
//                                            .frame(minHeight:50)
////                                        Spacer()
//                                        Image(systemName:language.rawValue == "en" ? "chevron.right":"chevron.left")
//                                            .foregroundColor(                                    Color("lightGray").opacity(0.5))
//                                            .padding(.horizontal)
//                                    }
////                                    .frame(minHeight:50)
//
//                                })
                            
                            
                            
                            GeometryReader {g in
                                InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: $profileVM.BirthdateStr)
                                                        .disabled(true)
                                    .overlay(content: {
                                        DatePicker("", selection: $profileVM.Birthdate,in: ...(Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()) ,displayedComponents: [.date])
                                            .opacity(0.02)
                                            .labelsHidden()
                                            .frame(minHeight:50)
                                            .frame(minWidth:g.size.width)
                                        HStack{
                                                            Spacer()
                                            Image(systemName:language.rawValue == "en" ? "chevron.right":"chevron.left")
                                                .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                                .padding(.horizontal)
                //                                .frame(width:20)
                                        }
                //                        .frame(minWidth:g.size.width)

                                })
                            }
                            
                            InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Gender".localized(language), text: profileVM.gender == 1 ? .constant("Male".localized(language)):.constant("Female".localized(language)))
                                .frame(width:130)
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        Button("Male".localized(language), action: {profileVM.gender = 1})
                                        Button("Female".localized(language), action: {profileVM.gender = 2})
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                                .padding(.trailing)

                                        }

//                                        .padding(.vertical,-20)
                                    }
                                    .frame(minHeight:50)

                                })
                        }
                        
                        InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Nationality".localized(language), text: $profileVM.nationalityName)
                            .disabled(true)
                            .overlay(content: {
                                Menu {
                                    ForEach(nationalityVM.publishedNationalitiesArray ,id:\.self){nationality in
                                        Button(
                                            nationality.title ?? ""
                                            , action: {
                                            profileVM.NationalityId = nationality.id ?? 0
                                            profileVM.nationalityName = nationality.title ?? ""
                                        })
                                    }
                                } label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                            .padding(.trailing)
                                    }
                                }
                                .frame(minHeight:50)

                            })
                        
                        //MARK: - resident and Id -
                        VStack {
                            if taskStatus == .create || isEditing{
                                withAnimation{
                            HStack {
                                Text(profileVM.RedisentHint.localized(language))
                                    .foregroundColor(.red)
                                .font(.system(size:11))
                                Spacer()
                            }
                            }
                            }
                            HStack{
                                InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "resident".localized(language), text: profileVM.RedisentOptions == 1 ? .constant("Citizen".localized(language)):profileVM.RedisentOptions == 2 ? .constant("Resident".localized(language)):.constant("Border".localized(language))  )
                                    .frame(width:130)
                                    .disabled(true)
                                    .overlay(content: {
                                        Menu {
                                            Button("Citizen_Id".localized(language), action: {profileVM.RedisentOptions = 1 })
                                            Button("Resident_Id".localized(language), action: {profileVM.RedisentOptions = 2})
                                            Button("Border_Id".localized(language), action: {profileVM.RedisentOptions = 3})
                                            
                                        } label: {
                                            HStack{
                                                Spacer()
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color("lightGray").opacity(0.5))
                                                    .padding(.trailing)
                                            }
                                        
                                    }
                                    .frame(minHeight:50)

                                    })
                                
                                InputTextField(iconName: "", placeholder: "Id".localized(language), placeholderColor:(profileVM.validations == .ResidentId && profileVM.ValidationMessage != "") ? .red:.gray.opacity(0.5), text: profileVM.RedisentOptions == 1 ? $profileVM.citizenId:profileVM.RedisentOptions == 2 ? $profileVM.residentId : $profileVM.borderId)
                                    .onChange(of: profileVM.citizenId  ){ newval in
                                        profileVM.citizenId =  String(newval.prefix(profileVM.RedisentNumLength))
                                    }
                                    .onChange(of: profileVM.residentId  ){ newval in
                                        profileVM.residentId =  String(newval.prefix(profileVM.RedisentNumLength))
                                    }
                                    .onChange(of: profileVM.borderId  ){ newval in
                                        profileVM.borderId =  String(newval.prefix(profileVM.RedisentNumLength))
                                    }
                                    .focused($inFocus,equals:2)
                                    .onTapGesture(perform: {
                                        inFocus = 2
                                    })
                            }
                        }
                        
                        InputTextField(iconName: "Shipments",iconColor: Color("OrangColor"), placeholder: "Email".localized(language), text:$profileVM.Email)
                            .focused($inFocus,equals:3)
                            .onTapGesture(perform: {
                                inFocus = 3
                            })
                        VStack {
                            if profileVM.validations == .DriverLicense {
                                HStack{
                                    Text(profileVM.ValidationMessage.localized(language))
                                        .foregroundColor(.red)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                                    Spacer()
                                }
                            }
                            InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "Driving_Licence".localized(language), text:.constant(language.rawValue == "ar" ?  profileVM.LicenseNumber.replacedEnglishDigitsWithArabic:profileVM.LicenseNumber.replacedArabicDigitsWithEnglish) )
                                .onChange(of: profileVM.LicenseNumber  ){ newval in
                                    profileVM.LicenseNumber =  String(newval.prefix(profileVM.LicenseNumLength))
                            }
                                .focused($inFocus,equals:4)
                                .onTapGesture(perform: {
                                    inFocus = 4
                                })
                        }
                        
                        InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Licence_Expiration_Date".localized(language), text: $profileVM.LicenseExpireDateStr)
                            .disabled(true)
                            .overlay(content: {
                                HStack(){
                                    DatePicker("", selection: $profileVM.LicenseExpireDate,in: (Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date())..., displayedComponents: [.date])
                                        .opacity(0.02)
                                        .frame(minHeight:50)

                                    Spacer().frame(minWidth:200)
                                    Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                        .foregroundColor(Color("lightGray").opacity(0.5))
                                        .padding(.horizontal)
                                }
                            })
                        
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
                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                            .foregroundColor(Color("blueColor"))
                            .padding(.vertical,10)
                        
                        InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Truck_Type".localized(language), text: $profileVM.TruckTypeName)
                            .disabled(true)
                            .overlay(content: {
                                Menu {
                                    ForEach(trucktypesVM.publishedTypesArray,id:\.self){type in
                                        Button(type.title ?? "", action: {
                                            profileVM.TruckTypeId = "\(type.id ?? 0)"
                                            profileVM.TruckTypeName = "\(type.title ?? "")"
                                        })
                                    }
                                } label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color("lightGray").opacity(0.5))
                                            .padding(.trailing)

                                    }
                                }
                                .frame(minHeight:50)
                            })
                        
                        //MARK: - truck manfacturer and model -
                        HStack{
                            InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Manfacturer".localized(language), text: $profileVM.TruckManfacturerName)
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(truckmanfacturersVM.publishedManfacturersArray,id:\.self){Manfacturer in
                                            Button(Manfacturer.title ?? "", action: {
                                                profileVM.TruckManfacturerId = "\(Manfacturer.id ?? 0)"
                                                profileVM.TruckManfacturerName = "\(Manfacturer.title ?? "")"
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))
                                                .padding(.trailing)
                                        }
                                    }
                                    .frame(minHeight:50)
                                    
                                })
                            
                            InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Model".localized(language), text:.constant( language.rawValue == "ar" ? profileVM.TruckManfactureYear.replacedEnglishDigitsWithArabic:profileVM.TruckManfactureYear.replacedArabicDigitsWithEnglish))
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(getYearsArr().reversed(),id:\.self){ year1 in
                                            Button(year1, action: {
                                                profileVM.TruckManfactureYear = "\(year1)"
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))
                                                .padding(.trailing)
                                        }
                                    }
                                    .frame(minHeight:50)

                                })
                        }
                        
                        //MARK: - AXE number and Plate number -
                        HStack{
                            InputTextField(iconName: "X321Orange2", placeholder: "AXE_Number".localized(language), text:.constant(language.rawValue == "ar" ? profileVM.NumberofAxe.replacedEnglishDigitsWithArabic:profileVM.NumberofAxe.replacedArabicDigitsWithEnglish))
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(1..<5,id:\.self){ AxeNum in
                                            Button("\(AxeNum)", action: {
                                                profileVM.NumberofAxe = "\(AxeNum)"
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))

                                                .padding(.trailing)
                                    }
                                    }
                                    .frame(minHeight:50)
                                })
                            
                            
                            InputTextField(iconName: "X321Orange2", placeholder: "Plate_Number".localized(language), text: .constant(language.rawValue == "ar" ? profileVM.TruckPlate.replacedEnglishDigitsWithArabic:profileVM.TruckPlate.replacedArabicDigitsWithEnglish))
                                .focused($inFocus,equals:5)
                                .onTapGesture(perform: {
                                    inFocus = 5
                                })
                        }
                        VStack {
                            if profileVM.validations == .TruckLicense {
                                HStack{
                                    Text(profileVM.ValidationMessage.localized(language))
                                        .foregroundColor(.red)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                                    Spacer()
                                }
                            }
                            InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "License_Number".localized(language), text: .constant(language.rawValue == "ar" ? profileVM.TruckLicense.replacedEnglishDigitsWithArabic:profileVM.TruckLicense.replacedArabicDigitsWithEnglish))
                                .onChange(of: profileVM.TruckLicense  ){ newval in
                                    profileVM.TruckLicense =  String(newval.prefix(profileVM.LicenseNumLength))
                            }
                                .focused($inFocus,equals:6)
                                .onTapGesture(perform: {
                                    inFocus = 6
                                })
                        }
                       
                        
                        //MARK: -- truck license start and expire date --
                        HStack{
                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Start_Date".localized(language), text: $profileVM.TruckLicenseIssueDateStr)
                            //                        .disabled(true)
                                .overlay(content: {
                                    HStack{
                                        DatePicker("", selection: $profileVM.TruckLicenseIssueDate,in: ...Date(), displayedComponents: [.date])
                                            .opacity(0.02)
                                            .frame(minHeight:50)

                                        Spacer()
                                        Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                            .foregroundColor(Color("lightGray").opacity(0.5))

                                    .padding(.horizontal)
                                    }
                                })
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            
                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Expiration_Date".localized(language), text: $profileVM.TruckLicenseExpirationDateStr)
                                .overlay(content: {
                                    HStack{
                                        DatePicker("", selection: $profileVM.TruckLicenseExpirationDate,in: (Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date())..., displayedComponents: [.date])
                                            .opacity(0.02)
                                            .frame(minHeight:50)

                                        Spacer()
                                        Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                            .foregroundColor(Color("lightGray").opacity(0.5))

                                    .padding(.horizontal)
                                    }
                                })
                        }
                        
                        //                        InputTextField(iconName: "ic_box",iconColor: Color("OrangColor"), placeholder: "Cargos_I_Can_Handle".localized(language), text: .constant("Metals, Cleaning materials, Wood, M... +12"))
                    }
                    if taskStatus == .create{
                        HStack{
                            Image(systemName: ageeTerms ?  "checkmark.square.fill":"square")
                                .font(.system(size: 20))
                                .foregroundColor(Color("blueColor"))
                                .onTapGesture(perform: {
                                    ageeTerms .toggle()
                                    profileVM.IsTermsAgreed.toggle()
                                })
                            
                            Text("I_agree_all".localized(language))
                            
                            Button(action: {
                                showsheet = true
                            }, label: {
                                Text("Terms_&_Conditions".localized(language))
                                    .underline()
                                    .foregroundColor(Color("blueColor"))
                            })
                                .sheet(isPresented: $showsheet){
                                    // Terms and Conditions here
                                }
                            Spacer()
                        }.padding(.vertical)
                    }
                    Spacer(minLength: 30)
                }
                .disabled((taskStatus == .update && isEditing == false) ? true:false)
            }
            .padding(.top,hasNotch ? 140:130)
                .padding(.bottom, 90)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    hideKeyboard()
                    inFocus = 0
                })
            
            TitleBar(Title: taskStatus == .create ? "Create_an_account".localized(language) : "Profile_info".localized(language), navBarHidden: true, leadingButton: .backButton,trailingButton: taskStatus == .update ? .editButton:Optional.none , trailingAction: {
                DispatchQueue.main.async(execute: {
                    isEditing.toggle()
                })
            })
            
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .white, content: {
                GradientButton(action: {
                    DispatchQueue.main.async{
                        profileVM.CompleteProfile()
                    }
                },Title: taskStatus == .create ? "Create_account".localized(language): "Save_Changes".localized(language) , IsDisabled:.constant( ((profileVM.Drivername == "" || profileVM.BirthdateStr == "" || (profileVM.validations != .none && profileVM.ValidationMessage != "") || profileVM.LicenseNumber == "" || profileVM.LicenseExpireDateStr == "" || profileVM.TruckTypeName == "" || profileVM.TruckManfacturerName == "" || profileVM.TruckLicense == "" || profileVM.TruckLicenseIssueDateStr == "" || profileVM.TruckLicenseExpirationDateStr == "" || profileVM.TruckPlate == "" || profileVM.TruckManfactureYear == "" || (profileVM.citizenId == "" && profileVM.residentId == "" && profileVM.borderId == "")) || !(taskStatus == .create && profileVM.IsTermsAgreed)) && (!(taskStatus == .update && isEditing) || (taskStatus == .update && (profileVM.Drivername == "" || profileVM.BirthdateStr == "" || profileVM.LicenseNumber == "" || profileVM.LicenseExpireDateStr == "" || profileVM.TruckTypeName == "" || profileVM.TruckManfacturerName == "" || profileVM.TruckLicense == "" || profileVM.TruckLicenseIssueDateStr == "" || profileVM.TruckLicenseExpirationDateStr == "" || profileVM.TruckPlate == "" || profileVM.TruckManfactureYear == "" || (profileVM.citizenId == "" && profileVM.residentId == "" && profileVM.borderId == "") || (profileVM.validations != .none && profileVM.ValidationMessage != "")))))
                )
            })
                               
            //
            //            if ShowCalendar == true{
            //                ZStack{
            //                    calendarPopUp( selectedDate: $selectedDate, isPresented: $ShowCalendar)
            //                        }
            //            }
            
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .navigationBarHidden(true)
        .onAppear(perform: {
            if taskStatus == .update{
                profileVM.GetDriverInfo()
            }else{
                if enteredDriverName != ""{
                profileVM.Drivername = enteredDriverName
                }
            }
//            DispatchQueue.main.asyncAfter(deadline:.now()+1.5,execute: {
//                profileVM.TruckTypeName = "\(getTruckTypeName(id: Int(profileVM.TruckTypeId) ?? 0))"
//                profileVM.TruckManfacturerName = "\(getTruckManfacturerName(id: Int(profileVM.TruckManfacturerId) ?? 0))"
//            })
        })
        .onChange(of: profileVM.TruckTypeId, perform: {newval in
            profileVM.TruckTypeName = "\(getTruckTypeName(id: Int(newval) ?? 0))"

        })
        .onChange(of: profileVM.TruckManfacturerId, perform: {newval in
            profileVM.TruckManfacturerName = "\(getTruckManfacturerName(id: Int(newval) ?? 0))"

        })

        .onChange(of: profileVM.DriverImageStr, perform: {newval in
            print(newval)
            DispatchQueue.main.async( execute: {
                profileVM.DriverImageStr = newval
                print( profileVM.DriverImageStr)
            })
        })
        .onChange(of: profileVM.UserCreated, perform: {newval in
            if newval == true{
                switch taskStatus {
                case .create:
                    active = true
                    Helper.IsLoggedIn(value: true)
                case .update:
                    showBottomSheet = true
                }
            }
        })
        .onChange(of: profileVM.RedisentOptions, perform: {newval in
            if newval == 1 {
                profileVM.RedisentNumLength = 10
                profileVM.RedisentHint = "Hint:_Citizen_ID_should_start_with_1_with_maximum_10_Numbers"
                profileVM.residentId = ""
                profileVM.citizenId = ""
            }else if newval == 2{
                profileVM.RedisentNumLength = 16
                profileVM.RedisentHint = "Hint:_Resident_ID_should_start_with_2_with_maximum_16_Numbers"
                profileVM.citizenId = ""
                profileVM.borderId = ""
            }else if newval == 3{
                profileVM.RedisentNumLength = 16
                profileVM.RedisentHint = "Hint:_Border_ID_should_start_with_5_with_maximum_16_Numbers"
                profileVM.residentId = ""
                profileVM.citizenId = ""
            }
            })
        .onChange(of: profileVM.Birthdate, perform: {newval in
            profileVM.BirthdateStr = newval.DateToStr(format: language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
        })
        .onChange(of: profileVM.LicenseExpireDate, perform: {newval in
            profileVM.LicenseExpireDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
        })
        .onChange(of: profileVM.TruckLicenseIssueDate, perform: {newval in
            profileVM.TruckLicenseIssueDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
        })
        .onChange(of: profileVM.TruckLicenseExpirationDate, perform: {newval in
            profileVM.TruckLicenseExpirationDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd")
        })
        
        //MARK: -- updated popup --
        .overlay(content: {
            if showBottomSheet{
                BottomSheetView(IsPresented: $showBottomSheet, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                    Text("Profile_Updated".localized(language))
                        .font(Font.camelfonts.Reg20)
                    Image("success-orange")
                    Text("You_just_updated_your_Info".localized(language))
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.bottom,50)
                    Button(action: {
                        DispatchQueue.main.async{
                            // Action
                            showBottomSheet.toggle()
                            DispatchQueue.main.async(execute: {
                                profileVM.UserCreated = false
                            })
                        }
                    }, label: {
                        HStack {
                            Text("Ok".localized(language))
                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
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
                    .transition(.move(edge: .bottom))
            }
        })
        
        //MARK: -------- imagePicker From Camera and Library ------
        .confirmationDialog("Choose_Image_From".localized(language), isPresented: $showImageSheet) {
            Button("photo_Library".localized(language)) { self.imgsource = "Library";   self.showImageSheet = false; self.startPicking = true }
            Button("Camera".localized(language)) {self.imgsource = "Cam" ;    self.showImageSheet = false; self.startPicking = true}
            Button("Cancel".localized(language), role: .cancel) { }
        } message: {Text("Choose_Image_From".localized(language))}
        
        .sheet(isPresented: $startPicking) {
            if imgsource == "Library"{
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileVM.DriverImage)
            }else{
                //  If you wish to take a photo from camera instead:
                ImagePicker(sourceType: .camera, selectedImage: self.$profileVM.DriverImage)
            }
        }
        .overlay(content: {
            AnimatingGif(isPresented: $profileVM.isLoading)
        })
        // Alert with no internet connection
        .alert(isPresented: $profileVM.isAlert, content: {
            Alert(title: Text(profileVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                if profileVM.activeAlert == .unauthorized{
                    Helper.logout()
                    LoginManger.removeUser()
                    destination = AnyView(SignInView())
                    active = true
                }
                DispatchQueue.main.async(execute: {
                    profileVM.isAlert = false
                })
            }))
        })
        
      
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            EditProfileInfoView(taskStatus: .create)
                .environmentObject(imageViewModel())
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))

        ZStack {
            EditProfileInfoView(taskStatus: .update)
                .environmentObject(imageViewModel())
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

    }
}


extension EditProfileInfoView{
    func getTruckTypeName(id:Int) -> String {
        var truckName = ""
        for truck in trucktypesVM.publishedTypesArray{
            if truck.id == id{
                truckName = truck.title ?? ""
            }
        }
        print(id)
        print(truckName)
        
        return truckName
    }
    
    func getTruckManfacturerName(id:Int) -> String {
        var ManfacrurerName = ""
        for Manfacrurer in truckmanfacturersVM.publishedManfacturersArray{
            if Manfacrurer.id == id{
                ManfacrurerName = Manfacrurer.title ?? ""
            }
        }
        print(id)
        print(ManfacrurerName)
        return ManfacrurerName
    }
    
    func getYearsArr() -> [String]{
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        return (1950...currentYear).map { String($0) }
    }
    
    
}





extension Binding where Value: Equatable {
    
    
    /// Given a binding to an optional value, creates a non-optional binding that projects
    /// the unwrapped value. If the given optional binding contains `nil`, then the supplied
    /// value is assigned to it before the projected binding is generated.
    ///
    /// This allows for one-line use of optional bindings, which is very useful for CoreData types
    /// which are non-optional in the model schema but which are still declared nullable and may
    /// be nil at runtime before an initial value has been set.
    ///
    ///     class Thing: NSManagedObject {
    ///         @NSManaged var name: String?
    ///     }
    ///     struct MyView: View {
    ///         @State var thing = Thing(name: "Bob")
    ///         var body: some View {
    ///             TextField("Name", text: .bind($thing.name, ""))
    ///         }
    ///     }
    ///
    /// - note: From experimentation, it seems that a binding created from an `@State` variable
    /// is not immediately 'writable'. There is seemingly some work done by SwiftUI following the render pass
    /// to make newly-created or assigned bindings modifiable, so simply assigning to
    /// `source.wrappedValue` inside `init` is not likely to have any effect. The implementation
    /// has been designed to work around this (we don't assume that we can unsafely-unwrap even after
    /// assigning a non-`nil` value), but a side-effect is that if the binding is never written to outside of
    /// the getter, then there is no guarantee that the underlying value will become non-`nil`.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    static func bindOptional(_ source: Binding<Value?>, _ defaultValue: Value) -> Binding<Value> {
        self.init(get: {
            source.wrappedValue ?? defaultValue
        }, set: {
            source.wrappedValue = ($0 as? Date) == Date() ? nil : $0
        })
    }
}


extension Binding where Value == Int {
    public func string() -> Binding<String> {
        return Binding<String>(get:{ "\(self.wrappedValue)" },
                               set: {
            guard $0.count > 0 else { return }
            self.wrappedValue = Int(Double($0) ?? 0 )
        })
    }
}
