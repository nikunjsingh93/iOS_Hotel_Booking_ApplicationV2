//
//  DetailViewControllerBooking.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/25/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit

class DetailViewControllerBooking: UIViewController {

    
    @IBOutlet weak var bookingNameLabel: UILabel!
    
    
    @IBOutlet weak var bookingFromLabel: UILabel!
    
    
    @IBOutlet weak var bookingToLabel: UILabel!
    
    
    @IBOutlet weak var bookingCustNameLabel: UILabel!
    
    @IBOutlet weak var bookingOtherCustNameLabel: UILabel!
    
    
    @IBOutlet weak var bookingCustPhoneLabel: UILabel!
    
    
    @IBOutlet weak var bookingCustAddressLabel: UILabel!
    
    @IBOutlet weak var bookingRoomNameLabel: UILabel!
    
    
    @IBOutlet weak var bookingRoomTypeLabel: UILabel!
    
    
    @IBOutlet weak var bookingRoomPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM-dd-yyyy"
        let dateString1 = dateFormatter1.string(from: bookingFromtemp!)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM-dd-yyyy"
        let dateString2 = dateFormatter2.string(from: bookingToTemp!)

        bookingNameLabel.text = bookingNameTemp
        
        bookingFromLabel.text = dateString1

        bookingToLabel.text = dateString2

        
        bookingCustNameLabel.text = bookingCustNameTemp
        
        
        bookingCustPhoneLabel.text = bookingCustPhoneTemp
        
        bookingCustAddressLabel.text = bookingCustAddTemp
        
        
        bookingOtherCustNameLabel.text = bookingOthercustNameTemp
        
        
        bookingRoomNameLabel.text = bookingRoomNameTemp
        
        bookingRoomTypeLabel.text = bookingRoomTypeTemp
        
        
        bookingRoomPriceLabel.text = bookingRoomPriceTemp
        
        
        
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
