//
//  RemoveAccountModel.swift
//  Camel Gate
//
//  Created by wecancity on 15/01/2023.
//

// MARK: - RemoveAccountModel
struct RemoveAccountModel: Codable {
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
