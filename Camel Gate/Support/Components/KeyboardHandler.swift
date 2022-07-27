//
//  KeyboardHandler.swift
//  Camel Gate
//
//  Created by wecancity on 27/07/2022.
//

import Foundation
import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    
    @Published private(set) var currentHeight: CGFloat = 0

    @objc func keyBoardWillShow(notification: Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                currentHeight = keyboardSize.height
            }
        }
        @objc func keyBoardWillHide(notification: Notification) {
            currentHeight = 0
        }
}

// usage ...> Observed Object, and make padding to current height

//MARK: ------- another way ---

let keyboardSpaceD = KeyboardSpace()
extension View {
    func keyboardSpace() -> some View {
        modifier(KeyboardSpace.Space(data: keyboardSpaceD))
    }
}

class KeyboardSpace: ObservableObject {
    var sub: AnyCancellable?
    
    @Published var currentHeight: CGFloat = 0
    var heightIn: CGFloat = 0 {
        didSet {
            withAnimation {
                if UIWindow.keyWindow != nil {
                    //fix notification when switching from another app with keyboard
                    self.currentHeight = heightIn
                }
            }
        }
    }
    
    init() {
        subscribeToKeyboardEvents()
    }
    
    private let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height - (UIWindow.keyWindow?.safeAreaInsets.bottom ?? 0) - 80 }
    
    private let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }
    
    private func subscribeToKeyboardEvents() {
        sub?.cancel()
        sub = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.self.heightIn, on: self)
    }
    
    deinit {
        sub?.cancel()
    }
    
    struct Space: ViewModifier {
        @ObservedObject var data: KeyboardSpace
        
        func body(content: Content) -> some View {
            VStack(spacing: 0) {
                content
                
                Rectangle()
                    .foregroundColor(Color(.clear))
                    .frame(height: data.currentHeight)
                    .frame(maxWidth: .greatestFiniteMagnitude)
            }
        }
    }
}
extension UIWindow {
    static var keyWindow: UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }
            .flatMap { $0 as? UIWindowScene }?.windows
            .first { $0.isKeyWindow }
        return keyWindow
    }
}
// usage ...> .keyboardspace()
