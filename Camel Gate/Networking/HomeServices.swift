//
//  HomeServices.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/6/22.
//

import Foundation
import Moya

enum HomeServices {
    
    case Home
    
    
}
extension HomeServices : URLRequestBuilder {
    var path: String {
        switch self {
        case .Home:
            return EndPoints.Login.rawValue
       
            
        }
    }
    var method: Moya.Method {
        switch self {
//        case  .Login , .createAccount , .UpdateDriverInfo :
//            return .post
        case .Home :
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .Home:
            return .requestPlain
    
        }
    }
}

