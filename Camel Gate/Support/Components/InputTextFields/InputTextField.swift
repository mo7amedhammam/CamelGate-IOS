//
//  InputTextField.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//
import SwiftUI

struct InputTextField: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear
    @State var fieldType : inputfields? = .Default

    var placeholder : String
    @State var placeholderColor : Color? = .gray.opacity(0.5)

    @Binding var text: String
    var Disabled : Bool?

    let screenWidth = UIScreen.main.bounds.size.width - 55
    
    var body: some View {
        ZStack {
            HStack{
                if iconName != "" || iconName != nil{
                    Image(iconName ?? "")
                        .renderingMode( iconColor != .clear ? .template:.original)
                        .foregroundColor(iconColor == .clear ? .clear:iconColor)
                        .font(.system(size: 15))
                }else{
                }
                
                ZStack (alignment:.leading){
                    Text(placeholder)
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
                        .offset(y: text.isEmpty ? 0 : -20)
                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                        .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
                    
                    HStack{
                        if fieldType == .Phone{
                            Text("+966 |")
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .foregroundColor(.gray.opacity(0.5))
                        }
                    TextField("",text:$text)
                            .disabled(Disabled ?? false)
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                        .frame( minHeight: 50)
                        

                 }
                }
            }
            .frame( height: 50)
            .padding(.horizontal,10)
    //        .padding(.vertical,5)
            .disableAutocorrection(true)
            .background(
                Color.white
            )
                .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        }
        
    }
}
struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(iconName:"x321gray",fieldType:.Password, placeholder: "Name", text: .constant(""))
        
    }
}

enum inputfields {
    case Phone, Default, Password
}
//struct PhoneInputField: View {
//    @State var iconName : String? = ""
//    @State var iconColor : Color? = .clear
//    @State var field : inputfields? = .none
//
//    var placeholder : String
//
//    @Binding var text: String
//    let screenWidth = UIScreen.main.bounds.size.width - 55
//    var body: some View {
//        
//        HStack{
//            if iconName != "" || iconName != nil{
//                Image(iconName ?? "")
//                    .renderingMode( iconColor != .clear ? .template:.original)
//                    .foregroundColor(iconColor == .clear ? .clear:iconColor)
//                    .font(.system(size: 15))
//            }else{
//            }
//            
//          
//            ZStack(alignment:.leading){
//                Text(placeholder)
//                                                                   .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

//                    .foregroundColor(.gray.opacity(0.5))
//                    .offset(y: withAnimation{text.isEmpty ? 0 : -20})
//                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
//                    .padding(.leading,text.isEmpty ? 55:0)
//                HStack{
//                Text("+966 |")
//                                                                       .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

//                        .foregroundColor(.gray.opacity(0.5))
//                TextField("",text:$text)
//.font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
//                    .autocapitalization(.none)
//                    .textInputAutocapitalization(.never)
//             }
//            }
//        }
//        .frame( height: 30)
//        .padding(12)
//        .disableAutocorrection(true)
//        .background(
//            Color.white
//        )
//            .cornerRadius(5)
//            .shadow(color: Color.black.opacity(0.099), radius: 3)
//        
//    }
//}
//struct PhoneInputField_Previews: PreviewProvider {
//    static var previews: some View {
//        PhoneInputField(iconName:"x321gray",placeholder: "Phone", text: .constant(""))
//        
//    }
//}



struct InputDateField: View {
    @State var LeadingiconName : String? = ""
    @State var LeadingiconColor : Color? = .clear
    @State var TrailingiconName : String? = ""
    @State var TrailingiconColor : Color? = .clear
    var placeholder : String

    @Binding var text: String
    @Binding var date: Date

    
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        
        HStack{
            if LeadingiconName != "" || LeadingiconName != nil{
                Image(LeadingiconName ?? "")
                    .renderingMode( LeadingiconColor != .clear ? .template:.original)
//                    .foregroundColor(.secondary)
//                    .tint(.gray)
//                    .background(Color.white)
                    .foregroundColor(LeadingiconColor == .clear ? .clear:LeadingiconColor)
                    .font(.system(size: 15))
            }else{
            }
            
            ZStack (alignment:.leading){
                Text(placeholder)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                    .foregroundColor(.gray.opacity(0.5))
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("",text:$text)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
  
            }
            if TrailingiconName != "" || TrailingiconName != nil{
                Image(TrailingiconName ?? "")
                    .renderingMode( TrailingiconColor != .clear ? .template:.original)
                    .foregroundColor(TrailingiconColor == .clear ? .clear:TrailingiconColor)
                    .font(.system(size: 15))
            }else{
            }

        }
        .overlay(content: {
            DatePicker("", selection: $date, displayedComponents: [.date])
                .opacity(0.051)
                .background(Color.clear)
                .tint(Color.red)
        })
        .frame( height: 50)
        .padding(.horizontal, 12)
        .disableAutocorrection(true)
        .background(
            Color.white
        )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct InputDateField_Previews: PreviewProvider {
    static var previews: some View {
        InputDateField(LeadingiconName:"x321gray",placeholder: "Name", text: .constant("Mohamed Hammam"), date: .constant(Date()))
        
    }
}


struct InputTextField2: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear
    @State var fieldType : inputfields? = .Default

