//
//  ViewController.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 16/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func btnRegister(_ sender: Any) {
    }
}

