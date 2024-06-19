//
//  Loader.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 17/06/24.
//

import Foundation
import PKHUD

class Loader{
    static func showLoader(){
        HUD.show(.progress)
    }
    
    static func hideLoader(){
        HUD.hide()
    }
}
