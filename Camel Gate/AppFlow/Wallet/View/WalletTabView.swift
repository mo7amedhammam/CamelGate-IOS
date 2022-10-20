//
//  WalletView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI
import SwiftUICharts

struct WalletView: View {
    var language = LocalizationService.shared.language
    @State var WalletCategory = ["Gained","Withdrawn"]
    @State var selected = "Gained"
    var body: some View {
        ZStack{
            VStack{
                Spacer(minLength: hasNotch ? 90:70 )
              ScrollView {
                VStack{
                  ZStack{
                    Color(#colorLiteral(red: 0.943169415, green: 0.9325224757, blue: 0.9590196013, alpha: 1))
                    Image("vector_back_wallet").resizable()
                    VStack{
                      HStack {
                        Text("17,600").fontWeight(.bold).foregroundColor(Color("Base_Color"))
                        Text("SAR").foregroundColor(Color.gray)
                      }
                      Text("Current Balance")
                        .foregroundColor(Color.gray)
                        .padding(.top)
                    }
                  }.frame(height: 180).cornerRadius(12)
                    
                    HStack(spacing: 0.0){
                        ForEach(WalletCategory,id:\.self){ Category in
                            Button(action: {
                                withAnimation{
                                    self.selected = Category
                                }
                            }, label: {
                                HStack(alignment: .center){
                                    Text(Category )
                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                                        .foregroundColor(self.selected == Category ? Color.white : Color("lightGray"))
                                    
                                }
                                .frame(width: 110, height: 45)
                                .clipShape(Rectangle())
                            })
                                .background( Color(self.selected == Category ? "Base_Color" : "lightGray").opacity(self.selected == Category  ? 1 : 0.3)
                                                .cornerRadius(8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth:self.selected == Category ? 1:0))
                            
                        }}
                    .padding(.top, -30.0)
      //            Spacer()
//                          LineChartView(data: [12,20,6,15,30,3], title: "", legend: "Legendary")
//                            LineChartView(data: [12,20,6,15,30,3], title: "", legend: "qwq", style: Styles.barChartMidnightGreenLight , form: CGSize(width: 320, height: 200), rateValue: 4, dropShadow: true, valueSpecifier: "asd")
                  HStack{
                    Button(action: {}) {
                      Image("ic_pervious")
                    }
//                    LineChart(chartData: data).pointMarkers(chartData: point)
                    Button(action: {}) {
                      Image("ic_next")
                    }
                  }
                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
                    HStack {
                        Text("Payment Details")
                        .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                        Spacer()
                    }
                    .frame(height: 40)
                    .padding(.leading , 20.0)
//                    Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
//                        .frame(height: 1)
                    ScrollView(.vertical , showsIndicators : false) {
                        VStack{
                            ForEach(0 ..< 5) { tripItem in
                                WalletViewCell()
                                    .padding(.horizontal)
                            }
                            .onTapGesture {
//                                active = true
//                               destination = AnyView(DetailsView())
                            }
                        }
                    }
                }
              }
            }
            TitleBar(Title: "Wallet", navBarHidden: true, trailingButton: .filterButton ,trailingAction: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WalletView()
        }
    }
}


