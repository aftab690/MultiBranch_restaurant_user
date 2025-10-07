//
//  LoginViewModel.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 07/10/2025.
//

import Foundation
final class LoginViewModel{
    
//    var products: [Product] = []
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    
    func addProduct(parameters: AddProduct){
        APIManager.shared.request(
            modelType: LoginResponse.self, // response type
            type: ProductEndPoint.addProduct(product: parameters)) { result in
                switch result {
                case .success(let product):
                    print(product)
//                    self.eventHandler?(.newProductAdded(product: product))
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

extension LoginViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
