//
//  ShipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct ShipmentsView: View {
    @StateObject var shipmentsViewModel = ShipmentsViewModel()
    @State var goToShipmentDetails:Bool = false
    @State var shipmentsCategory = ["Current","Upcoming","Applied"]
    @State var selected = "Applied"
    
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height:145)
                HStack{
                    ForEach(shipmentsCategory,id:\.self){ Category in
                        Button(action: {
                            withAnimation{
                                self.selected = Category
                                shipmentsViewModel.publishedUserLogedInModel?.removeAll()

                                if selected == "Applied" {
                                    shipmentsViewModel.GetAppliedShipment()
                                }else if selected == "Upcoming" {
                                    shipmentsViewModel.GetUpcomingShipment()
                                }else{
                                    shipmentsViewModel.GetCurrentShipment()
                                }
                            }
                        }, label: {
                            HStack(alignment: .center){
                                Text(Category )
                                    .font(.system(size: 15))
                                    .foregroundColor(self.selected == Category ? Color("blueColor") : Color("lightGray"))
                            }
                            .frame(width: 110, height: 45)
                            .clipShape(Rectangle())
                        })
                            .background( Color(self.selected == Category ? "tabText" : "lightGray").opacity(self.selected == Category  ? 1 : 0.3).cornerRadius(8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.blue, lineWidth:self.selected == Category ? 1:0))
                        
                    }}
                List() {
//                    if  true{ // if empty
//                        Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
//                            .multilineTextAlignment(.center)
//                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
//                    }
                    ForEach(shipmentsViewModel.publishedUserLogedInModel ?? [], id:\.self) { tripItem in
//                            print(tripItem.shipmentStatusName ?? "4545454545454")

                            tripCellView(shipmentModel: tripItem)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)

                    }.onTapGesture {
                        goToShipmentDetails = true
                    }
                    ZStack{}
                    .frame( maxHeight: 2)
                    .foregroundColor(.black)
                    .onAppear(perform: {
                       // pagination
                    })
                }.refreshable(action: {
//                    getAllDoctors()
                })
                .frame(width: UIScreen.main.bounds.width)
                .listStyle(.plain)
                .padding(.vertical,0)

            }
                            .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))

            TitleBar(Title: "Shipments", navBarHidden: true, trailingButton: .filterButton, subText: "55" ,trailingAction: {
            })
        }.onAppear(perform: {
            shipmentsViewModel.GetAppliedShipment() // not executed
            print(shipmentsViewModel.publishedUserLogedInModel ?? [])
        })

        NavigationLink(destination: DetailsView(),isActive:$goToShipmentDetails , label: {
        })
        
    }
}

struct ShipmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentsView()
    }
}
