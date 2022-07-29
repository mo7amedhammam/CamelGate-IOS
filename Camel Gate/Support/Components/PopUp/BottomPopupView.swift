//
//  BottomPopupView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct BottomSheetView <Content: View>: View {
    
    let content: Content
    var language : Language
    var IsPresented: Binding<Bool>
    var withcapsule: Bool
    var bluryBackground: Bool

    init(  IsPresented:Binding<Bool>,withcapsule:Bool,bluryBackground:Bool, @ViewBuilder content: () -> Content) {
        self.language = LocalizationService.shared.language
        self.IsPresented = IsPresented
        self.content = content()
        self.withcapsule = withcapsule
        self.bluryBackground = bluryBackground
    }
    var body: some View {
        ZStack {
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(bluryBackground ?
                    Color.black.opacity(0.2):.clear
        )
        .blur(radius: IsPresented.wrappedValue == true ? bluryBackground ? 5:0:0)
        .transition(.move(edge: .bottom))
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()
    })
        
        .overlay(content: {
            VStack {
                Spacer()
                    .onTapGesture(perform: {
                        IsPresented.wrappedValue.toggle()
                    })

                ZStack {
                    VStack {
                        if withcapsule{
                        Capsule()
                            .frame(width: 50, height: 4)
                            .foregroundColor(.gray)
                            .padding(.top ,10)
                        }
                        VStack {
                            self.content
                                .padding(.vertical)
                        }
                        }.background(
                        RoundedCornersShape(radius: 25, corners: [.topLeft,.topRight])
                            .foregroundColor(.white)
                            .ignoresSafeArea()
                            .opacity(1.5)
                            .shadow(radius: 15)
                            .frame(width: UIScreen.main.bounds.width)
                    )
                }
            }
            .edgesIgnoringSafeArea(.bottom)

        })
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(IsPresented: .constant(true), withcapsule: true, bluryBackground: true, content: {})
    }
}


struct RoundedCornersShape: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}
