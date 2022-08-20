//
//  NoteScreenView.swift
//  Camel Gate
//
//  Created by wecancity on 26/07/2022.
//

import SwiftUI

struct NoteScreenView: View {
    var language = LocalizationService.shared.language

    @State var gotoPhoneVerification = false
    var body: some View {
        ZStack{
            VStack{
                Image("lock-orange")
                Text("We_have_to_confirm_your\n_identity_by_sending_a_code_to_\nyour_phone_number".localized(language))
                    .font(Font.camelfonts.Reg18)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                HStack{
                    Text("Code_will_be_sent_to".localized(language))
                    Text("+699 128 665 1628")
                        .foregroundColor(Color("Second_Color"))
                }
                .font(Font.camelfonts.Reg14)
                .multilineTextAlignment(.center)

                
                Button(action: {
                    DispatchQueue.main.async{
                        gotoPhoneVerification = true
                    }
                }, label: {
                    HStack {
                        Text("Send_Code".localized(language))
                            .font(Font.camelfonts.Reg14)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height:22)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                            startPoint: .trailing,
                            endPoint: .leading
                        ))
                    .cornerRadius(12)
                    .padding(.horizontal, 80)
                }).padding(.top,50)
            }
            
            TitleBar(Title: "Change_Password", navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        NavigationLink(destination: PhoneVerificationView<OTPViewModel>(),isActive:$gotoPhoneVerification , label: {
        })
    }
}

struct NoteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NoteScreenView()
    }
}
