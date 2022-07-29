//
//  TitleBar.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct TitleBar: View {
    @State var Title: String?
    @State var navBarHidden: Bool?
    @State var leadingButton: TopButtons? = TopButtons.none
    @State var trailingButton: TopButtons? = TopButtons.none
    @State var applyStatus: ApplyStatus? = ApplyStatus.none
    @State var IsSubTextRate: Bool? = false

    @State var subText: String?
    var trailingAction : () -> Void
    var body: some View {
        VStack {
            ZStack{
                Image("TopBarImage")
                    .resizable()
                    .frame(height: 160)
                    .padding(.leading,-2)
                
                VStack {
                    HStack(){
                        if leadingButton == .backButton{
                            BackButtonView()
                                .frame(width: 60)
                        }else{
                            Spacer().frame(width: 60)
                        }
                        Spacer()
                        Text(Title ?? "")
                            .font(Font.camelfonts.Med22)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        if trailingButton == .filterButton{
                            FilterButtonView(action: trailingAction)
                                .frame(width: 60)
                        }else if trailingButton == .shareButton {
                            ShareButtonView(action: trailingAction)
                                .frame(width: 60)
                            
                        }else if trailingButton == .editButton {
                            EditButtonView(action: trailingAction)
                                .frame(width: 60)
                            
                        }else{
                            Spacer().frame(width: 60)
                        }
                    }
//                    .padding(.horizontal)
                    .frame(height: 80)
                    
                    HStack {
                        if IsSubTextRate == true {
                            Image(systemName: "star.fill")
                                .font(.system(size:15))
                                .foregroundColor(.orange)
                        }
                        
                        Text(subText ?? "")
                            .font(Font.camelfonts.Reg16)
                    }
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(applyStatus == .applyed ? .green:  subText == nil ? .clear:.white.opacity(0.35))
                            .cornerRadius(8)
                        .padding(.top,-20)
                    
                    
                }
                .padding(.top,hasNotch ? -10:-20)
            }

            Spacer()
        }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(navBarHidden ?? false)
    }
}


struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TitleBar(Title: "Shipments",leadingButton: .backButton, subText: "50", trailingAction: {})
        }
        ZStack {
            TitleBar(Title: "Shipments",leadingButton: .backButton, subText: "50", trailingAction: {})
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

enum TopButtons{
    case backButton, filterButton, shareButton, editButton, none
}
enum ApplyStatus{
    case applyed, none
}
