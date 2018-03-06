//
//  PhotoMapViewController.swift
//  insta
//
//  Created by Tianyu Liang on 3/3/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let vc = UIImagePickerController()
    
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var imageSelected: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        // photoLibrary()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        photoLibrary()
    }
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("Photo is available 📸")
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        imageSelected.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postPicture(_ sender: Any) {
        // Do something with the images (based on your use case)
        if(imageSelected.image != nil){
            let post = Post()
            post.postUserImage(image: imageSelected.image, withCaption: caption.text) { (success, error) in
                if(success){
                    print("posted")
                }else{
                    print("failed")
                }
            }
        }
        
    }
    @IBAction func onCancel(_ sender: Any) {
        caption.isEditable = false
        caption.isEditable = true
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
