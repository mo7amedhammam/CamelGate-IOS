import UIKit

var greeting = "Hello, playground"


//let dat = "2022-08-07T14:01:40"
//let str = ConvertStringDate(inp: dat, FormatFrom: "yyyy-MM-dd'T'hh:mm:ss.SSS", FormatTo: "dd-MM-yyyy")
//
//print(str)


let isoDate = "2022-08-07T14:01:40.958"
let form = "yyyy-MM-dd'T'HH:mm:ss.SSS"


//let dateFormatter = DateFormatter()
//dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//dateFormatter.dateFormat = form
//let date = dateFormatter.date(from:isoDate)!
//
//let calendar = Calendar.current
//let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
//
//let finalDate = calendar.date(from:components)
//
//

func ChangeFormate( NewFormat:String) -> DateFormatter {

    let df = DateFormatter()
    df.dateFormat = NewFormat
    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}
let x = ChangeFormate(NewFormat: form).date(from: isoDate)
let x1 = ChangeFormate(NewFormat: "dd-MM-yyyy").string(from: x ?? Date())

//print(x ?? "")

