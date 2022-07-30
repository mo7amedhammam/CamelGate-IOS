//
//  OnBoardingView.swift
//  Camel Gate
//
//  Created by wecancity on 26/07/2022.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var currentIndex = 0
    @State private var HeadLineTitle = "Apply Easily On Shipments!"
    @State private var bodyTitle = "You can easily Apply on more than 3,500 shipments and set your own offer"
    
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
                        Text(HeadLineTitle)
                            .transition(.slide)
                            .animation(.rippleText())
                            .font(Font.camelfonts.Bold22)
                            .multilineTextAlignment(.center)
                        Text(bodyTitle)
                            .transition(.slide)
                            .animation(.rippleText())
                            .font(Font.camelfonts.Med16)
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
                                HeadLineTitle = "Track your Shipment!"
                                bodyTitle = "You can easily track your shipment since you start it till you drop the backage"
                            case 1 :
                                self.currentIndex = 2
                                HeadLineTitle = "Check your Balance!"
                                bodyTitle = "You can easily check your balance along time and transitions made in/out"
                            case 2 :
                                    Helper.onBoardOpened()
                                let window = UIApplication
                                    .shared
                                    .connectedScenes
                                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                                    .first { $0.isKeyWindow }
                                window?.rootViewController = UIHostingController(rootView: TabBarView())
                                window?.makeKeyAndVisible()
                            default :
                                print("")
                            }
                        }) {
//                            ZStack {
//                                Image("ic_back_button")
////                                    .resizable()
//                                    .scaledToFill()

                                HStack{
                                    Text(currentIndex == 2 ? "Geting Started" : "Next").font(Font.camelfonts.Med16)
                                        .foregroundColor(Color.white)
                                    Image("ic_next_arrow")
                                }
                                .frame(height: 50)
                                .padding(.horizontal, 80)
//                            }
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                    startPoint: .trailing,
                                    endPoint: .leading
                                ))                                .cornerRadius(radius: 8)

                        }
                    }.padding()
                }.frame(maxWidth: .infinity, maxHeight: 340)
                    .background(Color.clear)
            }.edgesIgnoringSafeArea(.all)
        }.ignoresSafeArea()
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
        OnBoardingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))

    }
}
