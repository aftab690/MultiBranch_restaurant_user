//
//  LoginViewModel.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 07/10/2025.
//

import Foundation
final class LoginViewModel{
    var loginResponse: LoginResponse?
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    
    func addProduct(parameters: AddProduct){
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: LoginResponse.self, // response type
            type: ProductEndPoint.addProduct(product: parameters)) { result in
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let loginResponse):
                    self.loginResponse = loginResponse
                    print(self.loginResponse)
                    self.eventHandler?(.dataLoaded)
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
