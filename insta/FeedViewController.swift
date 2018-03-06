//
//  FeedViewController.swift
//  insta
//
//  Created by Tianyu Liang on 3/3/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse


class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        let user = post["author"] as? PFUser
        // author name
        cell.author.text = user!["username"] as? String
        // caption
        cell.caption.text = post["caption"] as? String
        // likes
        let likes = post["likesCount"] as! Int
        cell.likeCount.text = "likes: \(likes)"
        // comments
        let comments = post["commentsCount"] as! Int
        cell.commentCount.text = "comments :\(comments)"
        // picture
        cell.instaPost = post
        // date
        cell.date = post["createdDate"] as? String
        if(cell.date == nil){
            cell.date = "No date available"
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 450
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0);
        fetchPosts()
        
        
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        // construct PFQuery
        let query = Post.query()!
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                // do something with the data fetched
                self.posts = posts!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing();
            } else {
                // handle error
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! PhotoCell
        let detailViewController = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPath(for: cell)
        {
            detailViewController.instaPost = posts[indexPath.row]
        }
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
