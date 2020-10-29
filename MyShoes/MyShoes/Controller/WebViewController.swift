//
//  WebViewController.swift
//  MyShoes
//
//  Created by 황정덕 on 2020/10/26.
//

import UIKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let vc = self.presentingViewController else { return }
                                self.dismiss(animated: true, completion: nil)
                                if let vc3 = vc.children[vc.children.count - 3] as? WebViewController {
                                    vc3.navigationController?.popViewController(animated: false)
                                } else {
                                    let vc3 = vc.children[vc.children.count - 3] as? WebViewController
                                    print("🌝 … \(String(describing: vc3))")
                                    print("🌝 … \(vc.children[vc.children.count - 1])")
                                    print("🌝 … \(type(of: vc.children[1]))")
                                }
    }
    

}
