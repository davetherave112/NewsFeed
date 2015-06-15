//
//  WebDetailViewController.swift
//  Viacom News Feed
//
//  Created by David Engelhardt on 6/14/15.
//  Copyright (c) 2015 David Engelhardt. All rights reserved.
//

import UIKit

class WebDetailViewController: UIViewController, UIWebViewDelegate {

    var articleTitle = String()
    var articleAuthor = String()
    var articleText = String()
    var articleDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
