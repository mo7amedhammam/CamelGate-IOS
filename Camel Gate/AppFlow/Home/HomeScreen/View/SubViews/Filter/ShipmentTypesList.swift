//
//  ShipmentTypesList.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI

struct ShipTypeFilter: View {
    var language = LocalizationService.shared.language
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    @StateObject var ShipTypesVM = ShipTypeViewModel()
    @Binding var FilterTag:FilterCases
    
    var body: some View {
        VStack{
            Text("Shipment_type".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        FilterTag = .Menu
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
                    Button(action: {
                        ShipmentVM.shipmentTypesIds = []
                        ShipmentVM.shipmentTypesNames = []
                    }, label: {
                        HStack{
                            Image(systemName:ShipmentVM.shipmentTypesIds == [] ? "checkmark.rectangle.fill" :"checkmark.rectangle")
                                .font(.system(size: 20))
                                .foregroundColor(ShipmentVM.shipmentTypesIds == [] ? Color("blueColor") : .gray.opacity(0.5) )
                            Text("Any".localized(language))
                                .padding()
                                .foregroundColor(ShipmentVM.shipmentTypesIds == [] ? Color("blueColor") : .gray.opacity(0.5))
                            Spacer()
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    })
                        .padding(.leading)
                    
                    ForEach(ShipTypesVM.publishedShipTypeArray , id:\.self) { button in
                            Button(action: {
                                if ShipmentVM.shipmentTypesIds == []{
                                    ShipmentVM.shipmentTypesIds.insert(button.id ?? 0, at: 0)
                                    ShipmentVM.shipmentTypesNames.insert(button.title ?? "", at: 0)
                                } else{
                                    
                                    if ShipmentVM.shipmentTypesIds.contains(button.id ?? 0) && ShipmentVM.shipmentTypesNames.contains(button.title ?? "") {
                                        ShipmentVM.shipmentTypesIds.removeAll(where: {$0 == button.id
                                        })
                                        ShipmentVM.shipmentTypesNames.removeAll(where: {$0 == button.title
                                        })
                                    }else{
                                        ShipmentVM.shipmentTypesIds.append(button.id ?? 0)
                                        ShipmentVM.shipmentTypesNames.append(button.title ?? "")
                                    }
                                }                            }, label: {
                                HStack{
                                    Image(systemName:  ShipmentVM.shipmentTypesIds.contains(button.id ?? 0) ? "checkmark.rectangle.fill" : "checkmark.rectangle")
                                        .font(.system(size: 20))
                                        .foregroundColor(ShipmentVM.shipmentTypesIds.contains(button.id ?? 0) ? Color("blueColor") : .gray.opacity(0.5))
                                    Text(button.title ?? "")
                                        .padding()
                                        .foregroundColor(ShipmentVM.shipmentTypesIds.contains(button.id ?? 0) ? Color("blueColor") : .gray.opacity(0.5))
                                    Spacer()
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            }).padding(.leading)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                }
            }
            
            Button(action: {
                // add review
                print("Confirm Title")
                FilterTag = .Menu
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
//                .padding(.horizontal, 12)
            })
                .frame( height: 60)
//                .padding(.horizontal)
                .padding(.bottom,10)
        }
        .frame(height:(UIScreen.main.bounds.height/2))
        .onAppear(perform: {
            ShipTypesVM.GetShipTypes()
        })
    }
}

struct ShipTypeFilter_Previews: PreviewProvider {
    static var previews: some View {
        ShipTypeFilter( FilterTag: .constant(.ShipmentTypes))
            .environmentObject(ApprovedShipmentViewModel())
    }
}

