//
//  ModalLoginFail.swift
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
