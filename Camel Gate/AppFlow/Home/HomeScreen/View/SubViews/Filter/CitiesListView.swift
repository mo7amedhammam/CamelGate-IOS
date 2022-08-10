//
//  CitiesListView.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI

struct LocationFilter: View {
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    @StateObject var CitiesVM = CityViewModel()
    @Binding var FilterTag:FilterCases
    
    var body: some View {
        VStack{
            Text(FilterTag == .CityFrom ? "From_(Choose City)".localized(language):"To(Choose City)".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        FilterTag = .City
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
                        if FilterTag == .CityFrom{
                        self.ShipmentVM.fromCityId =  0
                        self.ShipmentVM.fromCityName =  ""
                        }else if FilterTag == .CityTo {
                            self.ShipmentVM.toCityId =  0
                            self.ShipmentVM.toCityName =  ""
                        }
                    }, label: {
                        HStack{
                            Image(systemName: FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == 0 ? "checkmark.circle.fill" :"circle"):FilterTag == .CityTo ? (self.ShipmentVM.toCityId == 0 ? "checkmark.circle.fill" :"circle"):"circle")
                                .font(.system(size: 20))
                                .foregroundColor(FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == 0 ? Color("blueColor") : .gray.opacity(0.5)):FilterTag == .CityTo ? (self.ShipmentVM.toCityId == 0 ? Color("blueColor") : .gray.opacity(0.5)) : .gray.opacity(0.5) )
                            Text("Any".localized(language))
                                .padding()
                                .foregroundColor(FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == 0 ? Color("blueColor") : .gray.opacity(0.5)) : FilterTag == .CityTo ? (self.ShipmentVM.toCityId == 0 ? Color("blueColor") : .gray.opacity(0.5)):.gray.opacity(0.5))
                            Spacer()
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    })
                        .padding(.leading)
                    
                    ForEach(CitiesVM.publishedCitiesArray , id:\.self) { button in
//                        HStack {
//                            Spacer().frame(width:20)
                            Button(action: {
                                if FilterTag == .CityFrom{
                                self.ShipmentVM.fromCityId = button.id ?? 0
                                self.ShipmentVM.fromCityName = button.title ?? ""
                                }else if FilterTag == .CityTo {
                                    self.ShipmentVM.toCityId = button.id ?? 0
                                    self.ShipmentVM.toCityName = button.title ?? ""
                                }
                            }, label: {
                                HStack{
                                    Image(systemName: FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == button.id ? "checkmark.circle.fill" :"circle"):FilterTag == .CityTo ? (self.ShipmentVM.toCityId == button.id ? "checkmark.circle.fill" :"circle"):"circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == button.id ? Color("blueColor") : .gray.opacity(0.5)):FilterTag == .CityTo ? (self.ShipmentVM.toCityId == button.id ? Color("blueColor") : .gray.opacity(0.5)) : .gray.opacity(0.5) )
                                    Text(button.title ?? "")
                                        .padding()
                                        .foregroundColor(FilterTag == .CityFrom ? (self.ShipmentVM.fromCityId == button.id ? Color("blueColor") : .gray.opacity(0.5)) : FilterTag == .CityTo ? (self.ShipmentVM.toCityId == button.id ? Color("blueColor") : .gray.opacity(0.5)):.gray.opacity(0.5))
                                    Spacer()
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            }).padding(.leading)
//                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                }
            }
            
            Button(action: {
                // add review
                print("Confirm Title")
                FilterTag = .City
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
            CitiesVM.GovernorateId = 1
            CitiesVM.GetCiities()
        })
    }
}

struct LocationFilter_Previews: PreviewProvider {
    static var previews: some View {
        LocationFilter( FilterTag: .constant(.City))
            .environmentObject(ApprovedShipmentViewModel())
    }
}

