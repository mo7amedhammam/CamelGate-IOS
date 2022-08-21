//
//  ActivityIndicatorView.swift
//  Camel Gate
//
//  Created by wecancity on 03/08/2022.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool?
//    @State var loadingTitle : LoadingType?
     var body: some View {
         if isPresented ?? false{
            ZStack {
                ZStack{
//                    GifImage(isPresented: $isPresented, name: "App-Loading")
                        ProgressView {
                        }
                        .frame(width: 120, height: 120)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(1.5 , anchor: .center)
                        .background(Color.black.opacity(0.55)).cornerRadius(20)
                    }
                    .background(Color.gray.opacity(0.1).blur(radius: 20))
                .edgesIgnoringSafeArea(.all)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(Color.black.opacity(0.1))

            }
                   
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(isPresented: .constant(true))
    }
}




struct AnimatingGif: View {
    @Binding var isPresented:Bool?
//    @State var loadingTitle : LoadingType?
     var body: some View {
         if isPresented ?? false{
            ZStack {
                ZStack{
//                    GifImage( name: "App-Loading")
                    
                    LottieView(lottieFile: "App-Loading-File")
                        .frame(width: 300, height: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(Color.black.opacity(0.1))

            }
         }
    }
}

struct AnimatingGif_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGif(isPresented: .constant(true))
    }
}


import WebKit
struct GifImage: UIViewRepresentable {
//    @Binding var isPresented:Bool?

    private let name : String
    init( name:String) {
        self.name = name
    }
    func makeUIView(context: Context) -> WKWebView {
        
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data =  try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
            )
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage( name: "App-Loading")
    }
}



import Lottie
 
struct LottieView: UIViewRepresentable {
    let lottieFile: String
 
    let animationView = AnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = .loop
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
