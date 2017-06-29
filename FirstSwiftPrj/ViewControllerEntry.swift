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
    
    var dummy = ViewController6.self;
    var loginArray: [String] = ["Peter", "Peter Weyand", "Weyand", "platypus", "patientplatypus"]
    
    @IBOutlet weak var SplashLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBAction func SignUpAction(_ sender: Any) {
//        res.json({"cantsignup":"someonehasthatname"});
        
        let urlString = "http://localhost:3000/signup"
        
        Alamofire.request(urlString, method: .post,
                          parameters:
            [
                "username"      : self.NameText.text!,
                "password"      : self.passwordOutlet.text!,
            ],
                          encoding: JSONEncoding.default, headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                let json = JSON(response.data!)
                                if (json["cantsignup"]=="someonehasthatname"){
                                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalLoginFail") as? ModalLoginFail
                                    {
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                }else{
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.window?.rootViewController = tabBarVC
                                }
                                print("this is the json data, ", json)
             
                                break
                            case .failure(let error):
                                print(error)
                            }
        }
        
    }
    
    
    @IBAction func NameTextEdit(_ sender: UITextField) {
        NameLabel.text = NameText.text
        mainStore.dispatch(LoginNameAction(payload: NameText.text!));
    }
    
    //RealNameAction, AgeAction, GenderAction, FavoriteColorAction, FavoriteFoodAction,profileIMGURLAction,profileIMGTITLEAction
    
    @IBAction func LoginButton(_ sender: Any) {
        
        let urlString = "http://localhost:3000/login"
        
        Alamofire.request(urlString, method: .post,
                          parameters:
            [
                "username"      : self.NameText.text!,
                "password"      : self.passwordOutlet.text!,
                ],
                          encoding: JSONEncoding.default, headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                let json = JSON(response.data!)
                                print("this is the json data", json)
                                print("this is the json gender data, ", json["loginFAIL"])
                                if (json["loginFAIL"] == "u.sux")                                {
                                    print("ohshit")
                                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalLoginFail") as? ModalLoginFail
                                            {
                                                self.present(vc, animated: true, completion: nil)
                                            }
//                                    break
                                }else{
                                mainStore.dispatch(RealNameAction(payload: (json["post"]["realname"].stringValue)))
                                mainStore.dispatch(AgeAction(payload: Int((json["post"]["age"].stringValue))!))
                                mainStore.dispatch(GenderAction(payload: (json["post"]["gender"].stringValue)))
                                mainStore.dispatch(FavoriteColorAction(payload: (json["post"]["favoritecolor"].stringValue)))
                                mainStore.dispatch(FavoriteFoodAction(payload: (json["post"]["favoritefood"].stringValue)))
                                mainStore.dispatch(profileIMGURLAction(payload: (json["post"]["profileIMGURL"].stringValue)))
                                mainStore.dispatch(profileIMGTITLEAction(payload: (json["post"]["profileIMGTITLE"].stringValue)))
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.window?.rootViewController = tabBarVC
//                                break
                                }
                            case .failure(let error):
                                print(error)
                            }
        }
//        
//        for i in 0..<loginArray.count {
//            if loginArray[i]==NameLabel.text{
//                
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = tabBarVC
//                
//            }
//        }
//        
//        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalLoginFail") as? ModalLoginFail
//        {
//            present(vc, animated: true, completion: nil)
//        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameText.returnKeyType = UIReturnKeyType.done
        NameText.delegate = self
        passwordOutlet.returnKeyType = UIReturnKeyType.done
        passwordOutlet.delegate = self
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
