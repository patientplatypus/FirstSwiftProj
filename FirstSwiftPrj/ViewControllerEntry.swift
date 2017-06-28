//
//  ViewControllerEntry.swift
//  FirstSwiftPrj
//
//  Created by Peter Weyand on 6/28/17.
//  Copyright © 2017 Peter Weyand. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import ReSwift

class ViewControllerEntry: UIViewController, UITextFieldDelegate {
    
    var loginArray: [String] = ["Peter", "Peter Weyand", "Weyand", "platypus", "patientplatypus"]
    
    @IBOutlet weak var SplashLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    
    
    @IBAction func NameTextEdit(_ sender: UITextField) {
        NameLabel.text = NameText.text
        mainStore.dispatch(LoginNameAction(payload: NameText.text!));
        
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        for i in 0..<loginArray.count {
            if loginArray[i]==NameLabel.text{
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBarVC
                
            }
        }
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalLoginFail") as? ModalLoginFail
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameText.returnKeyType = UIReturnKeyType.done
        NameText.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.SplashLabel.center.y  -= view.bounds.height
        self.NameLabel.center.y += view.bounds.height
        self.NameText.center.y += view.bounds.height
        self.LoginButtonOutlet.alpha = 0
        self.LoginButtonOutlet.backgroundColor = UIColor.orange
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.SplashLabel.center.y += self.view.bounds.height
        }
        UIView.animate(withDuration: 1.5, delay: 0.7, options: [],
                       animations: {
                        self.NameLabel.center.y -= self.view.bounds.height
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 1.5, delay: 1.4, options: [],
                       animations: {
                        self.NameText.center.y -= self.view.bounds.height
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 1.0, delay: 2.7, options: [],
                       animations: {
                        self.LoginButtonOutlet.alpha = 1.0
        },
                       completion: nil
        )
    }
    
}
