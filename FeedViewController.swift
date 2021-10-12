//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Maheen Naqvi on 10/11/21.
//

import UIKit
import Parse
import Alamofire

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var posts = [PFObject] ()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey ("author")
        query.limit = 20
        
        query.findObjectsInBackground {(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
            
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
            as! PostCell
            
            let post = posts[indexPath.row]
            let user = post ["author"] as! PFUser
            cell.userNameLabel.text = user.username
            
            cell.captionLabel.text = post["caption"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url
            let url = URL(string: urlString!)
            cell.photoView.af_setImage(withURL: url!)
            return cell
    }
    
    }