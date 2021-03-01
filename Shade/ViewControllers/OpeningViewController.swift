//
//  OpeningViewController.swift
//  Shade
//
//  Created by Lucas Dahl on 2/27/21.
//

import UIKit

class OpeningViewController: UIViewController {
    
    //===================
    // MARK: Properties
    //===================
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    //===============
    // MARK: Methods
    //===============
    
    func createAlert(userAgree: Bool) {
        
        if (userAgree) {
            let alertVC = UIAlertController(title: Constants.Alert.title, message: Constants.Alert.message,preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "I have read and agree to these terms", style: UIAlertAction.Style.default, handler: { (action) in
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                self.presentVC()
            }))
            alertVC.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: Constants.Alert.title,message: Constants.Alert.message,preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func presentVC() {
        let vc = self.storyboard?.instantiateViewController(identifier: "InsultVC") as! InsultViewControllers
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //==================
    // MARK: IBActions
    //==================
    
    @IBAction func gotToInsults(_ sender: Any) {
        
        // Check if the user has used the app before or not.
        if !launchedBefore  {

            createAlert(userAgree: true)
            
        } else {
            presentVC()
        }

    }
    
    @IBAction func showAgreement(_ sender: Any) {
        createAlert(userAgree: false)
    }
    
}
