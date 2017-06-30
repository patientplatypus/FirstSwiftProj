//
//  ViewController6.swift
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

class ViewController6: UIViewController, StoreSubscriber {
    
    var backgroundFood: String = ""
//    var image: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
        
        print("this is the value of the backgroundFood ", self.backgroundFood)
        
        let urlString = "http://localhost:3000/getimages"
        
        Alamofire.request(urlString, method: .post, parameters: ["search": self.backgroundFood],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                let json = JSON(response.data!)
                for (_, subJson) in json["data"] {
                    if let link = subJson["cover"].string {
                        let imageLink = "http://i.imgur.com/" + link + "s.jpg"
                        print("imageLink", imageLink)
                        
                        
                        if let url = URL(string: imageLink){
                            do {
                                print("inside do for url")
                                let data = try Foundation.Data(contentsOf: url)
                                DispatchQueue.main.async{
                                    let image = UIImage(data: data)!
                                    self.view.backgroundColor = UIColor(patternImage: image)
                                }
                            } catch {
                                print("inside catch for url")
                                print(error.localizedDescription)
                            }
                        }
                        
                        
                        
                        

                        break
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }

        
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        backgroundFood = "\(mainStore.state.FavoriteFood)"
    }
    
    
}
