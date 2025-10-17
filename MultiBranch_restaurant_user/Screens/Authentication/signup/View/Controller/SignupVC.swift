//
//  SignupVC.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 12/10/2025.
//

import UIKit

class SignupVC: UIViewController {

    
    @IBOutlet weak var signup_lbl: UILabel!
    @IBOutlet weak var create_acc_lbl: UILabel!
    
    @IBOutlet weak var already_have_acc_lbl: UILabel!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_referral_code: UITextField!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    private let viewModel = SignupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signup(_ sender: Any) {
//        let urlString = API_URL + "register"
//        let params: NSDictionary = ["name":self.txt_FirstName.text!,
//                                    "email":self.txt_Email.text!,
//                                    "mobile":self.CountryCode + self.txt_MobileNumber.text!,
//                                    "token":UserDefaultManager.getStringFromUserDefaults(key: UD_fcmToken),
//                                    "google_id":self.google_Id,"login_type":self.isloginType,"register_type":"email","facebook_id":self.facebook_Id,"referral_code":self.txt_referCode.text!]
        
        
        let request = SignupRequest(name: "ahmad khan", email: "test1@gmail.com", mobile: "07476590461", token: "xyzDeviceToken123", login_type: "email", register_type: "email")
        viewModel.UserSignup(parameters: request)
        
        
        
    }
    
    
    
    @IBAction func country_code_Action(_ sender: Any) {
    }
    @IBAction func check_box(_ sender: Any) {
    }
    @IBAction func accept_terms(_ sender: Any) {
    }
    @IBAction func btn_login(_ sender: Any) {
        
    }
    
}
