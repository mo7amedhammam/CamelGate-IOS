//
//  ChangePasswordModel.swift
//  Camel Gate
//
//  Created by wecancity on 20/08/2022.
//


// MARK: - ChangePasswordModel
struct ChangePasswordModel: Codable {
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
