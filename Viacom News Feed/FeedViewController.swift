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
        
        cell.detailTextLabel?.text = feed.feedArray[indexPath.row].articleTitle
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        
        var combo = feed.feedArray[indexPath.row].type  + "\n" + dateFormatter.stringFromDate(feed.feedArray[indexPath.row].articleDate)

        cell.textLabel?.text = combo
        
        /*
        let blogImage = UIImage(named: "blog_128.png")
        let newsImage = UIImage(named: "Newspaper_128.png")
        
        if (feed.feedArray[indexPath.row].type == "News")
        {
            cell.imageView?.image = newsImage
        }
        else
        {
            cell.imageView?.image = blogImage
        }
        */
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        feedTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        var dvc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        dvc.articleTitle = feed.feedArray[indexPath.row].articleTitle
        dvc.articleAuthor = feed.feedArray[indexPath.row].articleAuthor
        dvc.articleText = feed.feedArray[indexPath.row].articleText
        dvc.articleDate = feed.feedArray[indexPath.row].articleDate
        self.navigationController?.pushViewController(dvc, animated: true)

    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "Article Selected")
        {
            let indexPath = feedTable.indexPathForSelectedRow()
            var dvc = segue.destinationViewController as! DetailViewController
            dvc.articleTitle = feed.feedArray[indexPath!.row].articleTitle
            dvc.articleAuthor = feed.feedArray[indexPath!.row].articleAuthor
            dvc.articleText = feed.feedArray[indexPath!.row].articleText
            dvc.articleDate = feed.feedArray[indexPath!.row].articleDate

        }
    
    }
    */
    func refresh() {
        feed = NFFeed()
        feed.updateFeed(self)
        refreshControl.endRefreshing()
        feedTable.reloadData()
    }

}

