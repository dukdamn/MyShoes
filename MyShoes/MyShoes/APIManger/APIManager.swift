//
//  APIManager.swift
//  MyShoes
//
//  Created by 황정덕 on 2020/10/16.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import RxSwift



enum LoginWays {
    case local
    case apple
    case kakao
    case facebook
}

enum Key {
    static let keyChain = "keyChain"
}

final class APIManager {
    
    // MARK: - Properties
    static let shared = APIManager()
    private let keyChain = KeychainSwift(keyPrefix: "DabangCloneUser_")
    var userPk = 0
    private let networkAccessManager = NetworkReachabilityManager(host: "http://dabang-loadbalancer-779366673.ap-northeast-2.elb.amazonaws.com")
    private let baseURL = "http://dabang-loadbalancer-779366673.ap-northeast-2.elb.amazonaws.com"
    
    var loginWay: LoginWays?
    
    private init() { monitorNetworkAccessStatus() }
    
    
    // MARK: - [ Monitoring Celluar Network Access Status ]
    private func monitorNetworkAccessStatus() {
        networkAccessManager?.startListening(onQueue: .init(label: "networkQueue"), onUpdatePerforming: { (status) in
            print("Network Status has been changed: \(status)")
        })
    }
    
    
    // MARK: - [ Manage JWT ]
    func getAccessTokenFromKeyChain() -> String {
//        let accessToken = keyChain.get(Key.keyChain) ?? ""
        let tempToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNTk3OTg5NDQ5LCJlbWFpbCI6ImFkbWluQGdvb2dsZS5jb20ifQ.Hf77-m54rUIIC_Om6fHMRsU6XLsBL8izOFf0W_tojYM"
        return tempToken
    }
    
    func setAccessTokenIntoKeyChain(token: String, key: String) -> Bool {
        return keyChain.set(token, forKey: key, withAccess: .accessibleWhenUnlocked)
    }
    
    func checkJWTExpiration() {
        let jwt = getAccessTokenFromKeyChain()
        var payloadString = jwt.components(separatedBy: ".")[1]
        while payloadString.count % 4 != 0 {
            payloadString += "="
        }

        let payloadData = Data(base64Encoded: payloadString, options: .ignoreUnknownCharacters)!

        guard let json = try? JSONSerialization.jsonObject(with: payloadData) as? [String:Any] else { return }
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        if expDate <= Date() {
//            refreshJWT()
        }
    }
    
    func logout() -> Bool {
      return keyChain.clear()
    }
    
    // MARK: - [ API CRUD ]
    // MARK: - GET
    
    
    
    //GET: 유저 정보
    func getUserProfile(userPK: Int? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        let header: HTTPHeaders = [.authorization(bearerToken: getAccessTokenFromKeyChain())]
        AF.request( baseURL + "/members/\(String(describing: userPK))/", headers: header)
            .responseDecodable(of: User.self) { (response) in
                switch response.result {
                case .success(let user):
                    print("success")
                    completion(.success(user))
                case .failure(let error):
                    print("fail222")
                    completion(.failure(error))
                }
        }
    }
}
