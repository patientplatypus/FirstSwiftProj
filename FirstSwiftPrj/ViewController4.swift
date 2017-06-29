

import Foundation
import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import ReSwift



class ViewController4: UIViewController,  UITextFieldDelegate, StoreSubscriber {
    
    var activeField: UITextField?
    var sendage: Int?
    
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var TextField1Outlet: UITextField!
    @IBOutlet weak var TextField2Outlet: UITextField!
    @IBOutlet weak var TextField3Outlet: UITextField!
    @IBOutlet weak var TextField4Outlet: UITextField!
    @IBOutlet weak var TextField5Outlet: UITextField!
    @IBOutlet var ViewFrame: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var SaveProfileOutlet: UIButton!
    
    @IBAction func SaveProfileButton(_ sender: Any) {
        let urlString = "http://localhost:3000/saveprofile"
        SaveProfileOutlet.setTitle("Saving Now ... ",for: .normal)
        if Int(TextField2Outlet.text!) != nil {
            self.sendage = Int(TextField2Outlet.text!)!
        }else{
            self.sendage = -1
        }

        Alamofire.request(urlString, method: .post,
                          parameters:
                                [
                                    "username"      : "\(mainStore.state.LoginName)",
                                    "realname"      : TextField1Outlet.text!,
                                    "age"           : self.sendage,
                                    "gender"        : TextField3Outlet.text!,
                                    "favoritecolor" : TextField4Outlet.text!,
                                    "favoritefood"  : TextField5Outlet.text!
                                ],
            encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
            switch response.result {
            case .success:
                let json = JSON(response.data!)
                print("this is the json data, ", json)
                self.SaveProfileOutlet.setTitle("Profile UPDATED :P ",for: .normal)
                break
            case .failure(let error):
                print(error)
            }
        }

    }
    
    
    
    @IBAction func TextField1Action(_ sender: Any) {
        mainStore.dispatch(RealNameAction(payload: TextField1Outlet.text!));
    }
    
    @IBAction func TextField2Action(_ sender: Any) {
        if Int(TextField2Outlet.text!) != nil {
            mainStore.dispatch(AgeAction(payload: Int(TextField2Outlet.text!)!));
        }else{
            TextField2Outlet.text = ""
            TextField2Outlet.placeholder = "please only enter integers sillybilly"
        }
    }
    
    @IBAction func TextField3Action(_ sender: Any) {
        mainStore.dispatch(GenderAction(payload: TextField3Outlet.text!));
    }
    
    @IBAction func TextField4Action(_ sender: Any) {
        //        dataState?.FavoriteColor = TextField4Outlet.text!
        mainStore.dispatch(FavoriteColorAction(payload: TextField4Outlet.text!));
    }
    
    @IBAction func TextField5Action(_ sender: Any) {
        //        dataState?.FavoriteFood = TextField5Outlet.text!
        mainStore.dispatch(FavoriteFoodAction(payload: TextField5Outlet.text!));
    }
    
    
    @IBAction func BackToTabControl(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarVC
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        UserNameLabel.text = "\(mainStore.state.LoginName)"
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
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



