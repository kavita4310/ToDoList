//
//  AddDataViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation

class AddDataViewModel{
var createSuccess: ((CreateUserModel) -> Void)?
var createFailure: ((Error) -> Void)?

    func createData(title:String, id:Int){
        ApiManager.shared.CreateUserApi(todoTitle: title, userId: id, completion: { response in
           
            switch response{
            case.success(let data):
                self.createSuccess?(data)
            case.failure(let error):
                self.createFailure?(error)
               
            }
        })
    }


}
