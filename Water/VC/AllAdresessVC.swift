//
//  AllAdresessVC.swift
//  Water
//
//  Created by Юрий Макаров on 29/10/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit
import CoreData

class AllAdresessVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataSource.shared.allAdresses.count
    }

    @IBAction func createNewAdress(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Вы ходите добавить новый адрес?", message: "Для добавления нового адреса доставки, заполните необходимые поля.", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Имя" }
        alert.addTextField { $0.placeholder = "Адрес доставки"}
        alert.addTextField { $0.placeholder = "Номер телефона"
                             $0.keyboardType = .namePhonePad }
        let actionOK = UIAlertAction(title: "Добавить", style: .default) { (action) in
            self.saveNewAdres(name: alert.textFields![0].text!, adress: alert.textFields![1].text!, numberPhone: alert.textFields![2].text!)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveNewAdres(name: String, adress: String, numberPhone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: contex)
        
        let adressObject = NSManagedObject(entity: entity!, insertInto: contex) as! UserInfo
        adressObject.adres = adress
        adressObject.name = name
        adressObject.numberPhone = numberPhone
        
        do {
            try contex.save()
            DataSource.shared.allAdresses.append(adressObject)
            self.tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    func delete(indexPath: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        let object = DataSource.shared.allAdresses[indexPath]
        do {
            try contex.delete(object)
            
            DataSource.shared.allAdresses.remove(at: indexPath)
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdresCell", for: indexPath) as! CellAdres

        cell.Name.text = DataSource.shared.allAdresses[indexPath.row].name
        cell.adresLbl.text = DataSource.shared.allAdresses[indexPath.row].adres
        cell.phoneNumber.text = DataSource.shared.allAdresses[indexPath.row].numberPhone
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let alertDelete = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let actionDelete = UIAlertAction(title: "Удалить адрес доставки", style: .destructive) { (action) in self.delete(indexPath: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alertDelete.addAction(actionDelete)
            alertDelete.addAction(actionCancel)
            self.present(alertDelete, animated: true, completion: nil)
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




class CellAdres: UITableViewCell {

    @IBOutlet weak var adresLbl: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
}
