//
//  calendarPopUp.swift
//  Camel Gate
//
//  Created by wecancity on 04/08/2022.
//

import SwiftUI

enum dateRange {
    case open, withstart, withend, close
}

struct calendarPopUp:View{
    
    @Binding var selectedDate : Date
    @Binding var isPresented : Bool
    var displayedcomponent : DatePickerComponents?
    var rangeType:dateRange = .open
    var startingDate = Date()
    var endingDate = Date()

    var body: some View{
        if isPresented{
            ZStack {
                VisualEffectBlur(blurStyle: .systemThinMaterialDark)
//                    .opacity(0.9)
                               .ignoresSafeArea()
            }
            .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height, alignment: .center)
//                .background(
//                    Color.black.opacity(0.2)
//                        .blur(radius: 0.2)
//                )
                .onTapGesture(perform: {
                    isPresented = false
                })
                .overlay(
                    VStack {
//                        DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: [.date])
                        
                        Group{
                        switch rangeType {
                        case .open:
                            DatePicker("", selection: $selectedDate, displayedComponents: [.date])

                        case .withstart:
                            DatePicker("", selection: $selectedDate, in: startingDate... , displayedComponents: [.date])
                        case .withend:
                            DatePicker("", selection: $selectedDate, in: ...endingDate, displayedComponents: [.date])

                        case .close:
                            DatePicker("", selection: $selectedDate, in:  startingDate...endingDate , displayedComponents: [.date])

                        }
                        }
                            .datePickerStyle(WheelDatePickerStyle())
                            .background(.white)
                            .cornerRadius(22)
                            .padding(.horizontal)
                        
                        GradientButton(action: {
                                isPresented = false
                        },Title: "Done".localized(language) , IsDisabled:.constant(false)
                        )
                }
                .shadow(color: .black.opacity(0.3), radius: 12)
                          .onChange(of: selectedDate){_ in
      //                        isPresented = false
                      }
                )
            
        }
    }
}
struct calendarPopUp_Previews: PreviewProvider {
    static var previews: some View {
        calendarPopUp(selectedDate: .constant(Date()), isPresented: .constant(true))
    }
}

//struct DateInputView: View {
//    var language = LocalizationService.shared.language
//
//    @State var placeholder  = "Birthdate"
//    @State var iconName  = "CalendarOrange"
//
//    @State var iconColor : Color? = .clear
//
//    @Binding var date: Date?
//    let screenWidth = UIScreen.main.bounds.size.width - 55
//    var body: some View {
//        HStack{
//            Image(iconName)
//                .resizable()
//                .frame(width: 25, height: 25)
////                .foregroundColor(Color("lightGray"))
////            Spacer()
//
//            ZStack (alignment:.leading){
//                Text(placeholder)
//                                                                   .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
//
//                    .foregroundColor(.gray.opacity(0.5))
//                    .offset(y: date == nil ? 0 : -20)
//                    .scaleEffect(date == nil ? 1 : 0.8, anchor: .leading)
//                DatePickerTextField(placeholder: "", date: self.$date)
//            }
//
//            }
//            .frame( height: 30)
//            .font(.system(size: 13))
//            .padding(12)
//            .disableAutocorrection(true)
//            .background(
//                Color.white
//            ).foregroundColor(Color("blueColor"))
//                .cornerRadius(5)
//                .shadow(color: Color.black.opacity(0.099), radius: 3)
//    }
//}
//
//struct DateInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        DateInputView(date: .constant(Date()))
//    }
//}
//
//struct DatePickerTextField: UIViewRepresentable {
//    private let textField = UITextField()
//    private let datePicker = UIDatePicker()
//    private let helper = Helper()
////    private let dateFormatter: DateFormatter = {
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = format.
////        return dateFormatter
////    }()
////    public var format = "yyyy/MM/dd"
//
//    public var placeholder: String
//    public var datePickerMode:UIDatePicker.Mode?
//    public var datePickerStyle:UIDatePickerStyle?
//
//    @Binding public var date: Date?
//
//    func makeUIView(context: Context) -> some UITextField {
//
//        self.datePicker.datePickerMode = datePickerMode ?? .date
//        self.datePicker.preferredDatePickerStyle = datePickerStyle ?? .wheels
//        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
//
//        self.textField.placeholder = self.placeholder
//        self.textField.inputView = self.datePicker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
//        toolbar.setItems([flexibleSpace,doneButton], animated: true)
//        self.textField.inputAccessoryView = toolbar
//
//
//        self.helper.dateChanged =  {
//            self.date = self.datePicker.date
//
//        }
//        self.helper.doneButtonTapped =  {
//            if self.date == nil {
//                self.date = self.datePicker.date
//
//            }
//            self.textField.resignFirstResponder()
//        }
//
//        return self.textField
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//        if let selectedDate = self.date {
//            uiView.text = selectedDate.DateToStr(format: "dd-MM-yyyy")
////            self.dateFormatter.string(from: selectedDate)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Helper {
//        public var dateChanged: (() -> Void)?
//        public var doneButtonTapped: (() -> Void)?
//
//        @objc func dateValueChanged() {
//            self.dateChanged?()
//        }
//
//        @objc func doneButtonAction() {
//            self.doneButtonTapped?()
//        }
//    }
//
//    class Coordinator {
//
//    }
//}


