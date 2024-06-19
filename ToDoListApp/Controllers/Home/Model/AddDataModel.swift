//
//  AddDataModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class CreateUserModel: Codable{
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    
    init(id: Int, todo: String, completed: Bool, userId: Int) {
     
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}


