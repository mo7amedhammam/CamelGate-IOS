//
//  CustomAlert.swift
//  Camel Gate
//
//  Created by wecancity on 19/12/2022.
//


import Combine
import SwiftUI

/// Alert type
enum AlertType {
    
    case success(image: String = "",lefttext:String="OK",righttext:String="")
    case error(title: String,image:String = "xMark" , message: String = "",lefttext:String,righttext:String)
    
    func title() -> String {
        switch self {
        case .success(_,_,_):
            return "Success"
        case .error(title: let title,_ ,_, _, _):
            return title
        }
    }
    func image() -> String{
        switch self {
        case .success(image:let image,_,_):
            return image
        case .error(_, image:let image, _, _, _):
            return image
        }
    }

    func message() -> String {
        switch self {
        case .success:
            return "Please confirm that you're still open to session requests"
        case .error(_,_ ,message: let message,_ ,_):
            return message
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .success(_,lefttext:let text,_):
            return text
        case .error(_, _,_,lefttext:let text,_):
            return text
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .success:
            return ""
        case .error(_, _,_, _, righttext:let text):
            return text
        }
    }
    
    func height(isShowVerticalButtons: Bool = false) -> CGFloat {
        switch self {
        case .success:
            return isShowVerticalButtons ? 220 : title() == "" ? 180:240
        case .error(_,_, _, _, _):
            return isShowVerticalButtons ? 220 : title() == "" ? 180:240
        }
    }
}

/// A boolean State variable is required in order to present the view.
struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .success()
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false

    var leftButtonText = ""
    var rightButtonText = ""
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        ZStack {
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Color(#colorLiteral(red: 0.3697291017, green: 0.2442134917, blue: 0.5784509778, alpha: 1))
                    .frame(height : 8)
                
                if alertType.title() != "" {
                    
                    // alert title
                    Text(alertType.title())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                if alertType.image() != ""{
                    ZStack {
                        Image("CancelledX")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 0.3697291017, green: 0.2442134917, blue: 0.5784509778, alpha: 1)))
                            .padding(.top,alertType.title() == "" ? 5:0)
                        .padding(.bottom, 8)
                        Image(alertType.image())
                            .renderingMode(.template)
                            .foregroundColor(Color("Second_Color"))
                    }
                }
                
                // alert message
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.camelRegular(of: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                if !isShowVerticalButtons {
                    HStack(spacing: 0) {
                        
                        // left button
                        if (!alertType.leftActionText.isEmpty) {
                            Button {
                                leftButtonAction?()
                            } label: {
                                Text(alertType.leftActionText)
                                    .font(.camelBold(of: 16))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Divider()
                                .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                        }
                        
                        // right button (default)
                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.camelBold(of: 16))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                        startPoint: .trailing,
                                        endPoint: .leading
                                    )
                                )
                        }
                        
                       
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)
                    
                } else {
                    VStack(spacing: 0) {
                        Spacer()
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .font(.camelBold(of: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                        
                        Divider()
                        
                        Spacer()
                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                    }
                    .frame(height: verticalButtonsHeight)
                }
            }
            .frame(width: 270, height: alertType.height(isShowVerticalButtons: isShowVerticalButtons))
            .background(
                Color.white
            )
            .cornerRadius(8)
        }
        .zIndex(2)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(presentAlert: .constant(true),alertType:.error(title: "", message: "error message",lefttext: "",righttext: "Done"))
    }
}
