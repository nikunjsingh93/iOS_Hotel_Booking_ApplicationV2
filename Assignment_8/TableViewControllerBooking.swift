//
//  TableViewControllerBooking.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/25/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit
import CoreData

var bookingNameTemp:String?
var bookingOthercustNameTemp:String?
var bookingFromtemp:Date?
var bookingToTemp:Date?
var bookingRoomNameTemp:String?
var bookingRoomPriceTemp:String?
var bookingRoomTypeTemp:String?
var bookingCustNameTemp:String?
var bookingCustPhoneTemp:String?
var bookingCustAddTemp:String?



class TableViewControllerBooking: UITableViewController, UISearchBarDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var searchBarBooking: UISearchBar!
    
    
    @IBOutlet var tableViewBooking: UITableView!
    
    
    var filteredData = [String]()
    
    
    var temp = [Bookings]()
    
    
    var inSearchMode = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            bookArraydata = try context.fetch(Bookings.fetchRequest())
            
        }
        catch {
            
            //handle
            
        }
        
        searchBarBooking.delegate = self
        
        
        searchBarBooking.returnKeyType = UIReturnKeyType.done
        
        
        
        tableViewBooking.reloadData()
        
        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            bookArraydata = try context.fetch(Bookings.fetchRequest())
            
        }
        catch {
            
            //handle
            
        }
        
        tableViewBooking.delegate = self
        
        tableViewBooking.dataSource = self
        
        
        tableViewBooking.reloadData()
        
        
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
            return bookArraydata.count
        }
        
        

    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        
        if inSearchMode {
            
            
            cell.textLabel?.text = temp[indexPath.row].bookingName
            
            
        } else {
            
            
            cell.textLabel?.text = bookArraydata[indexPath.row].bookingName
            
            
            
        }
        
        
        return cell
    }
    
    
    func searchBar(_ searchBarRoom: UISearchBar, textDidChange searchText: String) {
        
        if searchBarBooking.text == nil || searchBarBooking.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            tableViewBooking.reloadData()
            
        } else {
            
            inSearchMode = true
            
            //custArraydata.removeAll(keepingCapacity: true)
            
            let searchPredicate = NSPredicate(format: "bookingName CONTAINS[c] %@" , searchText)
            
            
            let array = (bookArraydata as! NSArray).filtered(using: searchPredicate)
            
            temp = array as! Array<Bookings>
            print(temp.count)
            
            do {
                bookArraydata = try context.fetch(Bookings.fetchRequest())
                
            }
            catch {
                
                //handle
                
            }
            tableViewBooking.reloadData()
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            let custNameDel = bookArraydata[indexPath.row].bookingName
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
            request.returnsObjectsAsFaults = false
            var stringName : String  = String()
            
            
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    stringName  = data.value(forKey: "bookingName") as! String
                    if stringName == custNameDel{
                        do {
                            try context.delete(data)
                            appDelegate.saveContext()
                            
                            do {
                                bookArraydata = try context.fetch(Bookings.fetchRequest())
                                
                            }
                            catch {
                                
                                //handle
                                
                            }
                            
                            tableViewBooking.reloadData()
                            
                        } catch {
                            print("Failed saving")
                        }
                        
                    }
                    
                }
                
            } catch {
                
                print("Failed")
            }
            
            
            let alertController = UIAlertController(title: "Success!", message:
                "Booking Deleted", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        
        bookingNameTemp = bookArraydata[indexPath.row].bookingName
        
        bookingOthercustNameTemp = bookArraydata[indexPath.row].bookingOtherCust
        
        bookingFromtemp = bookArraydata[indexPath.row].bookingFrom
        
        
        bookingToTemp = bookArraydata[indexPath.row].bookingTo
        
        
        
        bookingRoomNameTemp = bookArraydata[indexPath.row].bookingRoomName
        
        bookingRoomPriceTemp = bookArraydata[indexPath.row].bookingRoomPrice
        
        bookingRoomTypeTemp = bookArraydata[indexPath.row].bookingRoomType
        
        
        bookingCustNameTemp = bookArraydata[indexPath.row].bookingCustName
        
        bookingCustPhoneTemp = bookArraydata[indexPath.row].bookingCustPhone
        
        
        bookingCustAddTemp = bookArraydata[indexPath.row].bookingCustAdd
        
        
        
        performSegue(withIdentifier: "showBookingS", sender: self)
        
        
    }
    
    
    
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
