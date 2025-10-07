//
//  ViewController.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 01/10/2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func btn_login(_ sender: UIButton){
        
        let product = AddProduct(email: "aftabkhan@gmail.com", password: "123456")
        viewModel.addProduct(parameters: product)
        
        
//        let response = viewModel.validateLogin(email: emailtxt.text, password: passtxt.text)
//        print(response)
        
//        let urlString = API_URL + "login"
//        let params: NSDictionary = ["email":self.txt_Email.text!,
//                                    "password":self.txt_Password.text!,
//                                    "token":UserDefaultManager.getStringFromUserDefaults(key: UD_fcmToken)]
//        self.Webservice_Login(url: urlString, params: params)
        
        
        
//        let params: NSDictionary = ["email":"aftabkhan@gmail.com",
//                                    "password":"123456",
//                                    "token":"dLEYK8_TLUuyreM4YUnKe7:APA91bECxW5gd4wg0qUIdlxDfbDlFT1DlFUg2Tt7xgHI1Yx2QihJ8LWWvxEpho7lhZwt-3IG4etdKKcyvxOCprHdtZ9824NbwpfDLwT8hAVmJDBiqEBJc-4"]
//    
//            var req = URLRequest(url: try! "https://cyan-barracuda-592662.hostingersite.com/api/login".asURL())
//            req.httpMethod = "POST"
//            req.setValue("application/json", forHTTPHeaderField: "content-type")
//            req.httpBody = try! JSONSerialization.data(withJSONObject: params)
//            req.timeoutInterval = 30
//            AF.request(req).responseJSON { response in
//                print(response.result)
//            }
        
    }
}

