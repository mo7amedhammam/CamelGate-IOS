//
//  DetailsView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/29/22.
//

import SwiftUI

struct DetailsView: View {
    var language = LocalizationService.shared.language

    var shipmentId:Int
    @StateObject var detailsVM = ShipmentDetailsViewModel()
    @State var ShowSetOffer:Bool = false
    @State var OfferCase:OfferCases = .set
    @State var ShowMapRedirector:Bool = false
    @State var longitude:Double = 0
    @State var latitude:Double = 0

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Button(action: {}) {
                        ZStack{
                            AsyncImage(url: URL(string: Constants.baseURL + "\(detailsVM.publishedUserLogedInModel.imageURL ?? "")".replacingOccurrences(of: "\\",with: "/"))) { image in
                                image.resizable()
                            } placeholder: {
                                Image("cover_vector")
                                    .resizable()
                            }
                            .frame(height: 120)
                        }.padding(.top , 60)
                    }
                    if detailsVM.publishedUserLogedInModel.driverOfferStatusID != nil{
                    VStack{
                        ZStack{
                            (detailsVM.publishedUserLogedInModel.driverOfferStatusID == 1 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4) ? Color(#colorLiteral(red: 0.2969967723, green: 0.8283568025, blue: 0, alpha: 1)):Color.red
                            Text("\(detailsVM.publishedUserLogedInModel.driverOfferStatusName ?? "Applied")").fontWeight(.medium).foregroundColor(Color
                                                                                                                                                    .white)
                        }.frame(height: 30)
                        ZStack{
                            Color(#colorLiteral(red: 0.2969967723, green: 0.8283568025, blue: 0, alpha: 0.2))
                            HStack {
                                Text("\(detailsVM.publishedUserLogedInModel.driverOfferValue ?? 1250)").fontWeight(.medium).foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
                                Text("SAR").fontWeight(.medium).foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
                                Text("Your Offer").foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
                            }
                        }
                        .padding(.top , -10)
                        .frame(height: 40)
                    }.padding(.top , -10)
                    ZStack{
                        HStack(alignment : .top){
                            Spacer()
                            Image("ic_lump")
                            Text("To change the offer you need to cancel the order first then to apply again").font(Font.camelfonts.Reg14).lineLimit(2)
                            Spacer()
                        }.padding()
                    }
                    .frame(height: 80)
                    .padding(.top , -10)
                    }
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
                    ZStack{
                        HStack(alignment : .top , spacing : 20){
                            VStack{
                                Text("Lowest Offer").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_green_dollar")
                                    Text("\(detailsVM.publishedUserLogedInModel.lowestOffer ?? 111) SAR")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
                                }
                            }
                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(width: 1)
                            VStack{
                                Text("Driver's Rate").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_orange_star")
                                    Text("\(detailsVM.publishedUserLogedInModel.lowestOfferDriverRate ?? 2)/5 ")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color(#colorLiteral(red: 1, green: 0.5745426416, blue: 0, alpha: 1)))
                                }
                            }
                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(width: 1)
                            VStack{
                                Text("Total Offers").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                Spacer()
                                HStack{
                                    Text("\(detailsVM.publishedUserLogedInModel.offersCount ?? 3) Offers")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color.black)
                                }
                            }
                        }.padding()
                    }
                    .frame(height: 80)
                    .padding(.top , 10)
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
                    HStack{
                        VStack {
                            VStack{
                                Text("Shipment ID").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_#")
                                    Text("\(detailsVM.publishedUserLogedInModel.id ?? 2)")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color.black)
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Total Distance").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_orange_pin")
                                    Text("\( String(format: "%.1f", detailsVM.publishedUserLogedInModel.totalDistance ?? 22.0011)) KM")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color.black)
                                }
                            }
                        }
                        Spacer()
                        VStack {
                            VStack{
                                Text("Company Rate").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_orange_star")
                                    Text("\(detailsVM.publishedUserLogedInModel.companyRate ?? 2)/5")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color.black)
                                    Text("(\(detailsVM.publishedUserLogedInModel.companyRatesCount ?? 2) Rates)")
                                        .font(Font.camelfonts.Reg14).foregroundColor(Color.black)
                                }
                            }
                            Spacer()
                            VStack{
                                Text("Estimated Time").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                                HStack{
                                    Image("ic_orange_star")
//                                    Text("\(detailsVM.publishedUserLogedInModel.estimateTime?.values .joined(separator: " - ") ?? []) ")
                                        .font(Font.camelfonts.SemiBold16).foregroundColor(Color.black)
                                }
                            }
                        }
                    }
                    .frame(height: 160)
                    .padding()
                    
                    Group{
                        Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))                        .frame(height: 1)


                    HStack {
                        Text("Description")
                            .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                        Spacer()
                    }
                    .frame(height: 40)
                    .padding(.leading , 20.0)
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                        .frame(height: 1)
                    Text(detailsVM.publishedUserLogedInModel.description ?? " description will be here ").font(Font.camelfonts.Reg16).padding()
                    
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                        .frame(height: 1)
                }
                    HStack {
                        Text("Shipment Location")
                            .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                        Spacer()
                    }
                    .frame(height: 40)
                    .padding(.leading , 20.0)
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                        .frame(height: 1)
                }
                VStack{
                    HStack {
                        HStack{
                            VStack{
                                Image("ic_pin_purple")
                                Image("ic_line")
                                Image("ic_pin_orange")
                            }
                            VStack(spacing: 30 ){
                                VStack(alignment: .leading){
                                    Text(detailsVM.publishedUserLogedInModel.fromCityName ?? "Giza").foregroundColor(Color("Base_Color"))
                                    Text(ConvertStringDate(inp:detailsVM.publishedUserLogedInModel.shipmentDateFrom ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'hh:mm:ss",FormatTo:"dd/MM/yyyy . hh:mm a"))
                                        .font(Font.camelfonts.Reg14)
                                    
                                }
                                VStack(alignment: .leading){
                                    Text(detailsVM.publishedUserLogedInModel.toCityName ?? "Alexandria").foregroundColor(Color("Second_Color"))
                                    Text(ConvertStringDate(inp:detailsVM.publishedUserLogedInModel.shipmentDateTo ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'hh:mm:ss",FormatTo:"dd/MM/yyyy . hh:mm a"))
                                        .font(Font.camelfonts.Reg14)
                                    
                                }
                            }
                            Spacer()
                            VStack {
                                Button(action: {
                                    longitude = Double(detailsVM.publishedUserLogedInModel.fromLang ?? 0)
                                latitude = Double(detailsVM.publishedUserLogedInModel.fromLat ?? 0)
                                    ShowMapRedirector = true

                                }) {
                                    ZStack{
                                        Color(#colorLiteral(red: 0.809019506, green: 0.7819704413, blue: 0.8611868024, alpha: 1)).frame(width : 100 , height: 40)
                                        Text("Location").foregroundColor(Color(#colorLiteral(red: 0.2833708227, green: 0.149017632, blue: 0.4966977239, alpha: 1)))
                                            .font(Font.camelfonts.Reg16)
                                        
                                    }.cornerRadius(8)
                                }
                                Spacer()
                                Button(action: {
                                    longitude = Double(detailsVM.publishedUserLogedInModel.toLang ?? 0)
                                latitude = Double(detailsVM.publishedUserLogedInModel.toLat ?? 0)
                                    ShowMapRedirector = true

                                }) {
                                    ZStack{
                                        Color("Second_Color").opacity(0.2).frame(width : 100 , height: 40)
                                        Text("Location").foregroundColor(Color("Second_Color"))
                                            .font(Font.camelfonts.Reg16)
                                        
                                    }.cornerRadius(8)
                                }
                            }
                        }
                        Spacer()
                        Text("")
                    }.padding()
                }
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
                //                HStack {
                //                    Text("Shipment details")
                //                    .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                //                    Spacer()
                //                }
                //                .frame(height: 40)
                //                .padding(.leading , 20.0)
                //                VStack{
                //                    HStack(spacing: 10){
                //                        Image("ic_blue_box")
                //                        HStack{
                //                            Text("6").foregroundColor(Color.black)
                //                            Text("Tons  .").foregroundColor(Color.gray)
                //                            Text("Cleaning Materials").foregroundColor(Color.gray)
                //                        }
                //                        .font(Font.camelfonts.Med14)
                //
                //                        Spacer()
                //                    }.padding()
                //                    HStack(spacing: 10){
                //                        Image("ic_blue_truck")
                //                        HStack{
                //                            Text("4").foregroundColor(Color.black)
                //                            Text("m").foregroundColor(Color.gray)
                //                            Text("Open jumpo truck").foregroundColor(Color.gray)
                //                        }
                //                        .font(Font.camelfonts.Med14)
                //                        Spacer()
                //                    }.padding()
                //                }.padding()
                //                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                //                    .frame(height: 1)
                //
             
                ZStack{
                    Button(action: {
                        if  detailsVM.publishedUserLogedInModel.driverOfferStatusID == 1 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4 {
                            detailsVM.shipmentOfferId = detailsVM.publishedUserLogedInModel.driverOfferID ?? 0

                            OfferCase = .cancel
                        } else {
//                            detailsVM.shipmentOfferId = detailsVM.publishedUserLogedInModel.driverOfferID ?? 0
                            OfferCase = .set
                        }
                        ShowSetOffer = true

                    }) {
                        ZStack {
                            detailsVM.publishedUserLogedInModel.driverOfferStatusID == 1 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4 ? Color.red.opacity(0.09) : Color("Base_Color")
                            Text( detailsVM.publishedUserLogedInModel.driverOfferStatusID == 1 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4 ? "Cancel".localized(language) : detailsVM.publishedUserLogedInModel.driverOfferStatusID == 2 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 5 ? "ReApply".localized(language):"Apply".localized(language))
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(detailsVM.publishedUserLogedInModel.driverOfferStatusID == 1 || detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4 ? Color.red : Color.white)
                        }
                    }
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.08), radius: 3.0 , x: 0, y: 4)
                    .frame(height : 60)
                    .padding(.horizontal)
                }
                .cornerRadius(10)
                .frame(height : 120)
            }
            TitleBar(Title: "Shipment_Details".localized(language) , navBarHidden: true, leadingButton: .backButton, trailingButton: .shareButton , trailingAction: {
            })
            
            
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)


        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            detailsVM.shipmentId = shipmentId
            detailsVM.GetShipmentDetails()
        })
        .overlay(content: {
            ZStack{
                if ShowSetOffer{
                    BottomSheetView(IsPresented: $ShowSetOffer, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                        if OfferCase == .set{
                            SetOfferView( OfferCase: $OfferCase, ShowSetOffer: $ShowSetOffer)
                            .environmentObject(detailsVM)
                        }else if OfferCase == .applied{
                            AppliedOfferView( OfferCase: $OfferCase, ShowSetOffer: $ShowSetOffer)
                        }else if OfferCase == .cancel{
                            CancelOfferView( OfferCase: $OfferCase, ShowSetOffer: $ShowSetOffer)
                                .environmentObject(detailsVM)

                        }else if OfferCase == .CancelationList{
                            CancelationResonsListView ( OfferCase: $OfferCase)
                                .environmentObject(detailsVM)

                        }else if OfferCase == .canceled{
                            CancelledOfferView( OfferCase: $OfferCase, ShowSetOffer: $ShowSetOffer)
                                .environmentObject(detailsVM)

                            
                        }
                    })
                        .background(
                            Color.clear
                                .disabled(true)
                                .onTapGesture {
                                print("hide keayboard first")
                            }
                        )
                }
            }.background(Color.clear)
               
        })
        
