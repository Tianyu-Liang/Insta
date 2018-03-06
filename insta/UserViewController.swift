//
//  UserViewController.swift
//  insta
//
//  Created by Tianyu Liang on 3/3/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse

class UserViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil){
                print("logout failed")
            }else{
                NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
            }
            // PFUser.current() will now be nil
        }
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
