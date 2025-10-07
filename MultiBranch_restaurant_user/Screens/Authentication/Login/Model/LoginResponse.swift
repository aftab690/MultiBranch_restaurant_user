//
//  LoginResponse.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 07/10/2025.
//

import Foundation
struct LoginResponse: Codable{
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let name, mobile, email, loginType: String?
    let wallet, isNotification, isMail, referralCode: String?
    let profileImage: String?
}
