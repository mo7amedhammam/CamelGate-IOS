//
//  EditProfileInfoView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI
//import Alamofire

enum ProfileStep{
    case create, update
}
enum datesource: Hashable {
    case birthDate,liceseExpire,truckStart,truckEnd,none
}

struct EditProfileInfoView: View {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var imageVM : camelEnvironments
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
//    @State var showsheet = false
    @State var ShowCalendar  = false
    @State var showBottomSheet  = false

    @State var dateSorceinput:datesource = .none
    @State var rangeType:dateRange = .open
    @State var selectedDate:Date = Date()
    @State var startingDate = Date()
    @State var endingDate = Date()
    @State var active = false
    @State var destination = AnyView(TabBarView().navigationBarHidden(true))
    
    var years:[String] = []
    @FocusState var inFocus: Int?
    @State var activepicker = false
    
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
                        }
                        
                        //MARK: - birthdate and gender -
                        HStack{
                                InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: $profileVM.BirthdateStr,Disabled:true)
                                    .overlay(content: {
//                                        DatePicker("            ", selection: $profileVM.Birthdate,in: ...(Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()) ,displayedComponents: [.date])
//                                            .opacity(0.02)
//                                            .labelsHidden()
//                                            .frame(minHeight:50)
//                                            .frame(minWidth:g.size.width)
//                                            .frame(minWidth:(UIScreen.main.bounds.width-150))

//                                            .background(
                                                HStack{
                                                    Spacer()
                                                    Image(systemName:language.rawValue == "en" ? "chevron.right":"chevron.left")
                                                        .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                                        .padding(.horizontal)
                                                }
//                                            )
                                        //                        .frame(minWidth:g.size.width)
                                    })
                                    .onTapGesture(perform: {
//                                        DispatchQueue.main.async(execute: {
//                                            selectedDate = profileVM.Birthdate
                                        dateSorceinput = .birthDate
//                                        startingDate = (Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date())
//                                        endingDate = (Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())
//                                        })
//                                        ShowCalendar = true
                                    })
                            
                            InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Gender".localized(language), text: profileVM.gender == 1 ? .constant("Male".localized(language)):.constant("Female".localized(language)),Disabled:true)
                                .frame(width:130)
                                .overlay(content: {
                                    Menu {
                                        Button("Male".localized(language), action: {
                                            profileVM.gender = 1
                                            profileVM.IsDropDownChange = true
                                        })
                                        Button("Female".localized(language), action: {
                                            profileVM.gender = 2
                                            profileVM.IsDropDownChange = true
                                        })
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                                .padding(.trailing)
                                        }
                                        //                                        .padding(.vertical,-20)
                                        .frame(minHeight:50)

                                    }
                                    .frame(minHeight:50)
                                })
                        }
                        
                        InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Nationality".localized(language), text: .constant(getNationalityName(nationalityId: profileVM.NationalityId)) ,Disabled:true)
                            .overlay(content: {
                                Menu {
                                    ForEach(nationalityVM.publishedNationalitiesArray ,id:\.self){nationality in
                                        Button(
                                            nationality.title ?? ""
                                            , action: {
                                                profileVM.NationalityId = nationality.id ?? 0
//                                                profileVM.nationalityName = nationality.title ?? ""
                                                profileVM.IsDropDownChange = true
                                            })
                                    }
                                } label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                            .padding(.trailing)
                                    }
                                    .frame(minHeight:50)

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
                                            .font(language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)
                                        Spacer()
                                    }
                                }
                            }
                            HStack{
                                InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "resident".localized(language), text: profileVM.RedisentOptions == 1 ? .constant("Citizen".localized(language)):profileVM.RedisentOptions == 2 ? .constant("Resident".localized(language)):.constant("Border".localized(language))  ,Disabled:true)
                                    .frame(width:130)
                                    .overlay(content: {
                                        Menu {
                                            Button("Citizen_Id".localized(language), action: {
                                                profileVM.IsDropDownChange = true
                                                profileVM.RedisentOptions = 1
                                            })
                                            Button("Resident_Id".localized(language), action: {
                                                profileVM.IsDropDownChange = true
                                                profileVM.RedisentOptions = 2
                                            })
                                            Button("Border_Id".localized(language), action: {
                                                profileVM.IsDropDownChange = true
                                                profileVM.RedisentOptions = 3
                                            })
                                            
                                        } label: {
                                            HStack{
                                                Spacer()
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color("lightGray").opacity(0.5))
                                                    .padding(.trailing)
                                            }
                                            .frame(minHeight:50)

                                            
                                        }
                                        .frame(minHeight:50)
                                        
                                    })
                                
                                InputTextField(iconName: "", placeholder: "Id".localized(language), placeholderColor:(profileVM.validations == .ResidentId && profileVM.ValidationMessage != "") ? .red:.gray.opacity(0.5), text: profileVM.RedisentOptions == 1 ? $profileVM.citizenId:profileVM.RedisentOptions == 2 ? $profileVM.residentId : $profileVM.borderId)
                                    .onChange(of: profileVM.citizenId  ){ newval in
                                        profileVM.IsDropDownChange = true
                                        profileVM.RedisentNumLength = 10
                                        profileVM.citizenId = language.rawValue == "ar" ? String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish():String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish()
                                    }
                                    .onChange(of: profileVM.residentId  ){ newval in
                                        profileVM.IsDropDownChange = true
                                        profileVM.RedisentNumLength = 16
                                        profileVM.residentId = language.rawValue == "ar" ? String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish():String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish()
                                    }
                                    .onChange(of: profileVM.borderId  ){ newval in
                                        profileVM.IsDropDownChange = true
                                        profileVM.RedisentNumLength = 16
                                        profileVM.borderId = language.rawValue == "ar" ? String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish():String(newval.prefix(profileVM.RedisentNumLength)).replacedArabicDigitsWithEnglish()
                                    }
                                    .focused($inFocus,equals:2)
                                    .onTapGesture(perform: {
                                        inFocus = 2
                                    })
                            }
                        }
                     
                        VStack{
                            if profileVM.validations == .Email{
                                HStack{
                                    Text(profileVM.ValidationMessage.localized(language))
                                        .foregroundColor(.red)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)
                                    Spacer()
                                }
                            }
                        InputTextField(iconName: "Shipments",iconColor: Color("OrangColor"), placeholder: "Email".localized(language), text:$profileVM.Email)
                            .focused($inFocus,equals:3)
                            .onTapGesture(perform: {
                                inFocus = 3
                            })
                    }
                        VStack {
                            if profileVM.validations == .DriverLicense {
                                HStack{
                                    Text(profileVM.ValidationMessage.localized(language))
                                        .foregroundColor(.red)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)

                                    Spacer()
                                }
                            }
                            InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "Driving_Licence".localized(language), text: $profileVM.LicenseNumber )
                                .onChange(of: profileVM.LicenseNumber  ){ newval in
                                    profileVM.LicenseNumber = language.rawValue == "ar" ?  newval.replacedArabicDigitsWithEnglish():newval.replacedArabicDigitsWithEnglish()
                                    profileVM.LicenseNumber =  String(newval.prefix(profileVM.LicenseNumLength))
                                }
                                .focused($inFocus,equals:4)
                                .onTapGesture(perform: {
                                    inFocus = 4
                                })
                        }
                        
                        InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Licence_Expiration_Date".localized(language), text: $profileVM.LicenseExpireDateStr,Disabled:true)
                            .overlay(
//                                    DatePicker("", selection: $profileVM.LicenseExpireDate,in: (Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date())..., displayedComponents: [.date])
//                                        .labelsHidden()
//                                        .opacity(0.02)
//                                        .frame(minHeight:50)
//                                        .frame(width:UIScreen.main.bounds.width)
////                                        .clipped()
//                                        .background(
                                HStack(){
                                    Spacer()
                                    Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                        .foregroundColor(Color("lightGray").opacity(0.5))
                                        .padding(.horizontal)
                                }
//                                )
                            )
                            .onTapGesture(perform: {
                                dateSorceinput = .liceseExpire
//                                selectedDate = profileVM.LicenseExpireDate
//                                ShowCalendar = true
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
                        
                        InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Truck_Type".localized(language), text: .constant(getTruckTypeName(TypeId: Int(profileVM.TruckTypeId) ?? 0)),Disabled:true)
                            .overlay(content: {
                                Menu {
                                    ForEach(trucktypesVM.publishedTypesArray,id:\.self){type in
                                        Button(type.title ?? "", action: {
                                            profileVM.TruckTypeId = "\(type.id ?? 0)"
                                            profileVM.TruckTypeName = "\(type.title ?? "")"
                                            profileVM.IsDropDownChange = true
                                        })
                                    }
                                } label: {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color("lightGray").opacity(0.5))
                                            .padding(.trailing)
                                        
                                    }
                                    .frame(minHeight:50)

                                }
                                .frame(minHeight:50)
                            })
                        
                        //MARK: - truck manfacturer and model -
                        HStack{
                            InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Manfacturer".localized(language), text: .constant(getManfacturerName(ManfacturerId: Int(profileVM.TruckManfacturerId) ?? 0)),Disabled:true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(truckmanfacturersVM.publishedManfacturersArray,id:\.self){Manfacturer in
                                            Button(Manfacturer.title ?? "", action: {
                                                profileVM.TruckManfacturerId = "\(Manfacturer.id ?? 0)"
                                                profileVM.TruckManfacturerName = "\(Manfacturer.title ?? "")"
                                                profileVM.IsDropDownChange = true
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))
                                                .padding(.trailing)
                                        }
                                        .frame(minHeight:50)

                                    }
                                    .frame(minHeight:50)
                                    
                                })
                            
                            InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Model".localized(language), text:.constant( language.rawValue == "ar" ? profileVM.TruckManfactureYear.replacedArabicDigitsWithEnglish():profileVM.TruckManfactureYear.replacedArabicDigitsWithEnglish()),Disabled:true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(getYearsArr().reversed(),id:\.self){ year1 in
                                            Button(year1, action: {
                                                profileVM.TruckManfactureYear = "\(year1)"
                                                profileVM.IsDropDownChange = true
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))
                                                .padding(.trailing)
                                        }
                                        .frame(minHeight:50)
                                    }
                                    .frame(minHeight:50)
                                })
                        }
                        
                        //MARK: - AXE number and Plate number -
                        HStack{
                            InputTextField(iconName: "X321Orange2", placeholder: "AXE_Number".localized(language), text:.constant(language.rawValue == "ar" ? profileVM.NumberofAxe.replacedArabicDigitsWithEnglish():profileVM.NumberofAxe.replacedArabicDigitsWithEnglish()),Disabled:true)
                                .overlay(content: {
                                    Menu {
                                        ForEach(1..<5,id:\.self){ AxeNum in
                                            Button("\(AxeNum)", action: {
                                                profileVM.NumberofAxe = "\(AxeNum)"
                                                profileVM.IsDropDownChange = true
                                            })
                                        }
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color("lightGray").opacity(0.5))
                                            
                                                .padding(.trailing)
                                        }
                                        .frame(minHeight:50)
                                    }
                                    .frame(minHeight:50)
                                })
                            
                            InputTextField(iconName: "X321Orange2", placeholder: "Plate_Number".localized(language), text:$profileVM.TruckPlate)
                                .onChange(of: profileVM.TruckPlate, perform: {newval in
                                    profileVM.IsDropDownChange = true
//                                    profileVM.TruckPlate = language.rawValue == "ar" ?
//                                    newval.replacedArabicDigitsWithEnglish():newval.replacedArabicDigitsWithEnglish()
                                })
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
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)
                                    
                                    Spacer()
                                }
                            }
                            InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "License_Number".localized(language), text: $profileVM.TruckLicense)
                                
                                .onChange(of: profileVM.TruckLicense  ){ newval in
                                    profileVM.IsDropDownChange = true
                                    profileVM.TruckLicense = language.rawValue == "ar" ? newval.replacedArabicDigitsWithEnglish():newval.replacedArabicDigitsWithEnglish()
                                    profileVM.TruckLicense =  String(newval.prefix( profileVM.LicenseNumLength))
                                }
                                .focused($inFocus,equals:6)
                                .onTapGesture(perform: {
                                    inFocus = 6
                                })
                        }
                        
                        //MARK: -- truck license start and expire date --
                        HStack(){
                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Start_Date".localized(language), text: $profileVM.TruckLicenseIssueDateStr,Disabled:true)
                                    .overlay(
//                                        DatePicker("", selection: $profileVM.TruckLicenseIssueDate,in: ...Date(), displayedComponents: [.date])
//                                            .labelsHidden()
//                                            .opacity(0.02)
//                                            .frame(minHeight:50)
//                                            .frame(minWidth:UIScreen.main.bounds.width/2)
//
//                                            .background(
                                                HStack{
                                                    Spacer()
                                                    Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                                        .foregroundColor(Color("lightGray").opacity(0.5))
                                                        .padding(.horizontal)
                                                }
//                                            )
                                    )
                                    .onTapGesture(perform: {
                                        dateSorceinput = .truckStart
                                    })
                                
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Expiration_Date".localized(language), text: $profileVM.TruckLicenseExpirationDateStr,Disabled:true)
                                   
                                    .overlay(
//                                        DatePicker("", selection: $profileVM.TruckLicenseExpirationDate,in: (Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date())..., displayedComponents: [.date])
//                                            .opacity(0.02)
//                                            .frame(minHeight:50)
//                                            .labelsHidden()
//                                            .frame(minWidth:UIScreen.main.bounds.width/2)
//                                            .background(
                                                HStack{
                                                    Spacer()
                                                    Image(systemName: language.rawValue == "en" ? "chevron.right":"chevron.left")
                                                        .foregroundColor(Color("lightGray").opacity(0.5))
                                                        .padding(.horizontal)
                                                }
//                                            )
                                    )
                                    .onTapGesture(perform: {
                                        dateSorceinput = .truckEnd
                                    })
                        }
                    }
