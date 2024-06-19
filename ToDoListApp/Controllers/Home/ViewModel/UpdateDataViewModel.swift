//
//  UpdateDataViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class UpdateDataViewModel{
var updateSuccess: ((Any) -> Void)?
var updateFailure: ((Error) -> Void)?

    func update(userId: Int){
        ApiManager.shared.updateApi( id: userId, completion: { response in
            switch response{
            case.success(let data):
                self.updateSuccess?(data)
            case.failure(let error):
                self.updateFailure?(error)
               
            }
        })
    }

}
