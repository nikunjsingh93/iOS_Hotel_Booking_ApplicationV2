//
//  TableViewControllerHotelComp.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/30/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit


var latG:Double?
var lonG:Double?
var cityG:String?
var priceG:String?



class TableViewControllerHotelComp: UITableViewController, UISearchBarDelegate,UINavigationControllerDelegate {
   
    @IBOutlet var HotelCompTableView: UITableView!
    
    
    @IBOutlet weak var searchBarHotelComp: UISearchBar!
    
  

    
    var temp = [String]()

    
    var inSearchMode = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        searchBarHotelComp.delegate = self
        
        
        searchBarHotelComp.returnKeyType = UIReturnKeyType.done
        
        
        HotelCompTableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        

        
        HotelCompTableView.reloadData()
        HotelCompTableView.delegate = self
        
        HotelCompTableView.dataSource = self
        
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
            return nameArray.count
        }
        
    }
    
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        
        if inSearchMode {
            
            
            cell.textLabel?.text = temp[indexPath.row]
            
        } else {
            
            
            cell.textLabel?.text = nameArray[indexPath.row]
        }
        
    

        return cell
    }
    
    
    
    
    func searchBar(_ searchBarCust: UISearchBar, textDidChange searchText: String) {
        
        if searchBarHotelComp.text == nil || searchBarHotelComp.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            HotelCompTableView.reloadData()
            
        } else {
            
            inSearchMode = true
            
         
            temp = nameArray.filter({$0.contains(searchBarHotelComp.text!)})
            print(temp.count)
            HotelCompTableView.reloadData()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        latG = latArray[indexPath.row]
        
        lonG = lonArray[indexPath.row]
        
        cityG = cityArray[indexPath.row]
        
        priceG = priceArray[indexPath.row]
        
        
        performSegue(withIdentifier: "toREST", sender: self)
        
        
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
