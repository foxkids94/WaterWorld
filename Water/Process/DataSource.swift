//
//  DataSource.swift
//  Water
//
//  Created by Юрий Макаров on 28/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit
import Alamofire

class DataSource: NSObject {

    var allCategory: [Category] = []
    var allProduct: [Product] = []
    
    static let shared = DataSource()
    
    private override init() {}
    let url: URL = URL(string: "http://149.154.69.176")!
    
    func downloadAllTxtData(){
        request("\(url)/Product.json").responseJSON { response in
            if response.result.value != nil {
               
                let allData = response.result.value as? NSDictionary
                allData?.allKeys.forEach({ (data) in
                    
                    let category = allData![data] as? NSDictionary
                    let img = category!["image"] as! String
                    let urlImg = URL(string: "http://149.154.69.176/images/\(img)")
                    
                    request(urlImg!).responseData(completionHandler: { (responseImg) in
                        let title = data as! String
                        let image = UIImage(data: responseImg.data!)
                        let newCategory = Category(title: title, image: image!)
                        self.allCategory.append(newCategory)
                        self.ConvertDataForProduct(category: newCategory, data: allData![data] as! NSDictionary)
                        })
                    })
            }
        }
    }
    
    func ConvertDataForProduct(category: Category, data: NSDictionary) {
        if let allProduct = data["Categories"] as? NSDictionary {
            allProduct.allKeys.forEach { (productID) in
                if let product = allProduct[productID] as? NSDictionary {
                    let title = product["title"] as! String
                    let info = product["info"] as! String
                    let price = product["price"] as! Int
                    let img = product["image"] as! String
                    let urlImg = URL(string: "http://149.154.69.176/images/\(img)")!
                    
                    request(urlImg).responseData(completionHandler: { (responseImg) in
                        let image = UIImage(data: responseImg.data!)
                        let newProduct = Product(category: category, title: title, info: info, price: price, image: image!)
                        self.allProduct.append(newProduct)
                    })
                    
                    
                }
            }
        }
    }
    
}


struct Category {
    let title: String
    let image: UIImage
}

struct Product {
    let category: Category
    let title: String
    let info: String
    let price: Int
    let image: UIImage
}
