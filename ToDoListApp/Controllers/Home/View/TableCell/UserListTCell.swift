//
//  UserListTCell.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 16/06/24.
//

import UIKit

class UserListTCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var lblUserId: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
