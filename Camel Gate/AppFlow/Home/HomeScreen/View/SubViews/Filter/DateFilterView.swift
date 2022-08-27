//
//  DateFilterView.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI
struct DateFromTo:View{
    var language = LocalizationService.shared.language
    @EnvironmentObject var ShipmentVM : ApprovedShipmentViewModel
    
    @Binding var FilterTag:FilterCases
    @State var ShowCalendar = false
    var body: some View{
        VStack{
            Spacer()
            Text("Date_(from-to)".localized(language))
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
                    InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "From".localized(language), text: $ShipmentVM.fromDateStr)
//                        .disabled(true)
                        .overlay(content: {
                            HStack{
                                DatePicker("", selection: $ShipmentVM.fromDate, displayedComponents: [.date])
                                    .opacity(0.04)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }                        .padding(.horizontal)

                        })
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    InputTextField(iconName: "",iconColor: Color("OrangColor"), placeholder: "To".localized(language), text:$ShipmentVM.toDateStr)
                        .overlay(content: {
                            HStack{
                                DatePicker("", selection: $ShipmentVM.toDate, displayedComponents: [.date])
                                    .opacity(0.04)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal)

                        })
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                }).buttonStyle(.plain)


            }

            
            Button(action: {
                FilterTag = .Menu
            }, label: {
                HStack {
                    Text("Done".localized(language))
.font( language.rawValue == "ar" ? Font.camelfonts.BoldAr18:Font.camelfonts.Bold18)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
            })
                .frame( height: 60)
                .padding(.bottom,10)
        }
        .onChange(of: ShipmentVM.fromDate, perform: {newval in
            ShipmentVM.fromDateStr = newval.DateToStr(format: "dd-MM-yyyy")
        })
        .onChange(of: ShipmentVM.toDate, perform: {newval in
            ShipmentVM.toDateStr = newval.DateToStr(format: "dd-MM-yyyy")
        })
        .frame(height:180)
//        .overlay(content: {
            calendarPopUp(selectedDate: $ShipmentVM.fromDate, isPresented: $ShowCalendar)
//            ZStack{
//                if ShowCalendar == true{
                   
//                }
//            }
//        })
    }
}

struct DateFromTo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DateFromTo(FilterTag: .constant(.CityFrom))
                .environmentObject(ApprovedShipmentViewModel())
        }
    }
}
