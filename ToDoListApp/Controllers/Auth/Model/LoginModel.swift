//
//  LoginModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation


//MARK: Models
struct LoginModel: Decodable {
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let token, refreshToken: String
    
    init(id: Int, username: String, email: String, firstName: String, lastName: String, gender: String, image: String, token: String, refreshToken: String) {
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.image = image
        self.token = token
        self.refreshToken = refreshToken
    }
}
