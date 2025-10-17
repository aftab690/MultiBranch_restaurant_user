//
//  SignupRequest.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 14/10/2025.
//

import Foundation
struct SignupRequest : Codable{
    
    var name:String
    var email:String
    var mobile:String
    var token:String
    var google_id:String?
    var facebook_id:String?
    var login_type:String
    var register_type:String
    var referral_code:String?
    
    
}
