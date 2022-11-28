//
//  ShipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI
struct ShipmentsView: View {
    @AppStorage("language")
    var language = LocalizationService.shared.language

    @StateObject var shipmentsViewModel = ShipmentsViewModel()
    @State var goToShipmentDetails:Bool = false
    @State var shipmentsCategory = ["Current","Upcoming","Applied"]
    @State var selected = "Applied"
    
    @State var active = false
    @State var destination = AnyView(DetailsView(shipmentId: 0))
    @State var selectedShipmentId = 0
    @EnvironmentObject var imageVM : camelEnvironments
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height:hasNotch ? 150:120)
                HStack{
                    ForEach(shipmentsCategory,id:\.self){ Category in
                        Button(action: {
                            withAnimation{
                                self.selected = Category
                                shipmentsViewModel.SkipCount = 0
                                getshipments(operation: .fetchshipments)
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
//                List() {
                    List($shipmentsViewModel.publishedShipmentsArr, id:\.self) { tripItem in
                        Button(action: {
                            active = true
                            destination = AnyView(DetailsView(shipmentId: selectedShipmentId).environmentObject(imageVM))
                        }, label: {
                            tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId)
                        }).buttonStyle(.plain)
//                            .listRowSeparator(.hidden)
//                            .listRowBackground(Color.clear)
//                    }
//                    ZStack{}
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
//                    .frame( maxHeight: 2)
//                    .foregroundColor(.black)
                    .onAppear(perform: {
                        // pagination
                        if shipmentsViewModel.publishedShipmentsArr.count >=  shipmentsViewModel.MaxResultCount && (tripItem.id == shipmentsViewModel.publishedShipmentsArr.last?.id){
                            shipmentsViewModel.SkipCount+=shipmentsViewModel.MaxResultCount
//                            shipmentsViewModel.GetShipmentsOp = .fetchmoreshipments
                            getshipments(operation: .fetchmoreshipments)
                        }else{
                            
                        }
                    })
                }.refreshable(action: {
                    shipmentsViewModel.SkipCount = 0
                    getshipments(operation:.fetchshipments)
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
            getDate()
        })
//        .task {
//            await getDate()
//        }
      
            .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(imageVM))
            })
        
        NavigationLink(destination: destination,isActive:$active , label: {
        })

        // Alert with no internet connection
            .alert(isPresented: $shipmentsViewModel.isAlert, content: {
                Alert(title: Text(shipmentsViewModel.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    if shipmentsViewModel.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        Helper.IsLoggedIn(value: false)
                        destination = AnyView(SignInView())
                        active = true
                    }
                    shipmentsViewModel.isAlert = false
                }))
            })
        
    }
    func getDate() {
        selectedShipmentId = 0
        shipmentsViewModel.SkipCount = 0
//        getshipments(operation: .fetchshipments)
    }
}

struct ShipmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentsView()
            .environmentObject(camelEnvironments())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

extension ShipmentsView{
    func getshipments(operation:GetShipmentsOperations) {
        if selected == "Applied" {
            shipmentsViewModel.GetShipment(type: .applied, operation: operation)
        }else if selected == "Upcoming" {
            shipmentsViewModel.GetShipment(type: .Upcomming, operation: operation)
        }else if selected == "Current"{
            shipmentsViewModel.GetShipment(type: .current, operation: operation)
        }
    }
}
