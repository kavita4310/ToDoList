//
//  HomeVC.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 16/06/24.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let deleteModel = DeleteItemViewModel()
    var updateModel = UpdateDataViewModel()
    let getlistModel = ItemListViewModel()
    let AddItemModel = AddDataViewModel()
    
    var userList:[Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: "UserListTCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserListTCell")
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        
         getApiList()
    }
    //MARK: List Api
    func getApiList(){
        DispatchQueue.main.async {
            Loader.showLoader()
        }
        getlistModel.getItemList()
        getlistModel.GetDataSuccess = { data in
            Loader.hideLoader()
            print(data.todos)
            let list = data.todos
            // Add Inside Database when Database will nill
            self.userList = DatabaseHelper.shared.getAddData()
            if self.userList.count <= 1 {
                DatabaseHelper.shared.saveApiListData(list: list)
                self.userList = list
            }
            
            self.tableView.reloadData()
        }
        
        getlistModel.FetDataFailure = { error in
            Loader.hideLoader()
           print(error)
        }
        
    }
    
    @IBAction func addNewCell(_ sender: Any) {

    userListContifguration(isAdd: true, index: 0)
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: List Api
    func userListContifguration(isAdd:Bool, index:Int){
        let alertController = UIAlertController(title: isAdd ? "Add ":"Update" , message: isAdd ? "Add new Data":"Update selected Data" , preferredStyle: .alert)
        
        let save = UIAlertAction(title: "save", style: .default) { _ in
            if let title = alertController.textFields?.first?.text, let id = alertController.textFields?.last?.text{
              
                if isAdd{
                    DispatchQueue.main.async {
                        Loader.showLoader()
                    }
                    self.AddItemModel.createData(title: title, id: Int(id) ?? 0)
                    
                    self.AddItemModel.createSuccess = { data in
                        Loader.hideLoader()
                        let newData = Todo()
                        newData.todo = data.todo
                        newData.userId = data.userId
                        newData.completed = data.completed
                        newData.id = data.id
                  DatabaseHelper.shared.addNewListData(list: newData)
                        self.getApiList()

                    }
                    self.AddItemModel.createFailure = { error in
                        Loader.hideLoader()
                        print(error)
                    }
                    
                }else{
                    
                    let newData = Todo()
                     newData.todo = title
                     newData.userId = self.userList[index].userId
                     newData.id = self.userList[index].id
                    DispatchQueue.main.async {
                        Loader.showLoader()
                    }
                    self.updateModel.update(userId: self.userList[index].id)
                    ApiManager.shared.updateApi(id: self.userList[index].id, completion: { response in
                        Loader.hideLoader()
                        switch response{
                        case.success(let data):
                            print(data)
                            
                    let oldData = self.userList[index]
        DatabaseHelper.shared.updateData(oldData: oldData, newData: newData, index: index)
                self.tableView.reloadData()
                    case .failure(let error):
                            print(error)
                            
                           
                        }
                    })
                }
            }
        }
        
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { titleFields in
            titleFields.placeholder =  isAdd ? "Enter Title":self.userList[index].todo
        }
        
        alertController.addTextField { txtCompeled in
            txtCompeled.keyboardType = .numberPad
            txtCompeled.placeholder = isAdd ? "Enter ID": String(self.userList[index].userId)
            if !isAdd{
                txtCompeled.text = String(self.userList[index].userId)
                txtCompeled.isUserInteractionEnabled = false
            }else{
                txtCompeled.isUserInteractionEnabled = true
            }
            
        }
        
       
        alertController.addAction(save)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    
}
//MARK: Delegate and Datasource

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTCell", for: indexPath) as! UserListTCell
        cell.lblTitle.text = "Title: " + userList[indexPath.row].todo
        cell.lblId.text = "Id: " + String(userList[indexPath.row].id)
        cell.lblUserId.text = "UserId: " + String(userList[indexPath.row].userId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "edit") { _, _, _ in
            
            self.userListContifguration(isAdd: false, index: indexPath.row)

        }
        
        edit.backgroundColor = .systemMint
        
        let cancel = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
           
            let id = self.userList[indexPath.row].id
            DispatchQueue.main.async {
                Loader.showLoader()
            }
            self.deleteModel.deleteItem(id: id)
            self.deleteModel.deleteSuccess = { data in
                Loader.hideLoader()
                if let todoToDelete = DatabaseHelper.shared.getTodoById(id: id) {
                    DatabaseHelper.shared.deleteToDo(todo: todoToDelete)
                    self.userList.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    
                }
            }
            self.deleteModel.deleteFailure = { error in
                Loader.hideLoader()
               print(error)
                
            }
                                       
          }
                                         
        let swiftconfiguration = UISwipeActionsConfiguration(actions: [cancel, edit])
        return swiftconfiguration
        }
    }