    var placeholder : String
    @State var placeholderColor : Color? = .gray.opacity(0.5)

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    
    var body: some View {
        GeometryReader {g in
            HStack{
                if iconName != "" || iconName != nil{
                    Image(iconName ?? "")
                        .renderingMode( iconColor != .clear ? .template:.original)
                        .foregroundColor(iconColor == .clear ? .clear:iconColor)
                        .font(.system(size: 15))
                }else{
                }
                
                ZStack (alignment:.leading){
                    Text(placeholder)
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
                        .offset(y: text.isEmpty ? 0 : -20)
                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                        .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
                    
                    HStack{
                        if fieldType == .Phone{
                            Text("+966 |")
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .foregroundColor(.gray.opacity(0.5))
                        }
                    TextField("",text:$text)
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                        .frame( height: 50)

                 }
                }
            }

            .padding(.horizontal,10)
    //        .padding(.vertical,5)
            .disableAutocorrection(true)
            .background(
                Color.white
            )
                .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
            .frame(width:g.size.width, height: g.size.height)

        }
        .ignoresSafeArea()
        
    }
}
struct InputTextField2_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField2(iconName:"x321gray",fieldType:.Password, placeholder: "Name", text: .constant(""))
        
    }
}


struct InputTextField22: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear
    @State var fieldType : inputfields? = .Default
    @State var BirthdateStr : String = ""
    @State var Birthdate : Date = Date()

    var placeholder : String
    @State var placeholderColor : Color? = .gray.opacity(0.5)

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    
    var body: some View {
        
        VStack (spacing:40){
            
            GeometryReader {g in
                InputTextField(iconName: "CalendarOrange",iconColor: Color("OrangColor"), placeholder: "BirthDate".localized(language), text: $BirthdateStr)
                                        .disabled(true)
                    .overlay(content: {
                        DatePicker("", selection: $Birthdate,in: ...(Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()) ,displayedComponents: [.date])
                            .opacity(0.02)
                            .labelsHidden()
                            .frame(minHeight:50)
                            .frame(minWidth:g.size.width)
                        HStack{
                                            Spacer()
                            Image(systemName:language.rawValue == "en" ? "chevron.right":"chevron.left")
                                .foregroundColor(                                    Color("lightGray").opacity(0.5))
                                .padding(.horizontal)
//                                .frame(width:20)

                        }
//                        .frame(minWidth:g.size.width)

                })
            }
            
            
            TextField("",text:$text)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .frame( minHeight: 50)
                .font(.system(size: 20))
                .padding(.horizontal,10)
                .disableAutocorrection(true)
                .background(
                    Color.white
                )
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
            
            
            
//            TextField("",text:$text)
//                .autocapitalization(.none)
//                .textInputAutocapitalization(.never)
//                .frame( height: 50)
//                .font(.system(size: 30))
//                .padding(.horizontal,10)
//                .disableAutocorrection(true)
//                .background(
//                    Color.white
//                )
//                .cornerRadius(5)
//                .shadow(color: Color.black.opacity(0.099), radius: 3)
//            
//                .overlay(
//                HStack{
//                        if iconName != "" || iconName != nil{
//                            Image(iconName ?? "")
//                                .renderingMode( iconColor != .clear ? .template:.original)
//                                .foregroundColor(iconColor == .clear ? .clear:iconColor)
//                                .font(.system(size: 15))
//                        }else{
//                        }
//                            Text(placeholder)
//                                .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
//                                .offset(y: text.isEmpty ? 0 : -20)
//                                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
//                                .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
//                    HStack(alignment:.lastTextBaseline){
//                                if fieldType == .Phone{
//                                    Text("+966 |")
//                                    .foregroundColor(.gray.opacity(0.5))
//                                }
//                                Spacer()
////                                Text(text)
//    //                        TextField("",text:$text)
//    //                            .autocapitalization(.none)
//    //                            .textInputAutocapitalization(.never)
//    //                            .frame( height: 50)
////                        Spacer()
//                         }
//                    .frame(height:50)
//                }
//            )
            
            
            
            
//                TextField("",text:$text)
//                    .autocapitalization(.none)
//                    .textInputAutocapitalization(.never)
//                    .frame( height: 50)
//                    .padding(.horizontal,10)
//                    .disableAutocorrection(true)
//                    .background(
//                        Color.white
//                    )
//                    .cornerRadius(5)
//                    .shadow(color: Color.black.opacity(0.099), radius: 3)
//                
//                    .overlay(
//                    HStack{
//                            if iconName != "" || iconName != nil{
//                                Image(iconName ?? "")
//                                    .renderingMode( iconColor != .clear ? .template:.original)
//                                    .foregroundColor(iconColor == .clear ? .clear:iconColor)
//                                    .font(.system(size: 15))
//                            }else{
//                            }
//                                Text(placeholder)
//                                    .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
//                                    .offset(y: text.isEmpty ? 0 : -20)
//                                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
//                                    .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
//                        HStack(alignment:.lastTextBaseline){
//                                    if fieldType == .Phone{
//                                        Text("+966 |")
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    }
//                                    
//                                    Text(text)
//        //                        TextField("",text:$text)
//        //                            .autocapitalization(.none)
//        //                            .textInputAutocapitalization(.never)
//        //                            .frame( height: 50)
////                            Spacer()
//                             }
//                        .frame(height:50)
//                    }
//                )
            
        }

    }
}
struct InputTextField22_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField22(iconName:"x321gray",fieldType:.Password, placeholder: "Name", text: .constant(""))
        
    }
}

