//
//  TableViewControllerRooms.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/24/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit
import CoreData

var roomNTemp:String?
var roomTTemp:String?
var roomPTemp:String?
var roomITemp:Data?




class TableViewControllerRooms: UITableViewController, UISearchBarDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var searchBarRoom: UISearchBar!
    
    @IBOutlet var roomTableView: UITableView!
    
    
    
    var filteredData = [String]()
    
    
    var temp = [Rooms]()
    
    
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            roomArraydata = try context.fetch(Rooms.fetchRequest())
            
        }
        catch {
            
            //handle
            
        }
        
        searchBarRoom.delegate = self
        
        
        searchBarRoom.returnKeyType = UIReturnKeyType.done
        
        
        
        roomTableView.reloadData()
        
     
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            roomArraydata = try context.fetch(Rooms.fetchRequest())
            
        }
        catch {
            
            //handle
            
        }
        
        roomTableView.delegate = self
        
        roomTableView.dataSource = self
        
        
        roomTableView.reloadData()
        
        
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
            return roomArraydata.count
        }
        
        

        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        roomNTemp = roomArraydata[indexPath.row].roomName
        
        roomTTemp = roomArraydata[indexPath.row].roomType
        
        roomPTemp = roomArraydata[indexPath.row].roomPrice
        
    
        roomITemp = roomArraydata[indexPath.row].roomImage
        
        performSegue(withIdentifier: "cellS", sender: self)
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        
        if inSearchMode {
            
            
            cell.textLabel?.text = temp[indexPath.row].roomName
            
            cell.imageView?.image = UIImage(data: temp[indexPath.row].roomImage!)
            
        } else {
            
            
            cell.textLabel?.text = roomArraydata[indexPath.row].roomName
            
            cell.imageView?.image = UIImage(data: roomArraydata[indexPath.row].roomImage!)

            
        }

        
        return cell
    }
    
    
    
    
    func searchBar(_ searchBarRoom: UISearchBar, textDidChange searchText: String) {
        
        if searchBarRoom.text == nil || searchBarRoom.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            roomTableView.reloadData()
            
        } else {
            
            inSearchMode = true
            
            //custArraydata.removeAll(keepingCapacity: true)
            
            let searchPredicate = NSPredicate(format: "roomName CONTAINS[c] %@" , searchText)
            
            
            let array = (roomArraydata as! NSArray).filtered(using: searchPredicate)
            
            temp = array as! Array<Rooms>
            print(temp.count)
            
            do {
                roomArraydata = try context.fetch(Rooms.fetchRequest())
                
            }
            catch {
                
                //handle
                
            }
            roomTableView.reloadData()
        }
    }

    
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            let custNameDel = roomArraydata[indexPath.row].roomName
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rooms")
            request.returnsObjectsAsFaults = false
            var stringName : String  = String()
            
            
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    stringName  = data.value(forKey: "roomName") as! String
                    if stringName == custNameDel{
                        do {
                            try context.delete(data)
                            appDelegate.saveContext()
                            
                            do {
                                roomArraydata = try context.fetch(Rooms.fetchRequest())
                                
                            }
                            catch {
                                
                                //handle
                                
                            }
                            
                            roomTableView.reloadData()

                        } catch {
                            print("Failed saving")
                        }
                        
                    }
                    
                }
                
            } catch {
                
                print("Failed")
            }
            
            
            let alertController = UIAlertController(title: "Success!", message:
                "Room Deleted", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
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
