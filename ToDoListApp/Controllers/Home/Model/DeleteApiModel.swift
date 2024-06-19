//
//  DeleteApiModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class DeleteUserModel: Codable{
    let id :Int
    let todo: String
    let completed:Bool
    let userId:Int
    let isDeleted:Bool
    let deletedOn:String
    
    init(id: Int, todo: String, completed: Bool, userId: Int, isDeleted: Bool, deletedOn: String) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
        self.isDeleted = isDeleted
        self.deletedOn = deletedOn
    }
    
}
