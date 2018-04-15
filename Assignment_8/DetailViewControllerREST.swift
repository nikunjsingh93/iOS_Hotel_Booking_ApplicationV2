//
//  DetailViewControllerREST.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 4/1/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit

class DetailViewControllerREST: UIViewController {

    @IBOutlet weak var lat: UILabel!
    
    @IBOutlet weak var lon: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lat.text = String(describing: latG!)
        
        lon.text = String(describing: lonG!)
        
        city.text = cityG
        
        price.text = priceG
        
        
        
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
