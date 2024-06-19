//
//  ListModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation
import RealmSwift


// MARK: - UserListModel
struct UserListModel: Codable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - Todo
class Todo: Object, Codable {
    @Persisted var id: Int
    @Persisted var todo: String
    @Persisted var completed: Bool
    @Persisted var userId: Int

    convenience init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.init()
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}
