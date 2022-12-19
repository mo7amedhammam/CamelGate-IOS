//
//  FilterSelectionsView.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI

struct FilterMenu:View{
    var language = LocalizationService.shared.language
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool

    var body: some View{
//        GeometryReader { g in
            VStack{
//                Spacer()
                Text("Filter_Shipments".localized(language))
                    .font(Font.camelfonts.SemiBold18)
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
                                .padding(.horizontal)
                                .padding(.bottom)
                    )
                
                ScrollView(){
                    VStack(spacing:20){
                        Button(action: {
                            print("sel location")
                            FilterTag = .City
                        }, label: {
                            HStack{
                                VStack(alignment:.leading,spacing:5){
                                    Text("Location_(From-To)".localized(language))
                                        .font(Font.camelfonts.Reg18)
                                        .foregroundColor(.black)
                                    
                                    Text(ShipmentVM.fromCityName == "" ? "Any".localized(language):"\(ShipmentVM.fromCityName)-\(ShipmentVM.toCityName)" )
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                                
                            }
                            .padding(.top)
                            .padding(.horizontal,5)
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        })
                            .listRowSeparator(.hidden)

                        Button(action: {
                            FilterTag = .Date
                        }, label: {
                            HStack{
                                VStack(alignment:.leading,spacing:5){
                                    Text("Date_(From-To)".localized(language))
                                        .font(Font.camelfonts.Reg18)
                                        .foregroundColor(.black)
                                    Text(ShipmentVM.fromDateStr == "" ? "Any".localized(language):"\(ShipmentVM.fromDateStr ) - \(ShipmentVM.toDateStr )")
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                            }
                            .padding(.horizontal,5)
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        })

                        Button(action: {
                            FilterTag = .ShipmentTypes
                        }, label: {
                            HStack{
                                VStack(alignment:.leading,spacing:5){
                                    Text("Shipment_types".localized(language))
                                        .font(Font.camelfonts.Reg18)
                                        .foregroundColor(.black)
                                    Text(ShipmentVM.shipmentTypesNames == [] ? "Any".localized(language): ShipmentVM.shipmentTypesNames.joined(separator:", "))
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color.gray.opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                                
                            }
                            .padding(.horizontal,5)
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        })
                    }.padding(.vertical,0)
                }.padding(.vertical,0)
                
                HStack{
                    Button( action: {
                        ShipmentVM.resetFilter()
                        showFilter.toggle()
                    }, label: {
                        Text("Reset".localized(language))
            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                            .foregroundColor(.black.opacity(0.5))
                    })
                        .padding(.horizontal,30)
                    
                    Button(action: {
                        applyFilter()
                        showFilter.toggle()
                    }, label: {
                        HStack {
                            Text("Apply_Filter".localized(language))
        .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr18:Font.camelfonts.Bold18)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("blueColor"))
                        .cornerRadius(12)
                    })
                }
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                .frame( height: 60)
                .padding(.horizontal)
//                .padding(.bottom,10)
            }
//            .frame(height:g.size.height)

            .frame(height:(UIScreen.main.bounds.height/2) - (hasNotch ? 150:50))
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
    
    //MARK: --- Functions ----
    func applyFilter(){
        ShipmentVM.GetFilteredShipments(operation: .fetchshipments)
    }
    
}

struct FilterMenu_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FilterMenu(FilterTag: .constant(.Menu), showFilter: .constant(true))
                .environmentObject(ApprovedShipmentViewModel())
                
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        ZStack {
            FilterMenu(FilterTag: .constant(.Menu), showFilter: .constant(true))
                .environmentObject(ApprovedShipmentViewModel())
        }                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))

    }
}
