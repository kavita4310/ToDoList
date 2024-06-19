//
//  LoginViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class LoginViewModel {
    
    var loginSuccess: ((LoginModel) -> Void)?
    var loginFailure: ((Error) -> Void)?

    func login(email: String, password: String) {
        ApiManager.shared.loginApi(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let data):
                self?.loginSuccess?(data)
            case .failure(let error):
                self?.loginFailure?(error)
            }
        }
    }
}
