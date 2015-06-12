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
    
    var feed = NFFeed()
    
    
    override func viewDidLoad() {
        
        title = "News Feed"
        
        feed.updateFeed(self)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        cell.textLabel?.text = dateFormatter.stringFromDate(feed.feedArray[indexPath.row].articleDate)
        
        let blogImage = UIImage(named: "blog_128.png")
        let newsImage = UIImage(named: "Newspaper_128.png")
        
        // simulate some articles as blog posts, come news articles:
        let coinToss = Int(arc4random_uniform(2))
        if (coinToss == 1)
        {
            cell.imageView?.image = blogImage
        }
        else
        {
            cell.imageView?.image = newsImage

        }
        
        
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
        feedTable.reloadData()
    }
    

}