//        .overlay(content: {
//            // showing loading indicator
//            ActivityIndicatorView(isPresented: $detailsVM.isLoading)
//        })
        .overlay(content: {
            AnimatingGif(isPresented: $detailsVM.isLoading)
        })
        .overlay(
            VStack{
                if ShowMapRedirector{
                    BottomSheetView(IsPresented: $ShowMapRedirector, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                        RedirectToGMaps(ShowRedirector: $ShowMapRedirector, Long: longitude, Lat: latitude)
                            .padding()
                            .frame( height: 190)
                    })
                }
                Spacer(minLength: 40)
            }.padding(.bottom)
        )
    // Alert with no internet connection
        .alert(isPresented: $detailsVM.isAlert, content: {
            Alert(title: Text(detailsVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                if detailsVM.activeAlert == .unauthorized{
                    Helper.logout()
                    LoginManger.removeUser()
//                    destination = AnyView(SignInView())
//                    active = true
                }

                detailsVM.isAlert = false
            }))
        })
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(shipmentId: 0)
    }
}


enum OfferCases{
    case set, applied, cancel, CancelationList, canceled, none
}
struct SetOfferView:View{
    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    @Binding var OfferCase:OfferCases
    @Binding var ShowSetOffer:Bool
    
    var body: some View{
        VStack{
            Spacer()
            Text("Set_Offer".localized(language))
                .font(Font.camelfonts.SemiBold22)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        OfferCase = .none
                        ShowSetOffer.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            
            
            InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "Offer".localized(language), text: $detailsVM.driverOffer)
                .keyboardType(.numberPad)
                .overlay(content: {
                    HStack{
                        Spacer()
                        Text("SAR".localized(language))
                            .font(Font.camelfonts.Reg16)
                            .foregroundColor(.secondary)
                    }
                })
                .padding(.horizontal)
                .padding(.top,20)
            
            
            HStack{
                Text("Lowest_Osser_is".localized(language))
                    .font(Font.camelfonts.Reg16)
                    .foregroundColor(.secondary)
                Text("\(detailsVM.publishedUserLogedInModel.lowestOffer ?? 1200) SAR")
                    .font(Font.camelfonts.SemiBold16)
                    .foregroundColor(Color("blueColor"))
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            
            Button(action: {
                detailsVM.SendOffer()
            }, label: {
                HStack {
                    Text("Send_Offer".localized(language))
                        .font(Font.camelfonts.Bold18)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
            })
            
                .frame( height: 60)
                .padding(.horizontal)
                .padding(.top,10)
                .padding(.vertical,10)
        }
                .frame(height:260)
                .onChange(of: detailsVM.OfferSent, perform: {newval in
                    self.OfferCase = .applied
                })
                
    }
}

struct SetOfferView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SetOfferView(OfferCase: .constant(.set), ShowSetOffer: .constant(true))
                .environmentObject(ShipmentDetailsViewModel())
        }
    }
}

