//
//  SignupResponse.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 14/10/2025.
//

import Foundation

struct SignupResponse: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
    let otp: Int?
}
