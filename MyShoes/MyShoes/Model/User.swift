//
//  User.swift
//  MyShoes
//
//  Created by 황정덕 on 2020/10/16.
//

import Foundation


// MARK: - User Model
struct User: Codable {
    let pk: Int?
    let phone: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case pk, phone, profileImage
    }
}



class UserData {
    static let shared = UserData()
    var user: User!
    private init() { }
}


// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public var hashValue: Int {
    return 0
  }
  
  public init() {}
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}
