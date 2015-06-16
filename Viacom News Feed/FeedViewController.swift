//
//  ViewController.swift
//  Viacom News Feed
//
//  Created by David Engelhardt on 6/9/15.
//  Copyright (c) 2015 David Engelhardt. All rights reserved.
//

import UIKit

class FeedViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedTable: UITableView!
    @IBOutlet weak var splashImage: UIImageView!
    
    var feed = NFFeed()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        splashImage.image = UIImage(named: "splash image2.gif")
        
        var splashTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "removeSplash", userInfo: nil, repeats: false)
        

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func removeSplash() {
        
        splashImage.hidden = true
        
        title = "News Feed"
        
        feed.updateFeed(self)
        
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        feedTable.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feed.feedArray.count
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Feed Cell") as! UITableViewCell
        
        //cell.detailTextLabel?.text = feed.feedArray[indexPath.row].articleTitle
        let articleData = feed.feedArray[indexPath.row].articleData
        cell.detailTextLabel?.text = articleData.valueForKey("title") as? String

        
        let inputDateFormatter = NSDateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputDateFormatter = NSDateFormatter()
        outputDateFormatter.dateFormat = "M/d/yyyy"
        
        
        let inputDate = inputDateFormatter.dateFromString(articleData.valueForKey("created_date") as! String)
        let outputDate = outputDateFormatter.stringFromDate(inputDate!) as String
        cell.textLabel?.text = articleData.valueForKey("item_type") as! String + "\n" + outputDate
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        feedTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        dvc.articleData = feed.feedArray[indexPath.row].articleData
        self.navigationController?.pushViewController(dvc, animated: true)

    }
    
    func refresh() {
        feed.updateFeed(self)
        refreshControl.endRefreshing()
        feedTable.reloadData()
    }

}

