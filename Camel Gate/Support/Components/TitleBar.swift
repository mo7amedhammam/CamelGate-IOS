//
//  TitleBar.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct TitleBar: View {
    @State var Title: String?
    @State var SubTitle: String?
    @State var navBarHidden: Bool?
    @State var leadingButton: TopButtons? = TopButtons.none
    @State var trailingButton: TopButtons? = TopButtons.none
    @State var applyStatus: ApplyStatus? = ApplyStatus.none
    @State var subText: String? = "45"
    
    var trailingAction : () -> Void
    
    var body: some View {
        VStack {
            ZStack{
                Image("homeTopMask")
                    .resizable()
                    .frame(height: 150)
                
                VStack {
                    HStack(){
                        if leadingButton == .backButton{
                            BackButtonView()
                        }else{
                            Spacer().frame(width: 60)
                        }
                        Spacer()
                        Text(Title ?? "").font(.title2)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        if trailingButton == .filterButton{
                            FilterButtonView(action: trailingAction)
                            
                        }else if trailingButton == .shareButton {
                            ShareButtonView(action: trailingAction)
                            
                        }else if trailingButton == .editButton {
                            EditButtonView(action: trailingAction)
                            
                        }else{
                            Spacer().frame(width: 60)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 80)
                    
                    Text(subText ?? "")
                        .fontWeight(.regular)
                    //                            .font(.custom("SFUIText", fixedSize: 14))
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        .background(applyStatus == .applyed ? .green:  .white.opacity(0.35))
                        .cornerRadius(8)
                        .padding(.top,-20)
                }
            }
            
            Spacer()
        }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(navBarHidden ?? false)
    }
}


struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar(Title: "Shipments", SubTitle: "current step", trailingAction: {})
    }
}

enum TopButtons{
    case backButton, filterButton, shareButton, editButton, none
}
enum ApplyStatus{
    case applyed, none
}
