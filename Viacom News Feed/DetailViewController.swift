//
//  DetailViewController.swift
//  Viacom News Feed
//
//  Created by David Engelhardt on 6/11/15.
//  Copyright (c) 2015 David Engelhardt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    /*
    var articleTitle = String()
    var articleAuthor = String()
    var articleText = String()
    var articleDate = NSDate()
    */
    var articleData = NSDictionary()

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        titleLabel.text = articleTitle
        authorLabel.text = articleAuthor
        textView.text = articleText
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateLabel.text = dateFormatter.stringFromDate(articleDate)
        */
        
        titleLabel.text = articleData.valueForKey("title") as? String
        authorLabel.text = articleData.valueForKey("byline") as? String
        textView.text = articleData.valueForKey("abstract") as? String
        
        
        let inputDateFormatter = NSDateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputDateFormatter = NSDateFormatter()
        outputDateFormatter.dateFormat = "MMM d, yyyy"
        
        let inputDate = inputDateFormatter.dateFromString(articleData.valueForKey("created_date") as! String)
        let outputDate = outputDateFormatter.stringFromDate(inputDate!) as String
        
        dateLabel.text = outputDate

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
