//
//  NFFeed.swift
//  Viacom News Feed
//
//  Created by David Engelhardt on 6/10/15.
//  Copyright (c) 2015 David Engelhardt. All rights reserved.
//

import UIKit

class NFFeed: NSObject {
    
    var feedArray = [NFArticle]()
    var newestArticle = Int()
    
    //var feedURL = NSURL(string: "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=20&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss")
    var feedURL = NSURL(string: "http://api.nytimes.com/svc/news/v3/content/all/all/720.json?api-key=0953bf0cf45463dfa2d71832fc6392e3:9:55329474")
    
    func updateFeed(sender: AnyObject) {
        
        var tableVC = sender as! FeedViewController
        
        //let sampleArticle = NFArticle()
        //sampleArticle.articleTitle = "Loading..."
        
        // Get feed via New York Times API
        let task = NSURLSession.sharedSession().dataTaskWithURL(feedURL!) {(data, response, error) in
            
            if (error != nil)
            {
                println(error)
                
                //Notify User
                var alert = UIAlertController(title: "No Internet Connection", message: "Please refresh or try again later.", preferredStyle: UIAlertControllerStyle.Alert)
                var dismissAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(dismissAction)
                tableVC.presentViewController(alert, animated: true, completion: nil)
            }
            else //Convert to JSON
                
            {
                var JSONData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                var results = JSONData.valueForKey("results") as! [NSDictionary]
                
                //Find the out how many new articles there are by finding the index of the JSON results that mathces the newest article in the feed
                if (!self.feedArray.isEmpty)
                {
                    self.newestArticle = find(results, self.feedArray[0].articleData)!
                }
                else
                {
                    self.newestArticle = 20
                }
                
                // only load articles if we have any new ones
                if (/*self.feedArray.isEmpty || */self.newestArticle > 0)
                {
                
                    //for each in results {
                    for index in 0...self.newestArticle - 1 {
                        let article = NFArticle()

                        //article.articleData = each as NSDictionary
                        article.articleData = results[index] as NSDictionary

                        /*
                        article.articleAuthor = each.valueForKey("byline") as! String
                        article.articleTitle = each.valueForKey("title") as! String
                        article.articleText = each.valueForKey("abstract") as! String
                    
                        article.type = each.valueForKey("item_type") as! String
                    
                    
                        var dateNSString = each.valueForKey("created_date") as! NSString
                        let range : NSRange = NSRange(location: 0, length: 5)
                        dateNSString.stringByReplacingCharactersInRange(range, withString: "")
                        let dateString = dateNSString as String
                    
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                        article.articleDate = dateFormatter.dateFromString(dateString)!
                        */
                        
                        //self.feedArray.append(article)
                        
                        self.feedArray.insert(article, atIndex: index)
                        
                        //remove old articles to keep feed to 20
                        if (self.feedArray.count > 20)
                        {
                            self.feedArray.removeLast()
                        }
                    }
                
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        tableVC.feedTable.reloadData()
                        
                        return
                    })
                }
            }
            
        }
        
        task.resume()

        
    }
   
}
