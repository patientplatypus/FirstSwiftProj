//
//  ViewController3.swift
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





class ViewController3: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, StoreSubscriber {
    
    var dataState: Data?
    var imageArray = [[String:String]]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SearchTextField: UITextField!
    
    @IBOutlet weak var imgTITLElabel: UILabel!
    @IBOutlet weak var imgURLlabel: UILabel!
    
    @IBAction func SearchButton(_ sender: Any) {
        
        let urlString = "http://localhost:3000/getimages"

        
        Alamofire.request(urlString, method: .post, parameters: ["search": SearchTextField.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                let json = JSON(response.data!)
                print("this is the json data, ", json)
                var linkIndex = 0
                var tempDict = ["link": "", "title": ""]
                for (_, subJson) in json["data"] {
                    if let link = subJson["cover"].string {
                        let imageLink = "http://i.imgur.com/" + link + ".jpg"
                        tempDict["link"] = imageLink
                    }
                    if let title = subJson["title"].string{
                        tempDict["title"] = title
                    }
                    if ((tempDict["link"]?.characters.count)! > 0 && (tempDict["title"]?.characters.count)! > 0){
                        self.imageArray.append(tempDict)
                        tempDict = ["link": "", "title": ""]
                        linkIndex += 1
                    }
                }
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        self.imgTITLElabel.text = "\(mainStore.state.profileIMGTITLE)"
        self.imgURLlabel.text = "\(mainStore.state.profileIMGURL)"
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

          return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!

        let text = self.imageArray[indexPath.row]["title"]
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row was clicked!")
        print(self.imageArray[indexPath.row]["title"] as Any)
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController") as? ModalController
        {
            vc.imgTITLE = self.imageArray[indexPath.row]["title"]!
            vc.imgURL = self.imageArray[indexPath.row]["link"]!
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
    
    
}
