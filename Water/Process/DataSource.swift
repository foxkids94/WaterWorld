//
//  DataSource.swift
//  Water
//
//  Created by Юрий Макаров on 28/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import CoreLocation


class DataSource:NSObject, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    var allCategory: [Category] = []
    var allProduct: [Product] = []
    var allAdresses: [UserInfo] = []
    static let shared = DataSource()
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    let url: URL = URL(string: "http://149.154.69.176")!
    
    
    func downloadAdres() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        
        do {
            DataSource.shared.allAdresses = try contex.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
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
    
    final func AuthLocation() {
        let authLocation = CLLocationManager.authorizationStatus()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        switch authLocation {
        case .restricted:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            //nearForPlace()
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    final func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation: CLLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let location1 = CLLocation(latitude: 54.1943226, longitude: 45.17210260000002)
        myLocation.distance(from: location1)
        
        print("Осталось до места \(Int(myLocation.distance(from: location1))) метров")

        
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
