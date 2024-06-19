//
//  LoginVC.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 16/06/24.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!

    @IBOutlet weak var txtPassword: UITextField!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.setLeftPadding(15)
        txtPassword.setLeftPadding(15)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        Loader.showLoader()
        viewModel.login(email: txtName.text ?? "", password: txtPassword.text ?? "")
        
        viewModel.loginSuccess = { [weak self] data in
                   Loader.hideLoader()
                   print(data)
                   let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                   self?.navigationController?.pushViewController(vc, animated: true)
               }

               viewModel.loginFailure = { error in
                   Loader.hideLoader()
                   print(error)
               }
  
    }
    
    
//   private func loginApi(){
//       DispatchQueue.main.async {
//           Loader.showLoader()
//       }
//       ApiManager.shared.loginApi(email: txtName.text ?? "", password: txtPassword.text ?? "", completion: { response in
//           Loader.hideLoader()
//           switch response {
//               
//           case.success(let data):
//               print(data)
//               let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//               self.navigationController?.pushViewController(vc, animated: true)
//               
//           case.failure(let error):
//               print(error)
//              
//              
//           }
//           
//           
//       })
//    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
   
    @IBAction func btnGoogle(_ sender: Any) {
        
        if let url = URL(string: "https://www.google.com/") {
            if UIApplication.shared.canOpenURL(url) {
                // Open the URL
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
    }
    
    @IBAction func btnFacebook(_ sender: Any) {
        
        if let url = URL(string: "https://www.facebook.com/") {
            if UIApplication.shared.canOpenURL(url) {
                // Open the URL
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
    }
    
  

}
