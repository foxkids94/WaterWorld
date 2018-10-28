//
//  DataSource.swift
//  Water
//
//  Created by Юрий Макаров on 28/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit

class DataSource: NSObject {

    static let shared = DataSource()
    
    private override init() {}
    let url: URL = URL(string: "http://149.154.69.176")!
    
    func downloadAllCategory(){
        
    }
}
