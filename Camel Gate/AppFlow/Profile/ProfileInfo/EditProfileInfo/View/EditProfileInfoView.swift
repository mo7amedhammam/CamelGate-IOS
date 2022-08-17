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

struct EditProfileInfoView: View {
    var language = LocalizationService.shared.language

    @StateObject var profileVM = DriverInfoViewModel()
    @StateObject var trucktypesVM = TruckTypeViewModel()
    @StateObject var truckmanfacturersVM = TruckManfacturerViewModel()

    var taskStatus:ProfileStep
    @State private var isEditing = false
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
    
    @State var ageeTerms = false
    @State var showsheet = false
    @State var ShowCalendar  = false
    @State var showBottomSheet  = false

    @State var selectedDate:Date?
    @State var active = false
    @State var destination = AnyView( TabBarView().navigationBarHidden(true))
    
    var body: some View {
        ZStack{
            ScrollView{
                Group{
                    ZStack(alignment:.bottomTrailing){
                        Button(action: {
                            // here if you want to preview image
                        }, label: {
                            ZStack{
                            if profileVM.DriverImage.size.width == 0 {
                            AsyncImage(url: URL(string: "\(Constants.baseURL +  profileVM.DriverImageStr)")) { image in

//                            AsyncImage(url: URL(string: "https://camelgateapi.wecancity.com/Images//Driver//DriverImage//01f6969e-a923-4471-9311-29191bf51c92.jpg")) { image in

                                        image.resizable()
                                    } placeholder: {
                                        Color("lightGray").opacity(0.2)
//                                            .onAppear(perform: {
//                                                print(Constants.baseURL + "\(profileVM.DriverImageStr )")
//
//                                            })
                                    }
//                                    .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                            }else{
                                Image(uiImage: profileVM.DriverImage)
                                    .resizable()
                                    .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                            }
                            
                            }
                        })
                            .clipShape(Circle())
                            .frame(width: 95, height: 95, alignment: .center)
                            
                            
                        if (taskStatus == .update && isEditing == true) || taskStatus == .create{
                            CircularButton(ButtonImage:Image("pencil") , forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                                self.showImageSheet = true
                            }
                        }
                    }
//                    .onAppear(perform: {
//                        print(Constants.baseURL + "\(profileVM.DriverImageStr )")
//                    })
                    
                    Group{
                        Text("Driver_Info".localized(language))
                            .font(Font.camelfonts.SemiBold16)
                            .foregroundColor(Color("blueColor"))
                            .padding(.vertical,10)
                        if taskStatus == .update{
                            // card is here
                        }
                        HStack{
                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: $profileVM.BirthdateStr)
        //                        .disabled(true)
                                .overlay(content: {
                                    HStack{
                                        DatePicker("", selection: $profileVM.Birthdate, displayedComponents: [.date])
                                            .opacity(0.04)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }.padding(.horizontal)
                                })
//                                .padding(.horizontal)
                            
                            
                            InputTextField(iconName: "person",iconColor: Color("OrangColor"), placeholder: "Gender".localized(language), text: profileVM.gender == 1 ? .constant("Male"):.constant("Female"))
                                .frame(width:130)
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        Button("Male", action: {profileVM.gender = 1})
                                        Button("Female", action: {profileVM.gender = 2})
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
                            InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "resident".localized(language), text:     profileVM.RedisentOptions == 1 ? .constant("Citizen"):profileVM.RedisentOptions == 2 ? .constant("Resident"):.constant("Border")  )
                                .frame(width:130)
                                .disabled(true)
                                .overlay(content: {
                                    Menu {
                                        Button("Citizen Id", action: {profileVM.RedisentOptions = 1 })
                                        Button("Resident Id", action: {profileVM.RedisentOptions = 2})
                                        Button("Border Id", action: {profileVM.RedisentOptions = 3})
                                        
                                    } label: {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                        }
                                        .padding(.trailing)
                                    }
                                })
                            
                            InputTextField(iconName: "", placeholder: "Id".localized(language), text: profileVM.RedisentOptions == 1 ? $profileVM.citizenId:profileVM.RedisentOptions == 2 ? $profileVM.residentId : $profileVM.borderId)
                        }
                        
                        InputTextField(iconName: "Shipments",iconColor: Color("OrangColor"), placeholder: "Email".localized(language), text:$profileVM.Email)
                        
                        InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "Driving_Licence".localized(language), text: $profileVM.LicenseNumber)
                        
                        InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Licence_Expiration_Date".localized(language), text: $profileVM.LicenseExpireDateStr)
    //                        .disabled(true)
                            .overlay(content: {
                                HStack{
                                    DatePicker("", selection: $profileVM.LicenseExpireDate, displayedComponents: [.date])
                                        .opacity(0.08)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding(.horizontal)
                            })
//                            .padding(.horizontal)
                        
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
                            .font(Font.camelfonts.SemiBold16)
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
                                    }
                                    .padding(.trailing)
                                }.padding()
                            })
                        
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
                                        }
