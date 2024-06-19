//
//  ItemListViewModel.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation
class ItemListViewModel {
    
    var GetDataSuccess: ((UserListModel) -> Void)?
    var FetDataFailure: ((Error) -> Void)?
    
    func getItemList(){
        ApiManager.shared.getCategoriesApi(competion: { response in
            switch response {
            case.success(let data):
                self.GetDataSuccess?(data)
            case.failure(let error):
                self.FetDataFailure?(error)
                
            }
        })

    }
    
}
