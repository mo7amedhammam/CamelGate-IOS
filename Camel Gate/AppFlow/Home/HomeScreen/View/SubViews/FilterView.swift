//
//  FilterView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct FilterView: View {
    var delete : Bool
    let filterTitle : String
    var D : (()->())?
    var body: some View {
        if (delete) {
            ZStack{
                Color(#colorLiteral(red: 0.9521436095, green: 0.9569442868, blue: 0.9612503648, alpha: 1))
                HStack{
                    Text(filterTitle).foregroundColor(Color.gray)
                    Spacer()
                    Button(action: {
                        D?()
                    }) {
                        Image("ic_x")
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }.padding()
            }
            .frame(height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1))
            .cornerRadius(20)
        }
    }
}



enum FilterCases{
    case Menu, City, Date, ShipmentTypes
}
struct MainDoctorFilterView: View {
    @EnvironmentObject var shipmentVm : ApprovedShipmentViewModel
//    @EnvironmentObject var seniorityVM : ViewModelSeniority
//    @EnvironmentObject var specialityvm : ViewModelSpecialist
//    @EnvironmentObject var SubSpecialityVM : ViewModelSubspeciality
//    @EnvironmentObject var CitiesVM : ViewModelGetCities
//    @EnvironmentObject var AreasVM : ViewModelGetAreas
//    @EnvironmentObject var FeesVM : ViewModelFees
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool
    
    var body: some View {
        
        BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, forgroundColor: .white, content: {
       
//            switch FilterTag{
//            case .Menu:
//                FilterMenu(FilterTag: $FilterTag, showFilter: $showFilter)
////                    .environmentObject(shipmentVm)
////                    .environmentObject(FeesVM)
//
//            case .City:
//                print("City")
////                SpecialityFilterList( FilterTag: $FilterTag)
////                    .environmentObject(specialityvm)
////                    .environmentObject(searchDoc)
//
//            case .Date:
//                print("date")
////                TitleFilterList(FilterTag: $FilterTag)
////                    .environmentObject(seniorityVM)
//
//            case .ShipmentTypes:
//                print("type")
////                SubSpecialityFilterList( FilterTag: $FilterTag)
////                    .environmentObject(SubSpecialityVM)
////                    .environmentObject(searchDoc)
//
//            }
        })
    }
}



struct FilterMenu:View{
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool
    
    var body: some View{
        VStack{
            Text("Filter_Shipments".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        showFilter.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            
            ScrollView(){
                VStack{
                Button(action: {
                    print("sel location")
                    FilterTag = .City
                    ShipmentVM.fromCityId = 11
                    ShipmentVM.toCityId = 13
                    ShipmentVM.lat = 29.2
                    ShipmentVM.lang = 29.2

                }, label: {
                    HStack{

                        VStack(alignment:.leading){
                            Text("Location(From-To)".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            Text(ShipmentVM.fromCityName == "" ? "all".localized(language):"\(ShipmentVM.fromCityName)-\(ShipmentVM.toCityName)" )
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }

                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                })
                    .listRowSeparator(.hidden)
                Button(action: {
                    print("sel date")
                    FilterTag = .Date
                }, label: {
                    HStack{

                        VStack(alignment:.leading){
                            Text("Date(From-To)".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(ShipmentVM.fromDate == nil ? "all".localized(language):"\(ShipmentVM.fromDate ?? Date()) - \(ShipmentVM.toDate ?? Date())")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }

                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                })
                Button(action: {
                    print("sel types")
                    FilterTag = .ShipmentTypes
                }, label: {
                    HStack{
                        VStack(alignment:.leading){
                            Text("Shipment_type".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(ShipmentVM.shipmentTypesNames == [] ? "All_Types".localized(language): ShipmentVM.shipmentTypesNames.joined(separator:", "))
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }

                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                })
            }
            }
            .listStyle(.plain)
            
            HStack{
                
                Button( action: {
                    
                    resetFilter()
                    showFilter.toggle()
                }, label: {
                    Text("Reset".localized(language))
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.5))
                    
                })
                
                    .padding(.leading)
                Button(action: {
                    // add review
                    print("Apply Filter and Hide")
                    
                    applyFilter()
                    showFilter.toggle()
                }, label: {
                    HStack {
                        Text("Apply_Filter".localized(language))
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("blueColor"))
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
                })
            }
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            .frame( height: 60)
            .padding(.horizontal)
            .padding(.bottom,10)
        }
        .frame(height:(UIScreen.main.bounds.height/2)-90)
        .onChange(of: ShipmentVM.fromCityId, perform: {newval in
            ShipmentVM.fromCityId = newval
            ShipmentVM.GetFilteredShipments()
        })

    }
    //MARK: --- Functions ----
//    func getAllDoctors(){
//        searchDoc.DoctorName = searchTxt
//        searchDoc.SkipCount = 0
//        searchDoc.publishedModelSearchDoc?.removeAll()
//        searchDoc.FetchDoctors(operation: .fetchDoctors)
//    }
    
    func applyFilter(){
//        searchDoc.FilterFees = Float(searchDoc.FilterFees > 0 ? Int(searchDoc.FilterFees):0)
//        searchDoc.publishedModelSearchDoc?.removeAll()
//        getAllDoctors()
    }
    
    func resetFilter(){
        ShipmentVM.fromCityId = 0
        ShipmentVM.toCityId = 0

//        getAllDoctors()
    }
    
}

struct FilterMenu_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FilterMenu(FilterTag: .constant(.Menu), showFilter: .constant(true))
                .environmentObject(ApprovedShipmentViewModel())
//                .environmentObject(ViewModelFees())
        }
    }
}