struct AppliedOfferView:View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    @Binding var OfferCase:OfferCases
    @Binding var ShowSetOffer:Bool
    
    var body: some View{
        VStack{
            
            Text("Offer_Applied".localized(language))
                .font(Font.camelfonts.SemiBold22)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        OfferCase = .none
                        ShowSetOffer.toggle()
                        detailsVM.GetShipmentDetails()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )

            Image("success-orange")
                .padding()

            Text("You_have_applied_for_this_shipment_\nsuccessfully".localized(language))
                .multilineTextAlignment(.center)
                .font(Font.camelfonts.Reg16)
                .foregroundColor(.black.opacity(0.8))

            Button(action: {
                DispatchQueue.main.async{
                    OfferCase = .set
                    ShowSetOffer = false
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                HStack {
                    Text("Check_other_shipments".localized(language))
                        .font(Font.camelfonts.SemiBold22)
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
                .padding(.top,40)
        }
        .frame(maxHeight:(UIScreen.main.bounds.height/2)-90)
    }
}

struct AppliedOfferView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppliedOfferView(OfferCase: .constant(.set), ShowSetOffer: .constant(true))
                .environmentObject(ShipmentDetailsViewModel())
        }
    }
}

struct CancelOfferView:View{
    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    @Binding var OfferCase:OfferCases
    @Binding var ShowSetOffer:Bool
    
