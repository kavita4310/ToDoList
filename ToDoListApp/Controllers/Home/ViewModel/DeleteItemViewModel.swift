//
//  DeleteItemViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class DeleteItemViewModel{
var deleteSuccess: ((Any) -> Void)?
var deleteFailure: ((Error) -> Void)?

    func deleteItem(id:Int){
        ApiManager.shared.deleteUser(id:id , completion: { response in
            switch response {
            case.success(let data):
                self.deleteSuccess?(data)
            case.failure(let error):
                self.deleteFailure?(error)
                
            }
        })
    }
    
}
