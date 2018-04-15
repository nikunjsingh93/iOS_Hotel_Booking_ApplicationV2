//
//  DetailViewControllerCust.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/24/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit

class DetailViewControllerCust: UIViewController {

    @IBOutlet weak var custNameLabel: UILabel!
    
    @IBOutlet weak var custPhoneLabel: UILabel!
    
    @IBOutlet weak var custAddLabel: UILabel!
    
    @IBOutlet weak var custIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       custNameLabel.text = custNTemp
        
       custPhoneLabel.text = custPTemp
        
       custAddLabel.text = custATemp
        
       custIdLabel.text = custITemp
        

        
    
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
