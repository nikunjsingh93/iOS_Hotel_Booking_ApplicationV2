//
//  DetailViewControllerRooms.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/25/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit

class DetailViewControllerRooms: UIViewController {
    
    
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var roomPriceLabel: UILabel!
    
    @IBOutlet weak var roomImageLabel: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        roomNameLabel.text = roomNTemp
        
        roomTypeLabel.text = roomTTemp
        
        roomPriceLabel.text = roomPTemp
        
        let imagePt = UIImage(data: (roomITemp as! NSData) as Data)
        
        roomImageLabel.image = imagePt
        
        

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
