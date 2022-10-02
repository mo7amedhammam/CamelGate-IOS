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
                TextField("",text:$text)
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .frame( height: 40)

             }
            }
        }
        .frame( height: 40)
        .padding(.horizontal,10)
        .padding(.vertical,5)
        .disableAutocorrection(true)
        .background(
            Color.white
        )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
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
        .frame( height: 30)
        .padding(12)
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

