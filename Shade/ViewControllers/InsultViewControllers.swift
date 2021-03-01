//
//  InsultViewControllers.swift
//  Shade
//
//  Created by Lucas Dahl on 2/27/21.
//

import UIKit

class InsultViewControllers: UIViewController {
    
    //===================
    // MARK: Properties
    //===================
    
    var insult: String?
    var totalInsults = -1
    var totalShares = -1
    
    // Outlets
    @IBOutlet weak var insultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the first insult
        getInsult()
        
    }
    
    
    //===============
    // MARK: Methods
    //===============
    
    func getInsult() {
        
        // Get the URL
        let url = URL(string: "https://insult.mattbas.org/api/insult")!

        // Get the data and set the variable
        let task = URLSession.shared.dataTask(with: url) { [self](data, response, error) in
            guard let data = data else { return }

            self.insult = String(decoding: data, as: UTF8.self)
            
        }
        
        // Resume the task
        task.resume()
        
        // Set the text label to the insult
        // pulled from URL.
        if let label = insult {
            insultLabel.text = label
        }
    
    }
    
    func shareInsult() {
        
        // Set the sharing insult
        var insultToShare = ""
        
        // Make sure insult is not nil
        if(insult != nil) {
            insultToShare = insult ?? "Error getting insult"
        }
        
        // Make the activity contorller
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [insultToShare], applicationActivities: nil)
        
        //Ipad popup
        activityViewController.popoverPresentationController?.sourceView = (self.view)
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        // Present
        activityViewController.isModalInPresentation = false
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //==================
    // MARK: IBActions
    //==================
    
    @IBAction func newInsult(_ sender: Any) {
        getInsult()
        
        // Check if the user should be shown an ad
        // on the first and 10th insult
        if(totalInsults == -1) {
            // Show ad
            getInsult()
            totalInsults += 1
        } else if (totalInsults == 10) {
            // Show ad
            totalInsults = 0
            getInsult()
        } else {
            getInsult()
            totalInsults += 1
        }
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        shareInsult()
        // Check if the user should be shown an ad
        // on the first and 5th share request
        if(totalShares == -1) {
            // show ad
            totalShares += 1
            shareInsult()
        } else if(totalShares == 5) {
            // Show add
            totalShares = 0
            shareInsult()
        } else {
            totalShares += 1
            shareInsult()
        }
    }
    
}
