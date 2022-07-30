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
        VStack {
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
                                    Text("Giza").foregroundColor(Color("Base_Color"))
                                    HStack{
                                        Text("22/05/2022")
                                        Text(".  1:30 AM")
                                    }
                                    .font(Font.camelfonts.Reg14)

                                }
                                VStack(alignment: .leading){
                                    Text("Alexandria").foregroundColor(Color("Second_Color"))
                                    HStack{
                                        Text("23/05/2022")
                                        Text(".  4:30 PM")
                                    }
                                    .font(Font.camelfonts.Reg14)

                                }
                            }
                            Spacer()
                            VStack {
                                Button(action: {}) {
                                    ZStack{
                                        Color(#colorLiteral(red: 0.809019506, green: 0.7819704413, blue: 0.8611868024, alpha: 1)).frame(width : 100 , height: 40)
                                        Text("Location").foregroundColor(Color(#colorLiteral(red: 0.2833708227, green: 0.149017632, blue: 0.4966977239, alpha: 1)))
                                            .font(Font.camelfonts.Reg16)

                                    }.cornerRadius(8)
                                }
                                Spacer()
                                Button(action: {}) {
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
                HStack {
                    Text("Shipment details")
                    .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                    Spacer()
                }
                .frame(height: 40)
                .padding(.leading , 20.0)
                VStack{
                    HStack(spacing: 10){
                        Image("ic_blue_box")
                        HStack{
                            Text("6").foregroundColor(Color.black)
                            Text("Tons  .").foregroundColor(Color.gray)
                            Text("Cleaning Materials").foregroundColor(Color.gray)
                        }
                        .font(Font.camelfonts.Med14)

                        Spacer()
                    }.padding()
                    HStack(spacing: 10){
                        Image("ic_blue_truck")
                        HStack{
                            Text("4").foregroundColor(Color.black)
                            Text("m").foregroundColor(Color.gray)
                            Text("Open jumpo truck").foregroundColor(Color.gray)
                        }
                        .font(Font.camelfonts.Med14)
                        Spacer()
                    }.padding()
                }.padding()
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
                HStack {
                    Text("Description")
                    .font(Font.camelfonts.Bold14).foregroundColor(Color.gray)
                    Spacer()
                }
                .frame(height: 40)
                .padding(.leading , 20.0)
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
                Text("I want to deliver these Pepsi boxes from Giza to Alexandria as soon as possible and would love to have  a nice decent driver with a good looking truck ").font(Font.camelfonts.Reg16).padding()
                ZStack{
                    Button(action: {}) {
                        ZStack {
                            Color("Base_Color")
                            Text("Apply")
                                .font(Font.camelfonts.Reg16)
                                .foregroundColor(Color.white)
                        }
                    }
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.08), radius: 3.0 , x: 0, y: 4)
                    .frame(height : 60)
                    .padding(.horizontal, 40.0)
                }
                .cornerRadius(10)
                .frame(height : 120)
            }
            TitleBar(Title: "Shipment Details" , navBarHidden: true, leadingButton: .backButton, trailingButton: .shareButton , trailingAction: {})
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
