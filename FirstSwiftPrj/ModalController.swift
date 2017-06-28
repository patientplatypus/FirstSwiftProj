//
//  ModalController.swift
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




class ModalController: UIViewController{
    var imgTITLE: String = ""
    var imgURL: String = ""
    var url: URL?
    
    
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var modalImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setButtonAction(_ sender: Any) {
        print("inside setButtonAction of ModalController")
        print("inside setButtonAction and imgURL is ", self.imgURL);
        print("inside setButtonAction and imgTitle is ", self.imgTITLE);
        mainStore.dispatch(profileIMGURLAction(payload: self.imgURL));
        mainStore.dispatch(profileIMGTITLEAction(payload: self.imgTITLE));
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
