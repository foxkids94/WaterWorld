//
//  ProductVC.swift
//  Water
//
//  Created by Юрий Макаров on 29/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit


class ProductVC: UICollectionViewController {
    
    static var product: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
    }

    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ProductVC.product.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! CellProduct
        cell.titleProduct.text = ProductVC.product[indexPath.row].title
        cell.infoText.text = ProductVC.product[indexPath.row].info
        cell.avatarImage.image = ProductVC.product[indexPath.row].image
        cell.price = ProductVC.product[indexPath.row].price
        cell.category = ProductVC.product[indexPath.row].category
        cell.product = ProductVC.product[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 


    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(ProductVC.product[indexPath.row].price)
        BuyItProductVC.product = ProductVC.product[indexPath.row]
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }


}

class CellProduct: UICollectionViewCell {
    var price: Int = 0
    var category: Category?
    var product: Product?
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var infoText: UITextView! {
        didSet {
            infoText.sizeToFit()
        }
    }
    @IBOutlet weak var BuyProduct: UIButton!
    @IBAction func Buy(_ sender: UIButton) {
        BuyItProductVC.product = product!
    }
}