    var body: some View{
        VStack{
            Spacer()
            Text("Cancel_Offer?".localized(language))
                .font(Font.camelfonts.SemiBold22)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        OfferCase = .none
                        ShowSetOffer.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding(.horizontal)
                )
            
            
            VStack{
                Image("HandOnCancel")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                Text("You_will_loose_the_opportunity_to_gain")
                    .font(Font.camelfonts.Reg14)
                    .multilineTextAlignment(.center)
                Text("\(detailsVM.publishedUserLogedInModel.driverOfferValue ?? 1400) SAR")
                    .foregroundColor(.red)

            }.padding()
            
            
            HStack(alignment : .top){
                Spacer()
                Image("ic_lump")
                Text("To_change_the_offer_you_need_to_cancel_\nthe_order_first_then_to_apply_again")
                    .font(Font.camelfonts.Reg14)
                    //.lineLimit(2)
                    .multilineTextAlignment(.center)
                Spacer()
            }.padding()
            
            if detailsVM.publishedUserLogedInModel.driverOfferStatusID == 4 {
            Button(action: {
                OfferCase = .CancelationList
            }, label: {
                InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "Reason".localized(language), text: $detailsVM.CancelationReasonStr)
                    .disabled(true)
                    .overlay(content: {
                        HStack{
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    })
                    .padding(.horizontal)
                    .padding(.top,20)
            })
            }
            
            Spacer()
            
            Button(action: {
                detailsVM.CancelOffer()
            }, label: {
                HStack {
                    Text("Confirm_cancelation".localized(language))
                        .font(Font.camelfonts.Bold18)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(12)
            })
            
                .frame( height: 60)
                .padding(.horizontal)
                .padding(.top,10)
                .padding(.vertical,10)
        }
        .frame(height:(UIScreen.main.bounds.height/2)+60)
                .onChange(of: detailsVM.OfferCanceled , perform: {newval in
                    self.OfferCase = .canceled
                })

                
    }
}

