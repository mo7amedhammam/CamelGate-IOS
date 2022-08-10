//
//  CityFilterView.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI

struct CityFromTo:View{
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    @Binding var FilterTag:FilterCases
    
    var body: some View{
        VStack{
            Spacer()
            Text("Location_(from-to)".localized(language))
                .font(Font.camelfonts.Bold20)
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
            
            HStack{
                Button(action: {
                    FilterTag = .CityFrom
                }, label: {
                    InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "From".localized(language), text: $ShipmentVM.fromCityName)
                        .disabled(true)
                        .overlay(content: {
                            HStack{
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        })
                        .padding(.horizontal)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                })
                
                Button(action: {
                    FilterTag = .CityTo
                }, label: {
                    InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "To".localized(language), text: $ShipmentVM.toCityName)
                        .disabled(true)
                        .overlay(content: {
                            HStack{
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        })
                        .padding(.horizontal)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                })
            }
            
            Button(action: {
                
                //                    applyFilter()
                //                    showFilter.toggle()
                FilterTag = .Menu
            }, label: {
                HStack {
                    Text("Done".localized(language))
                        .font(Font.camelfonts.Bold18)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
                .padding(.horizontal, 30)
            })
            
                .frame( height: 60)
                .padding(.horizontal)
                .padding(.bottom,10)
        }
        .frame(height:180)
    }
}

struct CityFromTo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CityFromTo(FilterTag: .constant(.CityFrom))
                .environmentObject(ApprovedShipmentViewModel())
        }
    }
}
