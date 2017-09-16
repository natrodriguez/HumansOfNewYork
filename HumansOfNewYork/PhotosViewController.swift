//
//  ViewController.swift
//  Tumblr
//
//  Created by Natalia Rodriguez on 9/15/17.
//  Copyright © 2017 Natalia Rodriguez. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [NSDictionary] = []
    
    @IBOutlet weak var photosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        let ph = self.posts[0]["photos"] as! [NSDictionary]
                        print(ph)
                        //                        print(type(of: ph))
                        //                        print(self.posts)
                        let firstPhoto = ph.first! as! NSDictionary
                        print(firstPhoto)
                        let altSizes = firstPhoto["alt_sizes"] as! [NSDictionary]
                        print(altSizes[0])
                    }
                    self.photosTable.reloadData()
                }
        });
        task.resume()
        
        photosTable.delegate = self
        photosTable.dataSource = self
        photosTable.rowHeight = 260
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTable.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCellTableViewCell
        
        if posts.count > 0 {
            let post = posts[indexPath.row]
        
            // get photos for each post
            if let photos = post.value(forKey: "photos") as? [NSDictionary]{
                let imageInfo = photos[0].value(forKey: "original_size") as! NSDictionary
                
                let imageUrl = URL(string: imageInfo["url"] as! String)!
                
                let imageData = try! NSData(contentsOf: imageUrl, options: NSData.ReadingOptions.uncachedRead)
                cell.photo.image = UIImage(data: imageData as Data)
            } else {
            }
        }
        
        return cell
    }
    
}

