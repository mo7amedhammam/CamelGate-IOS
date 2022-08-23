//
//  ShipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI
import Alamofire

struct ShipmentsView: View {
    @AppStorage("language")
    var language = LocalizationService.shared.language

    @StateObject var shipmentsViewModel = ShipmentsViewModel()
    //    @EnvironmentObject var detailsVM : ShipmentDetailsViewModel
    
    @State var goToShipmentDetails:Bool = false
    @State var shipmentsCategory = ["Current","Upcoming","Applied"]
    @State var selected = "Applied"
    
    @State var active = false
    @State var destination = AnyView(DetailsView(shipmentId: 0))
    @State var selectedShipmentId = 0
    
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height:145)
                HStack{
                    ForEach(shipmentsCategory,id:\.self){ Category in
                        Button(action: {
                            withAnimation{
                                self.selected = Category
                                getshipments()
                            }
                        }, label: {
                            HStack(alignment: .center){
                                Text("\(Category)".localized(language) )
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
                    ForEach($shipmentsViewModel.publishedUserLogedInModel, id:\.self) { tripItem in
                        Button(action: {
                            
                            active = true
                            destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                        }, label: {
                            tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId)
                        }).buttonStyle(.plain)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    ZStack{}
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .frame( maxHeight: 2)
                    .foregroundColor(.black)
                    .onAppear(perform: {
                        // pagination
                    })
                }.refreshable(action: {
                    getshipments()
                })
//                    .frame(width: UIScreen.main.bounds.width)
                    .listStyle(.plain)
                    .padding(.vertical,0)
                    .padding(.horizontal,-10)
                    .overlay(
                        ZStack{
                            if shipmentsViewModel.nodata == true {
                                Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                                    .multilineTextAlignment(.center)
                                    .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                            }
                        }
                    )
                
            }
            .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
            
            TitleBar(Title: "Shipments".localized(language), navBarHidden: true, trailingButton: TopButtons.none ,trailingAction: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .overlay(content: {
            AnimatingGif(isPresented: $shipmentsViewModel.isLoading)
        })

        
        .onAppear(perform: {
            selectedShipmentId = 0
            getshipments()
            
        })
            .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId))
            })
        
        NavigationLink(destination: destination,isActive:$active , label: {
        })

        // Alert with no internet connection
            .alert(isPresented: $shipmentsViewModel.isAlert, content: {
                Alert(title: Text(shipmentsViewModel.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    if shipmentsViewModel.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        destination = AnyView(SignInView())
                        active = true
                    }
                    shipmentsViewModel.isAlert = false
                }))
            })
        
    }
}

struct ShipmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentsView()
    }
}

extension ShipmentsView{
    func getshipments() {
        if selected == "Applied".localized(language) {
            shipmentsViewModel.GetShipment(type: .applied)
        }else if selected == "Upcoming".localized(language) {
            shipmentsViewModel.GetShipment(type: .Upcomming)
        }else if selected == "Current".localized(language){
            shipmentsViewModel.GetShipment(type: .current)
        }
    }
}