//extension Date {
//        func formatDate() -> String {
//                let dateFormatter = DateFormatter()
//            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy/mm/dd")
//            return dateFormatter.string(from: self)
//        }
//}




/*
The iOS implementation of a UIVisualEffectView's blur and vibrancy.
*/

import SwiftUI

// MARK: - VisualEffectBlur

struct VisualEffectBlur<Content: View>: View {
    var blurStyle: UIBlurEffect.Style
    var vibrancyStyle: UIVibrancyEffectStyle?
    var content: Content
    
    init(blurStyle: UIBlurEffect.Style = .systemMaterial, vibrancyStyle: UIVibrancyEffectStyle? = nil, @ViewBuilder content: () -> Content) {
        self.blurStyle = blurStyle
        self.vibrancyStyle = vibrancyStyle
        self.content = content()
    }
    
    var body: some View {
        Representable(blurStyle: blurStyle, vibrancyStyle: vibrancyStyle, content: ZStack { content })
            .accessibility(hidden: Content.self == EmptyView.self)
    }
}

// MARK: - Representable

extension VisualEffectBlur {
    struct Representable<Content: View>: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        var vibrancyStyle: UIVibrancyEffectStyle?
        var content: Content
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            context.coordinator.blurView
        }
        
        func updateUIView(_ view: UIVisualEffectView, context: Context) {
            context.coordinator.update(content: content, blurStyle: blurStyle, vibrancyStyle: vibrancyStyle)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(content: content)
        }
    }
}

// MARK: - Coordinator

extension VisualEffectBlur.Representable {
    class Coordinator {
        let blurView = UIVisualEffectView()
        let vibrancyView = UIVisualEffectView()
        let hostingController: UIHostingController<Content>
        
        init(content: Content) {
            hostingController = UIHostingController(rootView: content)
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostingController.view.backgroundColor = nil
            blurView.contentView.addSubview(vibrancyView)
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vibrancyView.contentView.addSubview(hostingController.view)
            vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        func update(content: Content, blurStyle: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle?) {
            hostingController.rootView = content
            let blurEffect = UIBlurEffect(style: blurStyle)
            blurView.effect = blurEffect
            if let vibrancyStyle = vibrancyStyle {
                vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
            } else {
                vibrancyView.effect = nil
            }
            hostingController.view.setNeedsDisplay()
        }
    }
}

// MARK: - Content-less Initializer

extension VisualEffectBlur where Content == EmptyView {
    init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.init( blurStyle: blurStyle, vibrancyStyle: nil) {
            EmptyView()
        }
    }
}

// MARK: - Previews

struct VisualEffectBlur_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VisualEffectBlur(blurStyle: .systemUltraThinMaterial, vibrancyStyle: .fill) {
                Text("Hello World!")
                    .frame(width: 200, height: 100)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
