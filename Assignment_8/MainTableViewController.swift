//
//  MainTableViewController.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 4/7/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    
    let URL_HEROES = "https://api.sandbox.amadeus.com/v1.2/hotels/search-circle?apikey=ZSMI69eF32sfJpaYaNAGvZZ01jbWTtfG&latitude=36.0857&longitude=-115.1541&radius=10&check_in=2018-06-15&check_out=2018-06-16";
    
    
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: URL_HEROES)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //                print(jsonObj!.value(forKey: "results")!)
                
                //getting the avengers tag array from json and converting it to NSArray
                if let heroeArray = jsonObj!.value(forKey: "results") as? NSArray {
                    //looping through all the elements
                    for heroe in heroeArray{
                        
                        //converting the element to a dictionary
                        if let heroeDict = heroe as? NSDictionary {
                            
                            //getting the name from the dictionary
                            if let name = heroeDict.value(forKey: "property_name") {
                                
                                //adding the name to the array
                                nameArray.append((name as? String)!)
                            }
                            
                            if  let n = heroeDict.value(forKey: "location") {
                                
                                if let name1 = (n as AnyObject).value(forKey: "latitude") {
                                    
                                    //adding the name to the array
                                    latArray.append((name1 as? Double)!)
                                }
                            }
                            
                            if  let n = heroeDict.value(forKey: "location") {
                                
                                if let name1 = (n as AnyObject).value(forKey: "longitude") {
                                    
                                    //adding the name to the array
                                    lonArray.append((name1 as? Double)!)
                                }
                            }
                            
                            if  let n = heroeDict.value(forKey: "address") {
                                
                                if let name1 = (n as AnyObject).value(forKey: "city") {
                                    
                                    //adding the name to the array
                                    cityArray.append((name1 as? String)!)
                                }
                            }
                            
                            if  let n = heroeDict.value(forKey: "total_price") {
                                
                                if let name1 = (n as AnyObject).value(forKey: "amount") {
                                    
                                    //adding the name to the array
                                    priceArray.append((name1 as? String)!)
                                }
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    self.showNames()
                })
            }
        }).resume()
    }
    
    func showNames(){
        //looing through all the elements of the array
        for name in nameArray{
            
            //appending the names to label
            //            labelTest.text = labelTest.text! + name + "\n";
            print(name)
        }
        
        for name1 in latArray{
            
            //appending the names to label
            //            labelTest.text = labelTest.text! + name + "\n";
            print("lat\(name1)")
        }
        
        for name1 in lonArray{
            
            //appending the names to label
            //            labelTest.text = labelTest.text! + name + "\n";
            print("lon\(name1)")
        }
        
        for name1 in cityArray{
            
            //appending the names to label
            //            labelTest.text = labelTest.text! + name + "\n";
            print("city\(name1)")
        }
        
        for name1 in priceArray{
            
            //appending the names to label
            //            labelTest.text = labelTest.text! + name + "\n";
            print("price\(name1)")
        }
    }
    
    
    

    @IBOutlet var mainTableView: UITableView!
    
    let MainArray = ["Customers","Rooms","Bookings","Hotels"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getJsonFromUrl()



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return MainArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
            
            cell.textLabel?.text = MainArray[indexPath.row]
            

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let selectedAns = MainArray[indexPath.row]
        
        if (selectedAns == "Customers") {
            
            performSegue(withIdentifier: "createCustBtn", sender: self)
            
            
        } else if (selectedAns == "Rooms") {
            
            performSegue(withIdentifier: "createRoom", sender: self)
            
            
        } else if (selectedAns == "Bookings") {
            
            performSegue(withIdentifier: "createBookingS", sender: self)
            
            
        } else if (selectedAns == "Hotels") {
            
            performSegue(withIdentifier: "toHotelComp", sender: self)
            
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
