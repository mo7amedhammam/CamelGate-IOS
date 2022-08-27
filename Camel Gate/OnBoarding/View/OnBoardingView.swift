//
//  OnBoardingView.swift
//  Camel Gate
//
//  Created by wecancity on 26/07/2022.
//

import SwiftUI

struct OnBoardingView: View {
    var language = LocalizationService.shared.language
    @State private var currentIndex = 0
    @State private var HeadLineTitle = "Apply_Easily_On_Shipments!"
    @State private var bodyTitle = "You_can_easily_Apply_on_more_than_3,500_shipments_and_set_your_own_offer"
    @State var active = false
    @State var destination = AnyView(SignInView())
    var body: some View {
        ZStack{
            Color("Base_Color")
            Image("onoarding_backMask")
                .resizable()
                .ignoresSafeArea()
            
            Image(currentIndex == 0 ? "onboard1":currentIndex == 1 ? "onboard2":"onboard3")
                .padding(.vertical, hasNotch ? 30:70)
                .aspectRatio( contentMode: .fit)
            VStack {
                Spacer()
                ZStack {
                    Image("ic_onBoarding_mask")
                        .resizable()
                    VStack(spacing : 26){
                        Text(HeadLineTitle.localized(language))
                            .transition(.slide)
                            .animation(.rippleText())
                            .font(Font.camelfonts.Bold22)
                            .multilineTextAlignment(.center)
                        Text(bodyTitle.localized(language))
                            .transition(.slide)
                            .animation(.rippleText())
            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("lightGray"))
                        
                        HStack(alignment : .bottom ) {
                            HStack(spacing : 12 ) {
                                ForEach(0 ..< 3 , id : \.self) { index in
                                    let event = index + 1
                                    Capsule()
                                        .fill(currentIndex == index ? Color("Base_Color") : Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)))
                                        .frame(width: currentIndex == index ? 20 : 7 , height: 7)
                                        .transition(.slide)
                                        .animation(.ripple(index: event))
                                }
                            }
                        }
                        
                        Button(action: {
                            switch currentIndex {
                            case 0 :
                                currentIndex = 1
                                HeadLineTitle = "Track_your_Shipment!"
                                bodyTitle = "You_can_easily_track_your_shipment_since_you_start_it_till_you_drop_the_backage"
                            case 1 :
                                self.currentIndex = 2
                                HeadLineTitle = "Check_your_Balance!"
                                bodyTitle = "You_can_easily_check_your_balance_along_time_and_transitions_made_in/out"
                            case 2 :
                                Helper.onBoardOpened()
                                active = true
                                destination = AnyView(SignInView()
                                                        .navigationBarHidden(true)
                                )
                            default :
                                print("")
                            }
                        }) {
                            HStack{
                                Text(currentIndex == 2 ? "Geting_Started".localized(language) : "Next".localized(language)).font(Font.camelfonts.SemiBold16)
                                    .foregroundColor(Color.white)
                                Image("ic_next_arrow")
                            }
                            .frame(height: 50)
                            .padding(.horizontal, 80)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                    startPoint: .trailing,
                                    endPoint: .leading
                                ))
                            .cornerRadius(radius: 8)
                        }
                    }.padding()
                }.frame(maxWidth: .infinity, maxHeight: 340)
                    .background(Color.clear)
            }.edgesIgnoringSafeArea(.all)
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .ignoresSafeArea()
            .navigationBarHidden(true)
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
        OnBoardingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        
    }
}
