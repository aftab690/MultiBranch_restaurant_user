//
//  SignupViewModel.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 12/10/2025.
//

import Foundation
final class SignupViewModel {
    
    //    var products: [Product] = []
        var eventHandler: ((_ event: Event) -> Void)?
    
        
        
    func UserSignup(parameters: SignupRequest){
            APIManager.shared.request(
                modelType: SignupResponse.self, // response type
                type: ProductEndPoint.userSignup(userSignup: parameters)) { result in
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

extension SignupViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