struct CancelOfferView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CancelOfferView(OfferCase: .constant(.set), ShowSetOffer: .constant(true))
                .environmentObject(ShipmentDetailsViewModel())
        }
    }
}

struct CancelationResonsListView: View {
    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    @StateObject var CancelationReasonsVM = CancelReasonsViewModel()
    @Binding var OfferCase:OfferCases

    var body: some View {
        VStack{
            Text("select_Reason".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        OfferCase = .cancel
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            ScrollView {
                VStack {
              
                    ForEach(CancelationReasonsVM.publishedcanCelationReasonsArray , id:\.self) { button in
                            Button(action: {
                                detailsVM.shipmentOfferId = detailsVM.publishedUserLogedInModel.driverOfferID ?? 0
                                detailsVM.CancelationReasonId = button.id ?? 0
                                detailsVM.CancelationReasonStr = button.title ?? ""
                            }, label: {
                                HStack{
                                    Image(systemName:  detailsVM.CancelationReasonId == button.id ? "checkmark.circle.fill" :"circle")
                                        .font(.system(size: 20))
                                        .foregroundColor( detailsVM.CancelationReasonId == button.id ? Color("blueColor") : .gray.opacity(0.5) )
                                    Text(button.title ?? "")
                                        .padding()
                                        .foregroundColor(detailsVM.CancelationReasonId == button.id ? Color("blueColor") : .gray.opacity(0.5))
                                    Spacer()
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            }).padding(.leading)
//                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                }
            }
            
            Button(action: {
                OfferCase = .cancel
            }, label: {
                HStack {
                    Text("Confirm".localized(language))
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
                .padding(.horizontal, 12)
            })
                .frame( height: 60)
                .padding(.horizontal)
                .padding(.bottom,10)
        }
        .frame(height:(UIScreen.main.bounds.height/2)+90)
        .onAppear(perform: {
            CancelationReasonsVM.GetCancelationReasons()
        })
    }
}

struct CancelationResonsListView_Previews: PreviewProvider {
    static var previews: some View {
        CancelationResonsListView( OfferCase: .constant(.cancel))
            .environmentObject(ShipmentDetailsViewModel())
    }
}

struct CancelledOfferView:View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    @Binding var OfferCase:OfferCases
    @Binding var ShowSetOffer:Bool
    
    var body: some View{
        VStack{
            
            Text("Canceled".localized(language))
                .font(Font.camelfonts.SemiBold22)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        OfferCase = .none
                        ShowSetOffer.toggle()
                        detailsVM.GetShipmentDetails()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )

            Image("CancelledX")
                .padding()

            Text("You_still_can_re-apply_for_this_job".localized(language))
                .multilineTextAlignment(.center)
                .font(Font.camelfonts.Reg16)
                .foregroundColor(.black.opacity(0.8))

            HStack{
                Button(action: {
                    DispatchQueue.main.async{
                        OfferCase = .set
                        ShowSetOffer = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    HStack {
                        Text("other_shipments".localized(language))
                            .font(Font.camelfonts.Reg16)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height:22)
                    .padding()
                    .foregroundColor(Color("blueColor"))
                    .background(
                        Color.red.opacity(0.2)
                    )
                    .cornerRadius(12)
                    .padding(.bottom)
                })
            Button(action: {
                DispatchQueue.main.async{
                    detailsVM.driverOffer = "\( detailsVM.publishedUserLogedInModel.driverOfferValue ?? 00)"
                    OfferCase = .none
                    ShowSetOffer = false
                }
            }, label: {
                HStack {
                    Text("Re-Apply".localized(language))
                        .font(Font.camelfonts.Reg16)
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
//                .padding(.horizontal, 20)
                .padding(.bottom)
            })
        }
            .padding(.horizontal ,20)
                .padding(.top,40)
        }
        .frame(maxHeight:(UIScreen.main.bounds.height/2)-90)
    }
}

struct CancelledOfferView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CancelledOfferView(OfferCase: .constant(.set), ShowSetOffer: .constant(true))
                .environmentObject(ShipmentDetailsViewModel())
        }
    }
}

