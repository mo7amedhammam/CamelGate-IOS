//
//  BGNetworkHelper.swift
//  Camel Gate
//
//  Created by Tawfiq Sweedy on 02/08/2022.
//

import Foundation
import Moya
import SystemConfiguration

struct BGNetworkHelper {

    // MARK: - print response
    fileprivate static func printResponse(_ response: Response) {
        // print request data
        print("URL:")
        print(response.request?.urlRequest ?? "")
        print("Header:")
        print((response.request?.headers ?? nil) as Any)
        print("STATUS:")
        print(response.statusCode)
        print("Response:")
        if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) {
            print(json)
        } else {
            let response = String(data: response.data, encoding: .utf8)!
            print(response)
        }
    }
    // MARK: - validate all APIs responses
    static func validateResponse (response:Response) ->Bool {
        printResponse(response)
        guard response.statusCode == Constants.success else{
            if response.statusCode == 401 {
//                BGLoginManger.logout()
            }
            return false
        }
        let decoder = JSONDecoder()
        do {
            let responseModel = try decoder.decode(ResponseModel.self, from: response.data)
          switch responseModel.status {
            case Constants.success? :
                return true
            case Constants.added? , Constants.created?:



// Show Alert ya Hammam 3la 7asab el Error Status




//            BGAlertPresenter.displayToast(title: "",message: responseModel.message ?? "", type: .success)
                return true
            case Constants.unprocessableEntity?:
//                BGAlertPresenter.displayToast(title: "",message: responseModel.message ?? "", type: .error)
                return false
            case Constants.notFound?:
//                BGAlertPresenter.displayToast(title: "",message: responseModel.message ?? "", type: .error)
                return false
            case Constants.unauthenticated?:
//                BGAlertPresenter.displayToast(title: "",message: responseModel.message ?? "", type: .error)
                return false
            case Constants.notActive?:
//                BGAlertPresenter.displayToast(title: "",message: responseModel.message ?? "", type: .error)
                return  true
            default:
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
