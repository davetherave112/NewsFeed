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
    
    var feedURL = NSURL(string: "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=20&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss")
    
    func updateFeed(sender: AnyObject) {
        
        let sampleArticle = NFArticle()
        sampleArticle.articleTitle = "Loading..."
        
        // Get feed via Google News API
        let task = NSURLSession.sharedSession().dataTaskWithURL(feedURL!) {(data, response, error) in
            
            if (error != nil)
            {
                println(error)
            }
            else //Convert to JSON
                
            {
                var JSONData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                var responseData = JSONData.valueForKey("responseData") as! NSDictionary
                var feed = responseData.valueForKey("feed") as! NSDictionary
                var entries = feed.valueForKey("entries") as! NSArray

                //var article = NFArticle()

                for each in entries {
                    let article = NFArticle()

                    article.articleAuthor = each.valueForKey("author") as! String
                    article.articleTitle = each.valueForKey("title") as! String
                    article.articleText = each.valueForKey("contentSnippet") as! String
                    
                    
                    var dateNSString = each.valueForKey("publishedDate") as! NSString
                    let range : NSRange = NSRange(location: 0, length: 5)
                    dateNSString.stringByReplacingCharactersInRange(range, withString: "")
                    let dateString = dateNSString as String
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "ccc, dd MMM yyyy HH:mm:ss Z"
                    article.articleDate = dateFormatter.dateFromString(dateString)!
                    
                    self.feedArray.append(article)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    var tablevc = sender as! FeedViewController
                    tablevc.feedTable.reloadData()
                    
                    return
                })
            }
            
        }
        
        task.resume()

        
    }
   
}
