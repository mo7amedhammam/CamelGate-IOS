//
//  DetailsView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/29/22.
//

import SwiftUI

struct DetailsView: View {
    @State var goToShipmentDetails:Bool = false
    var body: some View {
      ZStack {
        ScrollView {
          VStack {
            Button(action: {}) {
              ZStack{
                Image("cover_vector").resizable().frame(height: 120)
              }.padding(.top , 60)
            }
            VStack{
              ZStack{
                Color(#colorLiteral(red: 0.2969967723, green: 0.8283568025, blue: 0, alpha: 1))
                Text("Applied").fontWeight(.medium).foregroundColor(Color
                  .white)
              }.frame(height: 30)
              ZStack{
                Color(#colorLiteral(red: 0.2969967723, green: 0.8283568025, blue: 0, alpha: 0.2))
                HStack {
                  Text("1,200").fontWeight(.medium).foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
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
            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
            ZStack{
                HStack(alignment : .top , spacing : 20){
                VStack{
                    Text("Lowest Offer").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                    HStack{
                        Image("ic_green_dollar")
                        Text("1,200 SAR")
                            .font(Font.camelfonts.Med16).foregroundColor(Color(#colorLiteral(red: 0.2314580083, green: 0.6560779214, blue: 0, alpha: 1)))
                    }
                }
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(width: 1)
                  VStack{
                      Text("Driver's Rate").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                      HStack{
                          Image("ic_orange_star")
                          Text("3.5/5 Stars")
                              .font(Font.camelfonts.Med16).foregroundColor(Color(#colorLiteral(red: 1, green: 0.5745426416, blue: 0, alpha: 1)))
                      }
                  }
                  Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(width: 1)
                  VStack{
                      Text("Total Offers").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                      Spacer()
                      HStack{
                          Text("240 Offer")
                              .font(Font.camelfonts.Med16).foregroundColor(Color.black)
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
                              Text("D232eR395964")
                                  .font(Font.camelfonts.Med16).foregroundColor(Color.black)
                          }
                      }
                      Spacer()
                      VStack{
                          Text("Total Distance").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                          HStack{
                              Image("ic_orange_pin")
                              Text("240 KM")
                                  .font(Font.camelfonts.Med16).foregroundColor(Color.black)
                          }
                      }
                  }
                  Spacer()
                  VStack {
                      VStack{
                          Text("Company Rate").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                          HStack{
                              Image("ic_orange_star")
                              Text("4.5/5")
                                  .font(Font.camelfonts.Med16).foregroundColor(Color.black)
                              Text("(240 Rates)")
                                  .font(Font.camelfonts.Reg14).foregroundColor(Color.black)
                          }
                      }
                      Spacer()
                      VStack{
                          Text("Estimated Time").font(Font.camelfonts.Reg14).foregroundColor(Color.gray)
                          HStack{
                              Image("ic_orange_star")
                              Text("1 - 2 Days")
                                  .font(Font.camelfonts.Med16).foregroundColor(Color.black)
                          }
                      }
                  }
              }
              .frame(height: 160)
              .padding()
              Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
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
        }
        TitleBar(Title: "Shipment Details" , navBarHidden: true, leadingButton: .backButton, trailingButton: .shareButton , trailingAction: {})
      }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
