//
//  ModelFirebaseToken.swift
//  Camel Gate
//
//  Created by wecancity on 12/02/2023.
//

import Foundation

// MARK: - ModelFirebaseToken
struct ModelFirebaseToken: Codable {
    var name, mobile, email: String?
    var jobID: Int?
    var nationalID: String?
    var id: Int?
    var roleIDS: [Int]?
    var passwordHash, creationDate: String?

    enum CodingKeys: String, CodingKey {
        case name, mobile, email
        case jobID = "jobId"
        case nationalID = "nationalId"
        case id
        case roleIDS = "roleIds"
        case passwordHash, creationDate
    }
}
