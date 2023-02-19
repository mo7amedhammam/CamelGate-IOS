//
//  NotificationsView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/31/22.
//

import SwiftUI

struct NotificationsView: View {
    var language = LocalizationService.shared.language

    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height:110)
                List() {
                    
                    //                    if  true{ // if empty
                    //                        Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                    //                            .multilineTextAlignment(.center)
                    //                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                    //                    }
                    ForEach(0 ..< 5) { tripItem in
                        NotificationCell()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        
                    }
                }
                //            .refreshable(action: {
                
                //            })
                .frame(width: UIScreen.main.bounds.width)
                .listStyle(.plain)
                .padding(.vertical,0)
                
            }.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
            TitleBar(Title: "Notifications" , navBarHidden: true, leadingButton: .backButton , trailingAction: {})
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

struct NotificationCell : View {
    var body: some View {
        ZStack{
            HStack{
                Image("ic_green_truck")
                VStack(alignment : .leading){
                    Text("12:30 AM")
                    .font( Font.camelfonts.Reg14)

                        .foregroundColor(Color.gray)
                    Text("You have finished a shipment!")
                        .font(Font.camelfonts.SemiBold14)
                    Text("You just finished a shipment and gained 1,200 SAR to your balance.")
                        .font(Font.camelfonts.Reg11)
                        .foregroundColor(Color.gray)
                }
            }.padding(.vertical, 10.0)
        }
    }
}