struct InputTextField1: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear
    @State var fieldType : inputfields? = .Default

    var placeholder : String
    @State var placeholderColor : Color? = .gray.opacity(0.5)

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    
    var body: some View {
        HStack{
            if iconName != "" || iconName != nil{
                Image(iconName ?? "")
                    .renderingMode( iconColor != .clear ? .template:.original)
                    .foregroundColor(iconColor == .clear ? .clear:iconColor)
//                    .font(.system(size: 15))
                    .frame(width: 15, height: 15, alignment: .center)
            }else{
            }
            
            ZStack (alignment:.leading){
                Text(placeholder)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                    .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                    .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
                
                HStack{
                    if fieldType == .Phone{
                        Text("+966 |")
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        .foregroundColor(.gray.opacity(0.5))
                    }
                    TextField("",text:$text)
                    .textFieldStyle(.plain)
//                        .frame( minHeight: 50)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr9:Font.camelfonts.Reg9)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
//                    .padding(.leading,10)
                    .padding(.trailing,-10)
                    .padding(.bottom,-5)
                    .scaleEffect(1.8, anchor: .leading)
                    .frame(height:60)
             }
                .frame( minHeight: 55)
            }
        }
//        .frame( height: 50)
        .padding(.horizontal,10)
//        .padding(.vertical,5)
        .disableAutocorrection(true)
        .background(
            Color.white
        )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct InputTextField1_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField1(iconName:"x321gray",fieldType:.Password, placeholder: "Name", text: .constant(""))
        
    }
}



struct UIKitTextField: UIViewRepresentable {
  var titleKey: String
  @Binding var text: String

  public init(_ titleKey: String, text: Binding<String>) {
    self.titleKey = titleKey
    self._text = text
  }

  func makeUIView(context: Context) -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.delegate = context.coordinator
    textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textField.placeholder = NSLocalizedString(titleKey, comment: "")

    return textField
  }

  func updateUIView(_ uiView: UITextField, context: Context) {
    if text != uiView.text {
        uiView.text = text
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  final class Coordinator: NSObject, UITextFieldDelegate {
    var parent: UIKitTextField

    init(_ textField: UIKitTextField) {
      self.parent = textField
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
//      guard textField.markedTextRange == nil, parent.text != textField.text else {
//        return
//      }
      parent.text = textField.text ?? ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
  }
}



struct InputTextFieldKit: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear
    @State var fieldType : inputfields? = .Default

    var placeholder : String
    @State var placeholderColor : Color? = .gray.opacity(0.5)

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    
    var body: some View {
        HStack{
            if iconName != "" || iconName != nil{
                Image(iconName ?? "")
                    .renderingMode( iconColor != .clear ? .template:.original)
                    .foregroundColor(iconColor == .clear ? .clear:iconColor)
                    .font(.system(size: 15))
            }else{
            }
            
            ZStack (alignment:.leading){
                Text(placeholder)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                    .foregroundColor(placeholderColor == .red ?  .red:placeholderColor)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                    .padding(.leading,fieldType == .Phone ? text.isEmpty ? 55:0:0)
                
                HStack{
                    if fieldType == .Phone{
                        Text("+966 |")
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        .foregroundColor(.gray.opacity(0.5))
                    }
//                TextField("",text:$text)
                    UIKitTextField("", text: $text)

                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .frame( minHeight: 50)

             }
            }
        }
        .frame( height: 50)
        .padding(.horizontal,10)
//        .padding(.vertical,5)
        .disableAutocorrection(true)
        .background(
            Color.white
        )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct InputTextFieldkit_Previews: PreviewProvider {
    static var previews: some View {
        InputTextFieldKit(iconName:"x321gray",fieldType:.Password, placeholder: "Name", text: .constant(""))
        
    }
}