//                                        .padding(.trailing)
                                    }.padding()
                                })

                            InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Model".localized(language), text: $profileVM.TruckManfactureYear)
//                                .overlay(content: {
//                                    HStack{
//                                        DatePicker("", selection: $profileVM.TruckLicenseExpirationDate, displayedComponents: [.date])
//                                            .opacity(0.08)
//                                        Spacer()
//                                        Image(systemName: "chevron.right")
//                                    }.padding(.horizontal)
//                                })
                                .keyboardType(.numberPad)
                        }
                        
                        HStack{
                            InputTextField(iconName: "X321Orange2", placeholder: "AXE_Number".localized(language), text: $profileVM.NumberofAxe)
                            InputTextField(iconName: "X321Orange2", placeholder: "Plate_Number".localized(language), text: $profileVM.TruckPlate)
                        }
                        InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "License_Number".localized(language), text: $profileVM.TruckLicense)
                        HStack{
//                            DateInputView( placeholder: "Start_Date", date: $profileVM.TruckLicenseIssueDate)
                            
                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Start_Date".localized(language), text: $profileVM.TruckLicenseIssueDateStr)
        //                        .disabled(true)
                                .overlay(content: {
                                    HStack{
                                        DatePicker("", selection: $profileVM.TruckLicenseIssueDate, displayedComponents: [.date])
                                            .opacity(0.08)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }.padding(.horizontal)
                                })
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "Expiration_Date".localized(language), text: $profileVM.TruckLicenseExpirationDateStr)
                                .overlay(content: {
                                    HStack{
                                        DatePicker("", selection: $profileVM.TruckLicenseExpirationDate, displayedComponents: [.date])
                                            .opacity(0.08)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }.padding(.horizontal)
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
                }.disabled((taskStatus == .update && isEditing == false) ? true:false)
            }.padding(.top,hasNotch ? 140:130)
                .padding(.bottom, 90)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
            
            TitleBar(Title: taskStatus == .create ? "Create_an_account".localized(language) : "Profile_info".localized(language), navBarHidden: true, leadingButton: .backButton,trailingButton: taskStatus == .update ? .editButton:Optional.none , trailingAction: {
                isEditing.toggle()
            })
            
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .white, content: {
                Button(action: {
                    DispatchQueue.main.async{
                        profileVM.CompleteProfile()
                    }
                }, label: {
                    HStack {
                        Text(taskStatus == .create ? "Create_account".localized(language): "Save_Changes".localized(language))
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
                }).overlay(
                    Color.white.opacity((taskStatus == .update && isEditing == false) ?  0.5:0)
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
                print("\(Constants.baseURL +  profileVM.DriverImageStr)")
                
                DispatchQueue.main.asyncAfter(deadline:.now()+1,execute: {
                    profileVM.TruckTypeName = "\(getTruckTypeName(id: Int(profileVM.TruckTypeId) ?? 0))"
                    profileVM.TruckManfacturerName = "\(getTruckManfacturerName(id: Int(profileVM.TruckManfacturerId) ?? 0))"
                })
            })
            .onChange(of: profileVM.DriverImageStr, perform: {newval in
                print(newval)
                DispatchQueue.main.async( execute: {
                    profileVM.DriverImageStr = newval
                   print( profileVM.DriverImageStr)
                })
            })
            .onChange(of: profileVM.UserCreated, perform: {newval in
                if newval == true && taskStatus == .update{
                    showBottomSheet = true
                }
            })
        
            .overlay(content: {
                if showBottomSheet{
            
            BottomSheetView(IsPresented: $showBottomSheet, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {

                    Text("Profile_Updated".localized(language))
                        .font(Font.camelfonts.Reg20)

                    Image("success-orange")

                    Text("You_just_updated_your_Info".localized(language))
                        .font(Font.camelfonts.Reg16)
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.bottom,50)

                    Button(action: {
                        DispatchQueue.main.async{
        // Action
                            showBottomSheet.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("Ok".localized(language))
                                .font(Font.camelfonts.SemiBold16)
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
            .confirmationDialog("Choose Image From ?", isPresented: $showImageSheet) {
                Button("photo Library") { self.imgsource = "Library";   self.showImageSheet = false; self.startPicking = true }
                Button("Camera") {self.imgsource = "Cam" ;    self.showImageSheet = false; self.startPicking = true}
                Button("Cancel", role: .cancel) { }
            } message: {Text("Select Image From")}
        
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
                // showing loading indicator
                ActivityIndicatorView(isPresented: $profileVM.isLoading)
            })
        // Alert with no internet connection
            .alert(isPresented: $profileVM.isAlert, content: {
                Alert(title: Text(profileVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    profileVM.isAlert = false
                }))
            })
        
            .onChange(of: profileVM.UserCreated, perform: {newval in
                if newval == true{
                    switch taskStatus {
                    case .create:
                        active = true
                    case .update:
                        print("profile updated")
                    }
                }
            })
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct EditProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoView(taskStatus: .update)
        EditProfileInfoView(taskStatus: .update)
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
