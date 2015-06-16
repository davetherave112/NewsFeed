//
//  NFArticle.swift
//  Viacom News Feed
//
//  Created by David Engelhardt on 6/9/15.
//  Copyright (c) 2015 David Engelhardt. All rights reserved.
//

import UIKit

class NFArticle: NSObject {
    
   internal enum articleType {
        case News, Blog //News by default
    }
    
    var articleTitle = String()
    var articleDate = NSDate()
    var type = String()
    //var type = articleType.News
    var articleAuthor = String()
    var articleText = String()
    var articleThumbnail = UIImage()
    
    
    var articleData = NSDictionary()
    
   
}