//                    if taskStatus == .create{
//                        HStack{
//                            Image(systemName: ageeTerms ?  "checkmark.square.fill":"square")
//                                .font(.system(size: 20))
//                                .foregroundColor(Color("blueColor"))
//                                .onTapGesture(perform: {
//                                    ageeTerms .toggle()
//                                    profileVM.IsTermsAgreed.toggle()
//                                })
//
//                            Text("I_agree_all".localized(language))
//
//                            Button(action: {
//                                showsheet = true
//                            }, label: {
//                                Text("Terms_&_Conditions".localized(language))
//                                    .underline()
//                                    .foregroundColor(Color("blueColor"))
//                            })
//                                .sheet(isPresented: $showsheet){
//                                    // Terms and Conditions here
//                                }
//                            Spacer()
//                        }.padding(.vertical)
//                    }
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
            
            TitleBar(Title: taskStatus == .create ? "Create_an_account".localized(language) : "Profile_info".localized(language), navBarHidden: true, leadingButton: .backButton,trailingButton: taskStatus == .update ? LoginManger.getUser()?.isDriverInCompany ?? false ? TopButtons.none :.editButton:TopButtons.none , trailingAction: {
                DispatchQueue.main.async(execute: {
                    isEditing.toggle()
                    profileVM.IsDropDownChange = false
                })
            })
            
            //            if (taskStatus == .update && LoginManger.getUser()?.isDriverInCompany == false){
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .white, content: {
                GradientButton(action: {
                    DispatchQueue.main.async{
                        profileVM.CompleteProfile()
                    }
                },Title: taskStatus == .create ? "Create_account".localized(language): "Save_Changes".localized(language) , IsDisabled:.constant(
                    
                    self.taskStatus == .create ? IsClearinputs() : !(isEditing && !IsValidinputs())
                    
//                    (
//                        (
////                            taskStatus == .create && IsClearinputs()
//                            false
//                     )
//                     ||
//                     (
////                        !(taskStatus == .update && isEditing) ||
//                        ((taskStatus == .update && !isEditing) && (profileVM.Drivername == "" || profileVM.BirthdateStr == "" || profileVM.LicenseNumber == "" || profileVM.LicenseExpireDateStr == "" || profileVM.TruckTypeName == "" || profileVM.TruckManfacturerName == "" || profileVM.TruckLicense == "" || profileVM.TruckLicenseIssueDateStr == "" || profileVM.TruckLicenseExpirationDateStr == "" || profileVM.TruckPlate == "" || profileVM.TruckManfactureYear == "" || (profileVM.citizenId == "" && profileVM.residentId == "" && profileVM.borderId == "") || (profileVM.validations != .none && profileVM.ValidationMessage != "") || profileVM.IsDropDownChange == false))
//                     )
//                    )
//                    || (taskStatus == .update && isEditing == false)
                )
                )
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .navigationBarHidden(true)
        .onAppear(perform: {
            if taskStatus == .update{

            }else{
                if enteredDriverName != ""{
                    profileVM.Drivername = enteredDriverName
                }
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//                profileVM.IsDropDownChange = false
//            })
        })
       
        .overlay(
            ZStack{
            if ShowCalendar == true{
                calendarPopUp( selectedDate: $selectedDate, isPresented: $ShowCalendar,rangeType:rangeType,startingDate:startingDate,endingDate:endingDate)
                        }
            }
        )
        .onChange(of: profileVM.DriverImage, perform: {newval in
            profileVM.IsDropDownChange = true
        })
        .onChange(of: profileVM.Drivername, perform: {newval in
            profileVM.IsDropDownChange = true
        })
        .onChange(of: profileVM.Email, perform: {newval in
            profileVM.IsDropDownChange = true
        })
        .onChange(of: dateSorceinput , perform: {newval in
            switch newval{
            case .birthDate:
                selectedDate = profileVM.Birthdate
                rangeType = .withend
                startingDate = (Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date())
                endingDate = (Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())
                    ShowCalendar = true
                
            case .liceseExpire:
                selectedDate = profileVM.LicenseExpireDate
                rangeType = .withstart
                startingDate = (Calendar.current.date(byAdding: .day, value: +1 , to: Date()) ?? Date())
                endingDate = (Calendar.current.date(byAdding: .year, value: +10, to: Date()) ?? Date())
                ShowCalendar = true
                
            case .truckStart:
                selectedDate = profileVM.TruckLicenseIssueDate
                rangeType = .withend
                startingDate = (Calendar.current.date(byAdding: .year, value: -10 , to: Date()) ?? Date())
                endingDate = (Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date())
                ShowCalendar = true
                
            case .truckEnd:
                selectedDate = profileVM.TruckLicenseExpirationDate
                rangeType = .withstart
                startingDate = (Calendar.current.date(byAdding: .day, value: +1 , to: Date()) ?? Date())
                endingDate = (Calendar.current.date(byAdding: .year, value: +10, to: Date()) ?? Date())
                ShowCalendar = true
            case .none:
                print("none")
            }
            
        })
        .onChange(of: ShowCalendar, perform: {newval in
            if newval == false{
                dateSorceinput = .none
            }
        })
        .onChange(of: selectedDate, perform: {newval in
            profileVM.IsDropDownChange = true
            switch dateSorceinput{
            case .birthDate:
                print(newval)
                profileVM.Birthdate = newval

            case .liceseExpire:
                print(newval)
                profileVM.LicenseExpireDate = newval

            case .truckStart:
                print(newval)
                profileVM.TruckLicenseIssueDate = newval

            case .truckEnd:
                print(newval)
                profileVM.TruckLicenseExpirationDate = newval

            case .none:
                print(newval)
            }
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
//            profileVM.IsDropDownChange = true
            if newval == 1 {
                profileVM.RedisentHint = "Hint:_Citizen_ID_should_start_with_1_with_maximum_10_Numbers"
                profileVM.residentId = ""
                profileVM.citizenId = ""
            }else if newval == 2{
                profileVM.RedisentHint = "Hint:_Resident_ID_should_start_with_2_with_maximum_16_Numbers"
                profileVM.citizenId = ""
                profileVM.borderId = ""
            }else if newval == 3{
                profileVM.RedisentHint = "Hint:_Border_ID_should_start_with_5_with_maximum_16_Numbers"
                profileVM.residentId = ""
                profileVM.citizenId = ""
            }
        })
        .onChange(of: profileVM.Birthdate, perform: {newval in
//            profileVM.IsDropDownChange = true
            profileVM.BirthdateStr = newval.DateToStr(format: language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd",isPost: true)

//            print("\(newval.formatted(.dateTime))") // 12/31/1998, 2:00 AM
//            print("\(newval.formatted(.dateTime.hour()))") // 2 AM
//            print("\(newval.formatted(.dateTime.hour().minute()))") // 2:00 AM
//            print("\(newval.formatted(.dateTime.day()))") // 31
//            print("\(newval.formatted(.dateTime.month()))") // Dec
//            print("\(newval.formatted(.dateTime.year().month().day()))") //  Dec 31, 1998
        })
        .onChange(of: profileVM.LicenseExpireDate, perform: {newval in
            profileVM.IsDropDownChange = true
            profileVM.LicenseExpireDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd",isPost: true)
        })
        .onChange(of: profileVM.TruckLicenseIssueDate, perform: {newval in
            profileVM.IsDropDownChange = true
            profileVM.TruckLicenseIssueDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd",isPost: true)
        })
        .onChange(of: profileVM.TruckLicenseExpirationDate, perform: {newval in
            profileVM.IsDropDownChange = true
            profileVM.TruckLicenseExpirationDateStr = newval.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy": "yyyy/MM/dd",isPost: true)
        })
        .onChange(of: profileVM.Drivername, perform: {newval in
            profileVM.IsDropDownChange = true
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
                                profileVM.IsDropDownChange = false
                                self.presentationMode.wrappedValue.dismiss()
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
        .overlay(
            ZStack{
            if profileVM.isAlert{
                CustomAlert(presentAlert: $profileVM.isAlert,alertType: .error(title: "", message: profileVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                    if profileVM.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        destination = AnyView(SignInView())
                        active = true
                    }
                    DispatchQueue.main.async(execute: {
                        profileVM.isAlert = false
//                        environments.isError = false
                    })
                })
                }
            }.ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
//                .onChange(of: profileVM.isAlert, perform: {newval in
//                    DispatchQueue.main.async {
//                        if newval == true{
////                    environments.isError = true
//                    }
//                    }
//                })
//                .onAppear(perform: {
//                    if environments.isError == false && WalletVM.isAlert == true{
////                        environments.isError = true
//                    }
//                })

        )
        
        // Alert with no internet connection
//        .alert(isPresented: $profileVM.isAlert, content: {
//            Alert(title: Text(profileVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
//                if profileVM.activeAlert == .unauthorized{
//                    Helper.logout()
//                    LoginManger.removeUser()
//                    destination = AnyView(SignInView())
//                    active = true
//                }
//                DispatchQueue.main.async(execute: {
//                    profileVM.isAlert = false
//                })
//            }))
//        })
        
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            EditProfileInfoView(taskStatus: .create)
                .environmentObject(camelEnvironments())
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        
//        ZStack {
//            EditProfileInfoView(taskStatus: .update)
//                .environmentObject(camelEnvironments())
//        }
//        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        
    }
}


extension EditProfileInfoView{
    
    func getYearsArr() -> [String]{
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        return (1950...currentYear).map { String($0) }
    }
    
    
    func IsClearinputs() -> Bool {
        return (
            profileVM.Drivername == ""
            || profileVM.BirthdateStr == ""
            || profileVM.LicenseNumber == ""
            || profileVM.LicenseExpireDateStr == ""
            || profileVM.TruckTypeName == ""
            || profileVM.TruckManfacturerName == ""
            || profileVM.TruckLicense == ""
            || profileVM.TruckLicenseIssueDateStr == ""
            || profileVM.TruckLicenseExpirationDateStr == ""
            || profileVM.TruckPlate == ""
            || profileVM.TruckManfactureYear == ""
            || (profileVM.citizenId == "" && profileVM.residentId == "" && profileVM.borderId == "")
            || (profileVM.validations != .none && profileVM.ValidationMessage != "")
        )
    }
    
    func IsValidinputs() -> Bool {
        return ( (
            profileVM.Drivername == ""
            || profileVM.BirthdateStr == ""
            || profileVM.LicenseNumber == ""
            || profileVM.LicenseExpireDateStr == ""
            || profileVM.TruckTypeName == ""
            || profileVM.TruckManfacturerName == ""
            || profileVM.TruckLicense == ""
            || profileVM.TruckLicenseIssueDateStr == ""
            || profileVM.TruckLicenseExpirationDateStr == ""
            || profileVM.TruckPlate == ""
            || profileVM.TruckManfactureYear == ""
            || (profileVM.citizenId == "" && profileVM.residentId == "" && profileVM.borderId == "")
            || (profileVM.validations != .none && profileVM.ValidationMessage != "")
            || profileVM.IsDropDownChange == false
        )
        )
    }
    
    func getNationalityName(nationalityId:Int) -> String {
        var name = ""
        for n in nationalityVM.publishedNationalitiesArray {
            if n.id == nationalityId {
                name = n.title ?? ""
            }
        }
       return name
    }
    
    func getTruckTypeName(TypeId:Int) -> String {
        var name = ""
        for n in trucktypesVM.publishedTypesArray {
            if n.id == TypeId {
                name = n.title ?? ""
            }
        }
       return name
    }
    func getManfacturerName(ManfacturerId:Int) -> String {
        var name = ""
        for n in truckmanfacturersVM.publishedManfacturersArray {
            if n.id == ManfacturerId {
                name = n.title ?? ""
            }
        }
       return name
    }
}
