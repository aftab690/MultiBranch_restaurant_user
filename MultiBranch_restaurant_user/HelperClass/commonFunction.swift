//
//  commonFunction.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 09/10/2025.
//

import Foundation
import UIKit

let key_Type = "Type"
let key_facebook = "key_facebook"



var keyWindow = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .compactMap({$0 as? UIWindowScene})
    .first?.windows
    .filter({$0.isKeyWindow}).first


func showAlertMessage(titleStr:String, messageStr:String) -> Void {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
}

extension Bundle {
    var displayName : String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    var releseVersionNumber : String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber : String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

func isValidateEmail(email:String) -> Bool {
    let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegx)
    let result = emailTest.evaluate(with: email)
    return result
}
