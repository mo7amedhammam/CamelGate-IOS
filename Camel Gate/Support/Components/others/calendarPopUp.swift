//
//  calendarPopUp.swift
//  Camel Gate
//
//  Created by wecancity on 04/08/2022.
//

import SwiftUI
import Combine

struct calendarPopUp:View{
    @Binding var selectedDate : Date
    @Binding var isPresented : Bool

    var body: some View{
        if isPresented{
            ZStack {
                ZStack {
                    DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date )
                        .datePickerStyle(.graphical)
                        .background(.white)
                        .cornerRadius(22)
                        .padding()
                
            }
            .shadow(color: .black.opacity(0.3), radius: 12)
                    .onChange(of: selectedDate){_ in
                        isPresented = false
                }
            }.frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height, alignment: .center)
                .background(
                    Color.black.opacity(0.2)
                    .blur(radius: 12)

                )
                .onTapGesture(perform: {
                    isPresented = false
                })
        }
           

    }
}
struct calendarPopUp_Previews: PreviewProvider {
    static var previews: some View {
        calendarPopUp(selectedDate: .constant(Date()), isPresented: .constant(true))
        
    }
}





struct DateInputView: View {
    var language = LocalizationService.shared.language
    
    @State var placeholder  = "Birthdate"
    @State var iconName  = "CalendarOrange"

    @State var iconColor : Color? = .clear

    
    @Binding var date: Date?
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        HStack{
            Image(iconName)
                .resizable()
                .frame(width: 25, height: 25)
//                .foregroundColor(Color("lightGray"))
//            Spacer()

            ZStack (alignment:.leading){
                Text(placeholder)
                    .font(Font.camelfonts.Reg14)
                    .foregroundColor(.gray.opacity(0.5))
                    .offset(y: date == nil ? 0 : -20)
                    .scaleEffect(date == nil ? 1 : 0.8, anchor: .leading)
                DatePickerTextField(placeholder: "", date: self.$date)
            }

            }
            .frame( height: 30)
            .font(.system(size: 13))
            .padding(12)
            .disableAutocorrection(true)
            .background(
                Color.white
            ).foregroundColor(Color("blueColor"))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
    }
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateInputView(date: .constant(Date()))
    }
}





struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding public var date: Date?
//    @ObservedObject var docvm = ViewModelCreatePatientProfile()
    
//    var datef:DateFormatter{
//        let df = DateFormatter()
//        df.dateFormat = "yyyy/mm/dd"
//        return df
//    }
    
    func makeUIView(context: Context) -> some UITextField {
        
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace,doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        
        self.helper.dateChanged =  {
            self.date = self.datePicker.date
//            self.docvm.Birthday = self.datePicker.date
//            self.docvm.Birthday = datef.string(from: datePicker.date)

        }
        self.helper.doneButtonTapped =  {
            if self.date == nil {
                self.date = self.datePicker.date
//                self.docvm.Birthday = self.datePicker.date
//                self.docvm.Birthday = datef.string(from: datePicker.date)

//                self.docvm.Birthday = datef.string(from: date ?? Date())
                
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}


extension Date {
        func formatDate() -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy/mm/dd")
            return dateFormatter.string(from: self)
        }
}

