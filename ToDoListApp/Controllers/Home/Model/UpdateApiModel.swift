//
//  UpdateApiModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation


class UpdateListModel: Codable{
    let id: String
    let todo:String
    let completed:Bool
    let userId:Int
    
    init(id: String, todo: String, completed: Bool, userId: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}
