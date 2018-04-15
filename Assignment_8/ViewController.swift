//
//  ViewController.swift
//  Assignment_8
//
//  Created by Nikunj Singh on 3/24/18.
//  Copyright © 2018 Nikunj Singh. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate {
    
    
    
   
    

    @IBOutlet weak var roomNameTextField: UITextField!
    
    @IBOutlet weak var roomPriceTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var custIdTextField: UITextField!
    
    @IBOutlet weak var custNameTextField: UITextField!
    @IBOutlet weak var custPhoneTextField: UITextField!
    @IBOutlet weak var custAddressTextField: UITextField!
    
    @IBOutlet weak var bookingNameTextField: UITextField!
    
   
    @IBOutlet weak var bookingCustNameTextField: UITextField!
    
    
    @IBOutlet weak var bookingRoomNameTextField: UITextField!
    
    @IBOutlet weak var bookingOtherCustNameTextField: UITextField!
    
    
    
    @IBOutlet weak var bookingFromDPicker: UIDatePicker!
    
    
    @IBOutlet weak var bookingToDPicker: UIDatePicker!
    
    
    
    
    
    @IBAction func toHotelComparisonFunc(_ sender: UIButton) {
        
        
          performSegue(withIdentifier: "toHotelComp", sender: self)
        
        
    }
    
    @IBAction func toCreateLfunc(_ sender: UIBarButtonItem) {
        
        
        let temp = bookingRoomNameTextField.text!
        
        
        for r in roomArraydata {
            if (r.roomName == temp ){
                
                if (r.roomType == "Single"){
                    
                    bookingRoomNameGlobal = temp
                    
                    bookingOtherCustNameGlobal = "N/A"
                    
                    roomObject = r
                    
                    
                    performSegue(withIdentifier: "noOtherCustS", sender: self)
                    
                    
                    
                    
//                    let createBook4VC = CreateBook4ViewController(nibName: "CreateBook4", bundle: nil)
//
//                    self.present(createBook4VC, animated: true, completion: nil)
                    
                } else if (r.roomType == "Double"){
                    
                    bookingRoomNameGlobal = temp
                    
                    roomObject = r
                    
                    
                    performSegue(withIdentifier: "otherCustS", sender: self)
                    
                    
                    
                    
//                    let createBook3VC = CreateBook3ViewController(nibName: "CreateBook3", bundle: nil)
//
//                    self.present(createBook3VC, animated: true, completion: nil)
//
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        

    }
    
    
    
    
    @IBAction func lastFuncBook(_ sender: UIBarButtonItem) {
        
        let temp = bookingOtherCustNameTextField.text!
        
        for c in custArraydata {
            
            if(c.custName == temp) {
                
                bookingOtherCustNameGlobal = temp
                
                
                
                performSegue(withIdentifier: "book4", sender: self)
                
                
//                let createBook4VC = CreateBook4ViewController(nibName: "CreateBook4", bundle: nil)
//
//                self.present(createBook4VC, animated: true, completion: nil)
//
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func toCreateBook2(_ sender: UIBarButtonItem) {
        
        let temp = bookingCustNameTextField.text!
        
        for c in custArraydata {
            if (temp == c.custName) {
                
                custObject = c
                
                bookingNameGlobal=bookingNameTextField.text!

                
                performSegue(withIdentifier: "book2S", sender: self)
                
                
                
            }
        }
        
    }
    
    
    var temp:String = "Single"

    
    @IBAction func roomTypeSegment(_ sender: UISegmentedControl) {
        

        switch sender.selectedSegmentIndex {
        case 0:
            print("1")
            temp = "Single"
        case 1:
            print("2")
            
            temp = "Double"
        default:
            print("3")
        }
        
        
        
    }
    
    
    
    
    @IBAction func addBookingLFunc(_ sender: UIButton) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        
        bookingFromDPicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM-dd-yyyy"
        let selectedDate = dateFormatter1.string(from: bookingFromDPicker.date)
        
        
        bookingToDPicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM-dd-yyyy"
        let selectedDate2 = dateFormatter2.string(from: bookingToDPicker.date)
        
        
        dateBookingFrom = dateFormatter.date(from: selectedDate)
        
        dateBookingTo = dateFormatter.date(from: selectedDate2)
        
        //
        //        let date1n = datePickerBookingFrom.date
        //
        //        let date2n = datePickerBookingTo.date
        
        let date1n = dateBookingFrom
        
        let date2n = dateBookingTo
        
        
        
        let tempRoomName = bookingRoomNameGlobal
        
        outer: for e in roomArraydata {
            if(e.roomName == tempRoomName) {
                
                if (date1n?.isBetweeen(date: e.roomFrom!, andDate: e.roomTo!))! || date2n?.isBetweeen(date: e.roomFrom!, andDate: e.roomTo!) == true {
                    
                    print("Room \(e.roomName!) already Booked for this Date")
                    
                    
                    let alertController = UIAlertController(title: "Warning!", message:
                        "Room \(e.roomName!) already Booked for this Date", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    break outer
                    
                } else if date1n == e.roomFrom!{
                    
                    
                    
                    print("Room \(e.roomName!) already Booked for this Day..")
                    
                    let alertController = UIAlertController(title: "Warning!", message:
                        "Room \(e.roomName!) already Booked for this Day..", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                    break outer
                    
                } else {
                    
                    print("Room \(e.roomName!) Booked, Moving On")
                    
                    //                    let booking = Booking()
                    //
                    //                    booking.bookingName = bookingNameGlobal
                    //
                    //                    booking.bokingOtherCust = bookingOtherCustNameGlobal
                    //
                    //                    booking.customerObj = custObject
                    //
                    //                    booking.roomObj = roomObject
                    //
                    //                    booking.roomObj.roomFrom! = date1n!
                    //                    booking.roomObj.roomTo! = date2n!
                    //
                    //                    bookArray.append(booking)
                    
                    
                    let book = Bookings(context: context)
                    
                    
                    book.bookingName = bookingNameGlobal
                    book.bookingOtherCust = bookingOtherCustNameGlobal
                    book.bookingFrom = date1n!
                    book.bookingTo = date2n!
                    
                    book.bookingCustName = custObject.custName
                    book.bookingCustPhone = custObject.custPhoneNumber
                    book.bookingCustAdd = custObject.custAddress
                    
                    book.bookingRoomName = roomObject.roomName
                    book.bookingRoomType = roomObject.roomType
                    book.bookingRoomPrice = roomObject.roomPrice
                    
                    
                    appDelegate.saveContext()
                    
                    
                    
                    
                    let alertController = UIAlertController(title: "Success!", message:
                        "Booking has been Added", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    performSegue(withIdentifier: "backToBookingListS", sender: self)

                    
                    break outer
                    
                    
                }
                
            } else {
                print("Loading...")
            }
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func AddImage(_ sender: UIButton) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing =  false
        self.present(image, animated: true){
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
        }else{
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func AddRoomFunc(_ sender: UIButton) {
        
        let room1obj = Room()
        
        let text = roomNameTextField.text!
        room1obj.roomName = text
        
        
        room1obj.roomType = temp
        
        
        let text3 = roomPriceTextField.text!
        room1obj.roomPrice = text3
        
        
        
        //        let text4 = textFieldRoomFrom.text!
        //        let text5 = textFieldRoomTo.text!
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        
        //        datePickerRoomFrom.datePickerMode = UIDatePickerMode.date
        //        let dateFormatter1 = DateFormatter()
        //        dateFormatter1.dateFormat = "MM-dd-yyyy"
        //        let selectedDate = dateFormatter1.string(from: datePickerRoomFrom.date)
        //
        //        datePickerRoomTo.datePickerMode = UIDatePickerMode.date
        //        let dateFormatter2 = DateFormatter()
        //        dateFormatter2.dateFormat = "MM-dd-yyyy"
        //        let selectedDate2 = dateFormatter2.string(from: datePickerRoomTo.date)
        //
        
        let selectedDate = "02-02-2000"
        
        let selectedDate2 = "02-02-2000"
        
        dateRoomFrom = dateFormatter.date(from: selectedDate)
        
        dateRoomTo = dateFormatter.date(from: selectedDate2)
        
        
        room1obj.roomFrom = dateRoomFrom
        room1obj.roomTo = dateRoomTo
        
        
        //        roomArray.append(room1obj)
        
        
        
        
        
        let roomtemp = Rooms(context: context)
        
        
        roomtemp.roomName = text
        
        roomtemp.roomType = temp
        
        roomtemp.roomPrice = text3
        
        roomtemp.roomFrom = dateRoomFrom
        
        roomtemp.roomTo = dateRoomTo
        
        let imageData = UIImagePNGRepresentation(imageView.image!)
        
        roomtemp.roomImage = imageData
        
        
        
        appDelegate.saveContext()
        
        
        let alertController = UIAlertController(title: "Success!", message:
            "Room Added", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    
        
        
        
        
    }
    
    
    @IBAction func createBookingFunc(_ sender: UIButton) {
         performSegue(withIdentifier: "createBookingS", sender: self)
        
    }
    
    @IBAction func createRoomFunc(_ sender: UIButton) {
        
        performSegue(withIdentifier: "createRoom", sender: self)
        
    }
    
    @IBAction func createCustFunc(_ sender: UIButton) {
        
        performSegue(withIdentifier: "createCustBtn", sender: self)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            custArraydata = try context.fetch(Customers.fetchRequest())
            
            
        }catch {
            
        }
        
        
        do {
            roomArraydata = try context.fetch(Rooms.fetchRequest())
            
        }
        catch {
            
            //handle
            
        }
        
        
        
        
        
        
        
        
        
        
        self.hideKeyboard()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkInt(string: String) -> Bool {
        
        return Int(string) != nil
    }
    
    
    
    
    func checkDigit(string: String) -> Bool {
        
        
        if string.utf16.count < 10 || string.utf16.count > 10 {
            
            return false
        }
        return true
    }
    
    
    @IBAction func createCustButton(_ sender: UIButton) {
        
        
        if (checkInt(string: custPhoneTextField.text!) == true) && (checkDigit(string: custPhoneTextField.text!) == true) {
            let customer1obj = Customer()
            
            let text = custNameTextField.text!
            customer1obj.custName = text
            
            
            let text2 = custPhoneTextField.text!
            customer1obj.custPhoneNumber = text2
            
            
            let text3 = custAddressTextField.text!
            customer1obj.custAddress = text3
            
            
            let text4 = custIdTextField.text!
            customer1obj.custIdNum = text4
            
            
            custArray.append(customer1obj)
            
            
            let custemp = Customers(context: context)
            
            custemp.custName = text
            custemp.custPhoneNumber = text2
            custemp.custAddress = text3
            custemp.custId = text4
            
            appDelegate.saveContext()
            
            
            
            
            let alertController = UIAlertController(title: "Success!", message:
                "Customer Added", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            
            let alertController = UIAlertController(title: "Warning!", message:
                "Only Integers for Numbers and 10 Digits", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
        
    }
    

}


class Customer {
    
    var custIdNum:String?
    var custName:String?
    var custPhoneNumber:String?
    var custAddress:String?
    
}


class Room {
    
    var roomName:String?
    var roomType:String?
    var roomPrice:String?
    var roomFrom:Date?
    var roomTo:Date?
    
}



class Booking {
    
    var bookingName:String?
    var bokingOtherCust:String?
    
    var customerObj = Customer()
    var roomObj = Room()
    
}




var custObject = Customers()
var roomObject = Rooms()

var dateRoomFrom:Date?
var dateRoomTo:Date?

var dateBookingFrom:Date?
var dateBookingTo:Date?


//var custArray: [Customer] = [Customer]()
//var roomArray: [Room] = [Room]()
//var bookArray: [Booking] = [Booking]()

var custArraydata = [Customers]()
var roomArraydata = [Rooms]()
var bookArraydata = [Bookings]()


var custArray: [Customer] = [Customer]()
var roomArray: [Room] = [Room]()
var bookArray: [Booking] = [Booking]()



var bookingNameGlobal:String?
var bookingOtherCustNameGlobal:String?
var bookingRoomNameGlobal:String?
var bookingRoomTypeGlobal:String?

var searchCustNameTypeGlobal:String?


extension Date{
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        
        return date1.compare(self) == self.compare(date2 as Date)
        
    }
    
}


extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


