//
//  Post.swift
//  insta
//
//  Created by Tianyu Liang on 3/3/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    @NSManaged var createdDate: String
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        let formatter : DateFormatter = DateFormatter();
        formatter.dateFormat = "d/M/yy";
        let myStr : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date);
        post.createdDate = myStr
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    private func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
