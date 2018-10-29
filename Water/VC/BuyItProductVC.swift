//
//  BuyItProductVC.swift
//  Water
//
//  Created by Юрий Макаров on 29/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit

class BuyItProductVC: UIViewController {

    static var product: Product?
    
    @IBOutlet weak var StepperCount: UIStepper!
    
    @IBOutlet weak var ProductTitle: UILabel! {
        didSet {
            ProductTitle.text = BuyItProductVC.product?.title
        }
    }
    
    
    @IBOutlet weak var productAllPrice: UILabel! {
        didSet {
            let price = BuyItProductVC.product!.price
            productAllPrice.text = "\(price) руб."
        }
    }
    
    @IBOutlet weak var productCount: UILabel!
    
    
    @IBAction func PriceAdd(_ sender: UIStepper) {
        self.productCount.text = "\(Int(sender.value)) шт."
        self.productAllPrice.text = "\(Int(sender.value) * (BuyItProductVC.product?.price)!) руб."
        self.productCount.sizeToFit()
        self.productAllPrice.sizeToFit()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
