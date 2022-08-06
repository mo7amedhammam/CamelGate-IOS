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
    @StateObject var profileVM = DriverInfoViewModel()
     var taskStatus:ProfileStep
    
//    @State private var image = UIImage()
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
    
    @State var ageeTerms = false
    @State var showsheet = false
    @State var ShowCalendar  = false

    @State var selectedDate:Date?
    
    @State var active = false
    @State var destination = AnyView( TabBarView().navigationBarHidden(true))

    
    var body: some View {
        ZStack{
            
            ScrollView{
                
                ZStack(alignment:.bottomTrailing){
                    Button(action: {
                        // here if you want to preview image
                    }, label: {
                        if profileVM.DriverImage.size.width == 0 {
                        
                        AsyncImage(url: URL(string:  Helper.getDriverimage())) { image in
                            image.resizable()
                        } placeholder: {
                            Color("lightGray").opacity(0.2)
                        }
                        .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))

                        }else{
                            Image(uiImage: profileVM.DriverImage)
                                .resizable()
                        .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
                        }
                    })
                        .clipShape(Circle())
                        .frame(width: 95, height: 95, alignment: .center)
                    
                    CircularButton(ButtonImage:Image("pencil") , forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                        self.showImageSheet = true
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
                    HStack{
                        DateInputView( placeholder: "BirthDate", date: $profileVM.Birthdate)
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
                    
                    
                    
                    DateInputView( placeholder: "Licence_Expiration_Date", date: $profileVM.LicenseExpireDate)
 
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

                    InputTextField(iconName: "truckgray",iconColor: Color("OrangColor"), placeholder: "Truck_Type".localized(language), text: $profileVM.TruckTypeId)
                        .disabled(true)
                        .overlay(content: {
                            Menu {
                                Button("Jumbo 1", action: {profileVM.TruckTypeId = "1"})
                                Button("Jumbo 2", action: {profileVM.TruckTypeId = "2"})
                                Button("Jumbo 3", action: {profileVM.TruckTypeId = "3"})

                            } label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.trailing)
                            }.padding()
                        })

                    HStack{
                    InputTextField(iconName: "X321Orange2", placeholder: "AXE_Number".localized(language), text: $profileVM.NumberofAxe)
                    InputTextField(iconName: "X321Orange2", placeholder: "Plate_Number".localized(language), text: $profileVM.TruckPlate)
                    }
                    InputTextField(iconName: "IdCardOrange",iconColor: Color("OrangColor"), placeholder: "License_Number".localized(language), text: $profileVM.TruckLicense)
                    HStack{

                        DateInputView( placeholder: "Start_Date", date: $profileVM.TruckLicenseIssueDate)

                        DateInputView( placeholder: "Expiration_Date", date: $profileVM.TruckLicenseExpirationDate)
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
                        profileVM.CompleteProfile()
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
//
//            if ShowCalendar == true{
//                ZStack{
//                    calendarPopUp( selectedDate: $selectedDate, isPresented: $ShowCalendar)
//                        }
//            }

        }.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
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
