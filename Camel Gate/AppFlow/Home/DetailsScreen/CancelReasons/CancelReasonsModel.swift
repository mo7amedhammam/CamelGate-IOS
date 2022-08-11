//
//  CancelReasonsModel.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
// MARK: - CancelReasonsModel
struct CancelReasonsModel: Codable , Hashable, Identifiable{
    var title, titleAr: String?
    var order, id: Int?
}
