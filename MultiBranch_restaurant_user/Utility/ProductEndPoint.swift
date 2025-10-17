//
//  ProductEndPoint.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 15/01/23.
//

import Foundation

enum ProductEndPoint {
    case products // Module - GET
    case addProduct(product: AddProduct) // POST
    case userSignup(userSignup: SignupRequest) //    POST
}

// https://fakestoreapi.com/products
extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "login"
        case .userSignup:
        return "register"
        }
    }

    var baseURL: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://cyan-barracuda-592662.hostingersite.com/api/"
        case .userSignup:
            return "https://cyan-barracuda-592662.hostingersite.com/api/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        case .userSignup:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        case .userSignup(let userSignup):
            return userSignup
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
