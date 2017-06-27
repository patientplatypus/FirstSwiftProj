//
//  ViewController.swift
//  FirstSwiftPrj
//
//  Created by Peter Weyand on 6/21/17.
//  Copyright © 2017 Peter Weyand. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON



class Data {
    var dataText1 = String()
    var LoginName = String()
    var RealName = String()
    var Age = Int()
    var Gender = String()
    var FavoriteColor = String()
    var FavorietFood = String()
    var profileIMGURL = String()
    var profileIMGTITLE = String()
}





class ViewControllerEntry: UIViewController, UITextFieldDelegate {

    var loginArray: [String] = ["Peter", "Peter Weyand", "Weyand", "platypus", "patientplatypus"]
    
    @IBOutlet weak var SplashLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    
    
    let dataState = Data()
    
    
    @IBAction func NameTextEdit(_ sender: UITextField) {
        NameLabel.text = NameText.text
        dataState.LoginName = NameText.text!
    }

    @IBAction func LoginButton(_ sender: Any) {
        for i in 0..<loginArray.count {
            if loginArray[i]==NameLabel.text{
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                
                if let vc1 = tabBarVC.viewControllers?.first as? ViewController1 {
                    vc1.dataState = dataState
                }
                
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


class ModalLoginFail: UIViewController {
    
    
    @IBOutlet weak var Faillabel: UILabel!
    @IBOutlet weak var OKOutlet: UIButton!
    @IBAction func OKAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 200/255, alpha: 0.2)
        view.isOpaque = false
        self.OKOutlet.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 100/255, alpha: 1.0)
        self.Faillabel.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 100/255, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}



class ViewController1: UIViewController {

    @IBOutlet weak var returnedDataLabel: UILabel!
    @IBOutlet weak var UserName: UILabel!
    var stringPassed = ""
    var returnedData = ""
    var dataState: Data?

    
//    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
//    var secondTab = self.tabBarVC?.viewControllers[1] as SecondViewController
//    secondTab.array = firstArray
    
//performSegue(withIdentifier: "SB14Send", sender: nil)
    
    @IBAction func SB3(_ sender: Any) {
        performSegue(withIdentifier: "SB13Send", sender: nil)
    }
    
    @IBAction func SB4Send(_ sender: Any) {
        performSegue(withIdentifier: "SB14Send", sender: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ViewController4 {
            destinationViewController.dataState = dataState
        }
        if let destinationViewController = segue.destination as? ViewController3 {
            destinationViewController.dataState = dataState
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        UserName.text = dataState?.LoginName
        returnedDataLabel.text = dataState?.dataText1
        
        let secondTab = self.tabBarController?.viewControllers?[1] as? ViewController2
        secondTab?.dataState = dataState
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}



class ViewController2: UIViewController {

    var dataState: Data?
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataLabel.text = dataState?.LoginName
    }
    
    
}




class ViewController3: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, modalDelegate {
    
    var dataState: Data?
    
    var linkArray = [String]()
    var titleArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SearchTextField: UITextField!

    @IBOutlet weak var imgTITLElabel: UILabel!
    @IBOutlet weak var imgURLlabel: UILabel!
    
    @IBAction func SearchButton(_ sender: Any) {
        
        let urlString = "http://localhost:3000/getimages"
        self.titleArray = []
        self.linkArray = []
        
        Alamofire.request(urlString, method: .post, parameters: ["search": SearchTextField.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                let json = JSON(response.data!)
                print("this is the json data, ", json)
    
                
                for (_, subJson) in json["data"] {
                    if let link = subJson["cover"].string {
                       let imageLink = "http://i.imgur.com/" + link + ".jpg"
                       self.linkArray.append(imageLink)
                    }
                    if let title = subJson["title"].string{
                        self.titleArray.append(title)
                    }
                }
                print("this is linkArray ", self.linkArray)
                print("this is titleArray ", self.titleArray)
                self.dataUpdated()
                break
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    @IBAction func BackToTabControl(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        
        if let vc1 = tabBarVC.viewControllers?.first as? ViewController1 {
            vc1.dataState = dataState
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarVC
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.bounces = true
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        self.SearchTextField.returnKeyType = UIReturnKeyType.done
        self.SearchTextField.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        
        let text = titleArray[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row was clicked!")
        print(self.titleArray[indexPath.row])
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController") as? ModalController
        {
            vc.imgTITLE = self.titleArray[indexPath.row]
            vc.imgURL = self.linkArray[indexPath.row]
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickData(imgURL: String, imgTITLE: String){
        print("inside the pickData function in ViewController3")
        self.dataState?.profileIMGURL = imgURL
        self.dataState?.profileIMGTITLE = imgTITLE
        self.imgTITLElabel.text = imgURL
        self.imgURLlabel.text = imgTITLE
    }
    
    
}


protocol modalDelegate {
    func pickData(imgURL: String, imgTITLE: String)
}



class ModalController: UIViewController{
    var imgTITLE = String()
    var imgURL = String()
    var url: URL?
    var delegate: modalDelegate?
    
    
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var modalImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setButtonAction(_ sender: Any) {
        print("inside setButtonAction of ModalController")
        self.delegate?.pickData(imgURL: self.imgURL, imgTITLE: self.imgTITLE)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButton.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
        backButton.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
        if let url = URL(string: imgURL){
            do {
                print("inside do for url")
                print("value of title is ", imgTITLE)
                print("value of url is ", url)
                let data = try Foundation.Data(contentsOf: url)
                DispatchQueue.main.async{
                    self.modalImage.image = UIImage(data: data)
                    self.titleLabel.text = self.imgTITLE
                }
            } catch {
                print("inside catch for url")
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 200/255, alpha: 0.2)
        view.isOpaque = false
    }

}



//class Data {
//    var dataText1 = String()
//    var LoginName = String()
//    var RealName = String()
//    var Age = Int()
//    var Gender = String()
//    var FavoriteColor = String()
//    var FavorietFood = String()
//}





class ViewController4: UIViewController,  UITextFieldDelegate {
    
    var dataState: Data?
    var activeField: UITextField?
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    @IBOutlet weak var TextField1Outlet: UITextField!
    
    
    @IBOutlet weak var TextField2Outlet: UITextField!

    @IBOutlet weak var TextField3Outlet: UITextField!
    
    
    @IBOutlet weak var TextField4Outlet: UITextField!
    
    
    @IBOutlet weak var TextField5Outlet: UITextField!
    
    @IBOutlet var ViewFrame: UIView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBAction func TextField1Action(_ sender: Any) {
        dataState?.RealName = TextField1Outlet.text!
    }
    
    @IBAction func TextField2Action(_ sender: Any) {
        dataState?.Age = Int(TextField2Outlet.text!)!
    }
    
    @IBAction func TextField3Action(_ sender: Any) {
        dataState?.Gender = TextField4Outlet.text!
    }
    
    @IBAction func TextField4Action(_ sender: Any) {
        dataState?.FavoriteColor = TextField4Outlet.text!
    }
    
    @IBAction func TextField5Action(_ sender: Any) {
        dataState?.FavorietFood = TextField5Outlet.text!
    }
    
    
    @IBAction func BackToTabControl(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        
        if let vc1 = tabBarVC.viewControllers?.first as? ViewController1 {
            vc1.dataState = dataState
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarVC
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserNameLabel.text = dataState?.LoginName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ViewController1 {
            destinationViewController.dataState = dataState
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.delegate = self as? UIScrollViewDelegate
        
        TextField1Outlet.returnKeyType = UIReturnKeyType.done
        TextField1Outlet.delegate = self
        
        TextField2Outlet.returnKeyType = UIReturnKeyType.done
        TextField2Outlet.delegate = self
        
        TextField3Outlet.returnKeyType = UIReturnKeyType.done
        TextField3Outlet.delegate = self
        
        TextField4Outlet.returnKeyType = UIReturnKeyType.done
        TextField4Outlet.delegate = self
        
        TextField5Outlet.returnKeyType = UIReturnKeyType.done
        TextField5Outlet.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    
}



