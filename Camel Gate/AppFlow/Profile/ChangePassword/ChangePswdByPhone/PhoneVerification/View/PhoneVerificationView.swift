//
//  PhoneVerificationView.swift
//  Camel Gate
//
//  Created by wecancity on 25/07/2022.
//

import SwiftUI
import PromiseKit
enum operations {
    case signup,password, none
}

struct PhoneVerificationView: View{
    var language = LocalizationService.shared.language
    var op : operations = .none
    @Binding var phoneNumber : String
    @Binding var CurrentOTP : Int
    @Binding var validFor : Int
    @Binding var matchedOTP : Bool
    @Binding var isPresented : Bool

    @StateObject var SignUpVM : SignUpViewModel = SignUpViewModel()
    @StateObject var changePasswordVM : ChangePasswordViewModel = ChangePasswordViewModel()
    @EnvironmentObject var resendOTPVM : ResendOTPViewModel

    @State var gotonewpassword = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var minutes: Int = 00
    @State private var seconds: Int = 00
    
    @State private var hideIncorrectCode = true
    @StateObject var otpVM = OTPViewModel()
    @State var isErrorCode = false
    @State var errorMessage = ""

    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*5)+((paddingOfBox*2)*5)
    }
    @State  var isfocused : Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                ScrollView{
                    Spacer().frame(height:120)
                    
                    Image("message-orange")
                    
                    Text("Please_enter_the_Verification_Code_\nwe_sent_to_your_mobile".localized(language) )
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
//                    Text("\(String(CurrentOTP))")
//                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.center)

                    ZStack {
                        HStack (spacing: spaceBetweenBoxes){
                            otpText(text: otpVM.otp1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth:
                                                    isfocused && otpVM.otp1 == "" ? 1:0)
                                )
                            otpText(text: otpVM.otp2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: otpVM.otp1 != ""&&otpVM.otp2 == "" ? 1:0)
                                )
                            
                            otpText(text: otpVM.otp3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth:  otpVM.otp2 != ""&&otpVM.otp3 == "" ? 1:0)
                                )
                            
                            otpText(text: otpVM.otp4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: otpVM.otp3 != ""&&otpVM.otp4 == "" ? 1:0)
                                )
                            otpText(text: otpVM.otp5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: otpVM.otp4 != ""&&otpVM.otp5 == "" ? 1:0)
                                )
                            otpText(text: otpVM.otp6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.blue, lineWidth: otpVM.otp5 != ""&&otpVM.otp6 == "" ? 1:0)
                                )
                        }
                        
                        TextField("", text: $otpVM.otpField)
                            .autocapitalization(.none)
                            .frame(width: isfocused ? 2 : textFieldOriginalWidth, height: textBoxHeight)
                            .disabled(otpVM.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    .padding(.vertical, 22)
                    .environment(\.layoutDirection, .leftToRight)

                    Group{
                        HStack {
                            Text("Code_sent_to_+966".localized(language))
                                Text("Country_Code".localized(language) + phoneNumber)
                                    .foregroundColor(Color("blueColor"))
                        }
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .foregroundColor(.black)
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                        if errorMessage != "" {
                            Text(errorMessage.localized(language))
                            .padding(.top,2)
                            .foregroundColor(.red )
                        }
                    }
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    
                    Text("\(minutes):\(seconds)".convertedDigitsToLocale(identifier: "en_US"))
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
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .keyboardSpace()
                    
                    //MARK: --  Resend code button --
                    Button(action: {
                        // resend code action
                        resendOTPVM.phoneNumber = phoneNumber
                        resendOTPVM.SendOTP()
                        otpVM.otpField = ""
                    }, label: {
                        Text("Resend_Code".localized(language))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                            .padding()
                            .foregroundColor( (minutes == 00 && seconds == 00) ? Color("blueColor") : Color(uiColor: .lightGray))
                    }).disabled(minutes != 00 && seconds != 00)
                    Spacer()
                }
            }
            .padding(.bottom)

            TitleBar(Title: "Verify_Mobile".localized(language), navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
            
            NavigationLink(destination: NewPasswordView(otp:CurrentOTP),isActive:$gotonewpassword , label: {
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
            
//            NavigationLink(destination: NewPasswordView(),isActive:$gotonewpassword , label: {
//            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
        .overlay(
            ZStack{
            if SignUpVM.isAlert{
                CustomAlert(presentAlert: $SignUpVM.isAlert,alertType: .error(title: "", message: SignUpVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                        SignUpVM.isAlert = false
                })
                }
                
                if changePasswordVM.isAlert{
                    CustomAlert(presentAlert: $changePasswordVM.isAlert,alertType: .error(title: "", message: changePasswordVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                        changePasswordVM.isAlert = false
                    })
                    }
            }.ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
        )
        
        .onAppear(perform: {
            DynamicTimer(sentTimer: validFor)
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
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
        
        .onChange(of: otpVM.otp6, perform: {newval in
            guard newval != "" else {return}
            
            let otp = "\(otpVM.otp1+otpVM.otp2+otpVM.otp3+otpVM.otp4+otpVM.otp5+newval)".convertedDigitsToLocale(identifier: "en_US")
                        
//            if checkOTP(sentOTP: CurrentOTP , TypedOTP: Int(otp) ?? 0000) && (minutes > 0 || seconds > 0){
                if op == .signup {
                    SignUpVM.phoneNumber = phoneNumber
                    SignUpVM.typedOtp = otp
                    SignUpVM.VerifyUser()

//                    matchedOTP.toggle()
//                    isPresented.toggle()
                }else if  op == .password{
                    changePasswordVM.phoneNumber = phoneNumber
                    changePasswordVM.typedOtp = otp
                    changePasswordVM.VerifyOTP()
//                    matchedOTP.toggle()
//                    isPresented.toggle()
                    
                }
//            }else{
                if (minutes == 0 && seconds == 0) {
                    errorMessage = "Time_is_Out"
                }else if newval == "" && (minutes > 0 || seconds > 0){
                    errorMessage = "This_code_will_be_expired_within"
                }
                else{
//                    errorMessage = "Incorrect_Code"
                }
//            }
        })
        .onChange(of: resendOTPVM.NewCode, perform: {newval in
//                   print(newval)
                CurrentOTP = resendOTPVM.NewCode
                    validFor = resendOTPVM.NewSecondsCount
                    DynamicTimer(sentTimer: validFor)
                    errorMessage = ""
                })
        
        .onChange(of: SignUpVM.accountVerified, perform: {newval in
            if newval == true{
                matchedOTP.toggle()
                isPresented.toggle()
            }
        })
        .onChange(of: changePasswordVM.otpVerified, perform: {newval in
            if newval == true{
                matchedOTP.toggle()
                isPresented.toggle()
            }
        })

    }
    private func otpText(text: String) -> some View {
        return Text(text.convertedDigitsToLocale(identifier: "en_US"))
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
//    func checkOTP(sentOTP:Int, TypedOTP:Int ) -> Bool{
//        if sentOTP == TypedOTP {
//            return true
//        }else{
//            return false
//        }
//    }
    
    //MARK: validOTP
    func DynamicTimer(sentTimer:Int ){
        self.minutes = sentTimer/60
        self.seconds = sentTimer%60
    }
    
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PhoneVerificationView( op: .signup, phoneNumber: .constant(""), CurrentOTP: .constant(0), validFor: .constant(88), matchedOTP: .constant(false), isPresented: .constant(false))
                .environmentObject(ResendOTPViewModel())
        }
        
        ZStack {
            PhoneVerificationView(op:.signup, phoneNumber: .constant(""), CurrentOTP: .constant(0), validFor: .constant(88), matchedOTP: .constant(false), isPresented: .constant(false))
                .environmentObject(ResendOTPViewModel())

        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}




