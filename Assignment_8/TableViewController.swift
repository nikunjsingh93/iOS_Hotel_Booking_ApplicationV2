//
//  TableViewController.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/24/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit
import CoreData

var custNTemp:String?
var custPTemp:String?
var custATemp:String?
var custITemp:String?


var nameArray = [String]()

var latArray = [Double]()

var lonArray = [Double]()

var cityArray = [String]()

var priceArray = [String]()





class TableViewController: UITableViewController, UISearchBarDelegate,UINavigationControllerDelegate{

    @IBOutlet var custTableView: UITableView!
    
    @IBOutlet weak var searchBarCust: UISearchBar!
    
    
    var filteredData = [String]()
    
    
    var temp = [Customers]()

    
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            custArraydata = try context.fetch(Customers.fetchRequest())
            

        }catch {

        }
        
    searchBarCust.delegate = self
       
        
        searchBarCust.returnKeyType = UIReturnKeyType.done
      
        
        custTableView.reloadData()
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
      
    }
    
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            custArraydata = try context.fetch(Customers.fetchRequest())
            
            
        }catch {
            
        }
        
        custTableView.reloadData()
        custTableView.delegate = self
        
        custTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if inSearchMode {
            
            return temp.count
        }else{
            return custArraydata.count
        }
        
       
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        
        if inSearchMode {
            
            
             cell.textLabel?.text = temp[indexPath.row].custName
            
        } else {
            
            
             cell.textLabel?.text = custArraydata[indexPath.row].custName
        }

        
        
        return cell
    }
    
    
    
    @IBOutlet weak var cell: UITableViewCell!
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        custNTemp = custArraydata[indexPath.row].custName
        
        custPTemp = custArraydata[indexPath.row].custPhoneNumber
        
        custATemp = custArraydata[indexPath.row].custAddress
        
        custITemp = custArraydata[indexPath.row].custId
        

       performSegue(withIdentifier: "cellS", sender: self)
   
        
    }
    
    
    

    
    func searchBar(_ searchBarCust: UISearchBar, textDidChange searchText: String) {
        
        if searchBarCust.text == nil || searchBarCust.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            custTableView.reloadData()
            
        } else {
            
            inSearchMode = true
            
            //custArraydata.removeAll(keepingCapacity: true)
            
            let searchPredicate = NSPredicate(format: "custName CONTAINS[c] %@" , searchText)
            
            
            let array = (custArraydata as! NSArray).filtered(using: searchPredicate)
            
            temp = array as! Array<Customers>
           print(temp.count)
            custTableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            let custNameDel = custArraydata[indexPath.row].custName

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Customers")
            request.returnsObjectsAsFaults = false
            var stringName : String  = String()


            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    stringName  = data.value(forKey: "custName") as! String
                    if stringName == custNameDel{
                        do {
                            try context.delete(data)
                            appDelegate.saveContext()
                            do {
                                custArraydata = try context.fetch(Customers.fetchRequest())
                                
                                
                            }catch {
                                
                            }
                            custTableView.reloadData()

                            
                        } catch {
                            print("Failed saving")
                        }

                    }

                }

            } catch {

                print("Failed")
            }


            let alertController = UIAlertController(title: "Success!", message:
                "Customer Deleted", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))

            self.present(alertController, animated: true, completion: nil)

            
        }
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
}





