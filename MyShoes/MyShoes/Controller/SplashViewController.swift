//
//  SplashViewController.swift
//  MyShoes
//
//  Created by 황정덕 on 2020/10/16.
//

import UIKit
import SwiftyGif
import RealmSwift
import Alamofire
import SwiftyJSON

class SplashViewController: UIViewController {

    @IBOutlet weak var imgSplash: UIImageView!
    
    let defaults = UserDefaults.standard
    lazy var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }
    
    @objc func splashTimeOut(sender : Timer){
        //Check View Guide
        let mainStory:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RootView = mainStory.instantiateViewController(identifier: "LoginView") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = RootView
        if defaults.bool(forKey: "viewGuide") {
            //Move Home
            if defaults.bool(forKey: "autoLogin") {
//                APIClient.getMemberCnt(user?.userid ?? "") { response in
//                    let item = response["data"]
//                    print(item)
//                    if response["code"] == "200" {
//
//                        try! self.realm.write {
//                            user!.partner = "\(item["partner"])"
//                            print("realm partner upudate")
//                        }
//                        
//                        if #available(iOS 13.0, *) {
//                            let RootView = mainStory.instantiateViewController(identifier: "HomeView") as! UITabBarController
//                            UIApplication.shared.keyWindow?.rootViewController = RootView
//                        } else {
//                            // Fallback on earlier versions
//                            let RootView = mainStory.instantiateViewController(withIdentifier: "HomeView") as! UITabBarController
//                            UIApplication.shared.keyWindow?.rootViewController = RootView
//                        }
//                    }else{
//                        self.toastMessage("탈퇴한 회원이거나 가입되지 않은 아이디입니다.")
//                        if #available(iOS 13.0, *) {
//                            let RootView = mainStory.instantiateViewController(identifier: "LoginView") as! UINavigationController
//                            UIApplication.shared.keyWindow?.rootViewController = RootView
//                        } else {
//                            // Fallback on earlier versions
//                            let RootView = mainStory.instantiateViewController(withIdentifier: "LoginView") as! UINavigationController
//                            UIApplication.shared.keyWindow?.rootViewController = RootView
//                        }
//                    }
//                }
            }else{
                if #available(iOS 13.0, *) {
                    let RootView = mainStory.instantiateViewController(identifier: "LoginView") as! UINavigationController
                    UIApplication.shared.keyWindow?.rootViewController = RootView
                } else {
                    // Fallback on earlier versions
                    let RootView = mainStory.instantiateViewController(withIdentifier: "LoginView") as! UINavigationController
                    UIApplication.shared.keyWindow?.rootViewController = RootView
                }
            }
        }else{
//            if #available(iOS 13.0, *) {
//                let RootView = mainStory.instantiateViewController(identifier: "GuideView")
//                UIApplication.shared.keyWindow?.rootViewController = RootView
//            } else {
//                // Fallback on earlier versions
//                let RootView = mainStory.instantiateViewController(withIdentifier: "GuideView")
//                UIApplication.shared.keyWindow?.rootViewController = RootView
//            }
        }
    }


}
