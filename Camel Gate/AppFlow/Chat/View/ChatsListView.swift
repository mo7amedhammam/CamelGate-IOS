//
//  ChatsListView.swift
//  Camel Gate
//
//  Created by wecancity on 28/07/2022.
//

import SwiftUI

struct ChatsListView: View {
    
    @State var isexpanded = false
    var body: some View {
        ZStack{
            ChatHeader()
            
            VStack{
                VStack{
                    Text("Start_a_conversation".localized(language))
                        .foregroundColor(.black)
                        .padding(.top)
                    
                    Divider()
                    
                    HStack(spacing:-20){
                        ForEach(0..<4,id:\.self){_ in
                            Image("face_vector")
                            
                        }
                        
                        VStack(alignment:.leading){
                            Text("We_reply_usually")
                                .foregroundColor(.black.opacity(0.8))
                                .font(Font.camelfonts.Reg14)
                                .fontWeight(.thin)
                                .padding(.bottom,5)
                            
                            HStack{
                                Image(systemName: "clock")
                                Text("Less_than_1_minute".localized(language)).font(Font.camelfonts.Reg14)
                            }
                            .foregroundColor(.black)
                        }
                        
                        .padding(.leading,30)
                    }
                    .padding(.vertical)
                    
                    Button(action: {
                        DispatchQueue.main.async{
                            // Action
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Send_us_a_message".localized(language))
                                .font(Font.camelfonts.SemiBold14)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height:15)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                startPoint: .trailing,
                                endPoint: .leading
                            ))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.bottom)
                    })
                }
                .background(
                    Color.white
                )
                .cornerRadius(10)
                .foregroundColor(.white)
                Button(action: {
                    withAnimation(){
                        isexpanded.toggle()
                    }
                }, label: {
                    HStack{
                        Text("See_all_your_conversations".localized(language))
                        Image(systemName: isexpanded ? "chevron.up":"chevron.down")
                            .padding(.horizontal,5)
                        Spacer()
                    }
                    .foregroundColor(.secondary)
                    
                }).padding(.vertical)
                if isexpanded{
                    List() {
                        //                    if  true{ // if empty
                        //                        Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                        //                            .multilineTextAlignment(.center)
                        //                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                        //                    }
                        Group{
                            ForEach(0 ..< 5) { tripItem in
                                HStack{
                                    Image("face_vector")
                                    VStack{
                                        HStack{
                                            Text("Mahmoud")
                                                .font(Font.camelfonts.SemiBold14)
                                            Spacer()
                                            Text("12 hours ago")
                                                .font(Font.camelfonts.Reg14)
                                                .fontWeight(.thin)
                                        }.foregroundColor(.gray)
                                        
                                        Text("Thanks_for_using_CamelGate,_Ahmed_we...")
                                            .font(Font.camelfonts.Reg14)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                            }
                            ZStack{}
                            .frame(maxHeight:1)
                            .onAppear(perform: {
                                // pagination
                            })
                        }
                        .padding(.horizontal,-30)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                    }.refreshable(action: {
                        //                    getAllDoctors()
                    })
                    //                .frame(width: UIScreen.main.bounds.width)
                        .listStyle(.plain)
                        .padding(.vertical,0)
                }
                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.top, hasNotch ? 150:160)
        }
        .navigationBarHidden(true)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
        ChatsListView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
