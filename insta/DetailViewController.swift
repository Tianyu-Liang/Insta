//
//  DetailViewController.swift
//  insta
//
//  Created by Tianyu Liang on 3/6/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var image: PFImageView!
    
    @IBOutlet weak var caption: UILabel!
    
    var instaPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.file = instaPost["media"] as? PFFile
        self.image.loadInBackground()
        let temp = instaPost["createdDate"]
        if(temp != nil){
            date.text = temp as? String
        }else{
            date.text = "No date available"
        }
        caption.text = instaPost["caption"] as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
