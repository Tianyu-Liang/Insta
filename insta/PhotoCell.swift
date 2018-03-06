//
//  PhotoCell.swift
//  insta
//
//  Created by Tianyu Liang on 3/4/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    @IBOutlet weak var picture: PFImageView!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
    var date : String!
    
    var instaPost: PFObject! {
        didSet{
        
            self.picture.file = instaPost["media"] as? PFFile
            self.picture.loadInBackground()
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
