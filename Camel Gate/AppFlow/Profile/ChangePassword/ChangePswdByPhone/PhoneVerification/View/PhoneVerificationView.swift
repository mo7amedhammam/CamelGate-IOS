//
//  PhoneVerificationView.swift
//  Camel Gate
//
//  Created by wecancity on 25/07/2022.
//

import SwiftUI

struct PhoneVerificationView<T:ObservableObject>: View {
    var language = LocalizationService.shared.language

    @State var gotonewpassword = false
    
    @EnvironmentObject var ViewModel : T
    
    @State private var matchedOTP = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var minutes: Int = 00
    @State private var seconds: Int = 00
    
    @State private var hideIncorrectCode = true
    @StateObject var viewModel = OTPViewModel()
    @State var isErrorCode = false
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*4)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    @State  var isfocused = false
    
    var body: some View {
        ZStack{
            
            VStack {
                ScrollView{
                    Spacer().frame(height:120)
                    
                    Image("message-orange")
                    
                    Text("Please_enter_the_Verification_Code_\nwe_sent_to_your_mobile".localized(language) )
                        .font(Font.camelfonts.Reg16)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    ZStack {
                        HStack (spacing: spaceBetweenBoxes){
                            
                            otpText(text: viewModel.otp1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth:
                                                    isfocused&&viewModel.otp1 == "" ? 1:0)
                                )
                            otpText(text: viewModel.otp2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: viewModel.otp1 != ""&&viewModel.otp2 == "" ? 1:0)
                                )
                            
                            otpText(text: viewModel.otp3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth:  viewModel.otp2 != ""&&viewModel.otp3 == "" ? 1:0)
                                )
                            
                            otpText(text: viewModel.otp4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: viewModel.otp3 != ""&&viewModel.otp4 == "" ? 1:0)
                                )
                            
                            
                        }
                        
                        TextField("", text: $viewModel.otpField)
                        //                            .focused($isfocused)
                            .autocapitalization(.none)
                            .frame(width: isfocused ? 2 : textFieldOriginalWidth, height: textBoxHeight)
                            .disabled(viewModel.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    .padding(.vertical, 22)
                    Group{
                        HStack {
                            Text("Code_sent_to_+2".localized(language))
                            Text("01101201322")
                                .foregroundColor(Color("blueColor"))
                        }
                        .font(Font.camelfonts.Reg16)
                        .foregroundColor(.black)
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                        
                        Text((hideIncorrectCode == false || (minutes == 0 && seconds == 0 )) ? "expired_or_Tomeout_codeMessage".localized(language): "This_code_will_be_expired_within".localized(language))
                            .padding(.top,2)
                            .foregroundColor((hideIncorrectCode == false || (minutes == 0 && seconds == 0 )) ? .red:.black )
                    }
                    .font(Font.camelfonts.Reg16)
                    
                    Text("\(minutes):\(seconds)")
                        .font(.subheadline)
                        .onReceive(timer) { time in
                            updateTimer()
                        }
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.2)
                        )
                        .keyboardSpace()

                    Button(action: {
                        // resend code action
                        //                    RegisterUserVM.startFetchUserRegisteration()
                        hideIncorrectCode =  true
                        //                    self.DynamicTimer(sentTimer: RegisterUserVM.publishedUserRegisteredModel?.ReSendCounter ?? 60)
                    }, label: {
                        Text("Resend_Code".localized(language))
                            .font(Font.camelfonts.Reg16)
                            .padding()
                            .foregroundColor( (minutes == 00 && seconds == 00) ? Color("blueColor") : Color(uiColor: .lightGray))
                    }).disabled(minutes != 00 && seconds != 00)
                    // Alert with no internet connection
                        .alert(isPresented: $isErrorCode, content: {
                            Alert(title: Text("Error_Code".localized(language)), message: nil, dismissButton: .cancel())
                        })
                    
                    Spacer()
                }
                
                Button(action: {
                    // send code action
                    gotonewpassword = true
                    let otp = viewModel.otp1+viewModel.otp2+viewModel.otp3+viewModel.otp4
                    if checkOTP(sentOTP: 1234 , TypedOTP: Int(otp) ?? 0000){
                        self.matchedOTP.toggle()
                        // action
                        gotonewpassword = true
                        //                        CreateUserVM.startFetchUserCreation()
                    }else{
                        hideIncorrectCode =  false
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
                        )
                            .opacity(viewModel.otp4 == "" || (minutes == 00 && seconds == 00) ? 0.5:1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 25)
                })
//                    .padding(.top, 120)
                    .disabled(viewModel.otp4 == "" || (minutes == 00 && seconds == 00))
            }
            .padding(.bottom)
            
            TitleBar(Title: "Change_Password", navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
            
            NavigationLink(destination: NewPasswordView(),isActive:$gotonewpassword , label: {
            })
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard ){
                        Spacer()
                        Button("Done".localized(language)){
                            isfocused = false
                            hideKeyboard()
                        }
                    }
                }
            
            NavigationLink(destination: NewPasswordView(),isActive:$gotonewpassword , label: {
            })
            
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .onAppear(perform: {
            DynamicTimer(sentTimer: 120)
            //            CreateUserVM.fullName = RegisterUserVM.fullName
            //            CreateUserVM.email = RegisterUserVM.email
            //            CreateUserVM.phoneNumber = RegisterUserVM.phoneNumber
            //            CreateUserVM.password = RegisterUserVM.password
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                //                     let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                //                     let height = value.height
                //                     let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                isfocused = true
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
                isfocused = false
            }
        })
        .onTapGesture(perform: {
            isfocused = false
            hideKeyboard()
        })
        
        NavigationLink(destination: NewPasswordView(),isActive:$gotonewpassword , label: {
        })
        // Alert with no internet connection
        //        .alert(isPresented: $CreateUserVM.isAlert, content: {
        //            Alert(title: Text(CreateUserVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
        //                CreateUserVM.isAlert = false
        //            }))
        //        })
        
        
    }
    private func otpText(text: String) -> some View {
        return Text(text)
            .font(Font.camelfonts.SemiBold24)
            .foregroundColor(Color("blueColor"))
            .frame(width: textBoxWidth, height: textBoxHeight)
            .background(
                RoundedRectangle(cornerRadius: 6).frame(width: 55, height: 55, alignment: .center)
                    .foregroundColor(Color(uiColor: .secondaryLabel ).opacity(0.2))
            )
            .padding(paddingOfBox)
    }
    
    func updateTimer(){
        if self.seconds > 0 {
            self.seconds = self.seconds - 1
        }
        else if self.minutes > 0 && self.seconds == 0 {
            self.minutes = self.minutes - 1
            self.seconds = 59
        }
    }
    
    //MARK: validOTP
    func checkOTP(sentOTP:Int, TypedOTP:Int ) -> Bool{
        if sentOTP == TypedOTP {
            return true
        }else{
            return false
        }
    }
    
    //MARK: validOTP
    func DynamicTimer(sentTimer:Int ){
        self.minutes = sentTimer/60
    }
    
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PhoneVerificationView<OTPViewModel>()
        }
    
        ZStack {
            PhoneVerificationView<OTPViewModel>()
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}




