//
//  cartViewController.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 14/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class cartViewController: UIViewController {

    var arrSelectedProduct:[productData] = []
    var intialViewController:intialScreen?
    var totalToPay = 0

    @IBOutlet var cartTitle: UILabel!
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet var totalAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTitle.backgroundColor = UIColor.grayColor()
        self.totalAmount.backgroundColor = UIColor.yellowColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        intialViewController = self.tabBarController as? intialScreen
        arrSelectedProduct = (intialViewController?.arrSelectedProduct)!
        
        for product in arrSelectedProduct{
            totalToPay += (Int(product.price)! * product.productAddtoCartCount)
        }
        
        totalAmount.text = total_Lbl + String(totalToPay)
        
        cartTableView.reloadData()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        totalToPay = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callVendorAction(sender: AnyObject){
        
        let telPhoneNumber = tel_Prompt + arrSelectedProduct[sender.tag].phoneNumber
        
        if let phoneCallURL:NSURL = NSURL(string:telPhoneNumber) {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
        
    }
    
    func removeFromCartAction(sender: AnyObject){
        
        arrSelectedProduct[sender.tag].productAddtoCartCount = 0
        arrSelectedProduct.removeAtIndex(sender.tag)
        intialViewController?.arrSelectedProduct.removeAtIndex(sender.tag)
        totalToPay = 0
        
        for product in arrSelectedProduct{
            totalToPay += (Int(product.price)! * product.productAddtoCartCount)
        }
        
        totalAmount.text = total_Lbl + String(totalToPay)
        cartTableView.reloadData()
        
    }
   

}

extension cartViewController:UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectedProduct.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cart_TableViewCell, forIndexPath:indexPath) as! cartTableViewCell
        cell.productDetail = arrSelectedProduct[indexPath.row]
        
        cell.callVendor.tag = indexPath.item
        
        cell.callVendor.addTarget(self, action: #selector(cartViewController.callVendorAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.removeFromCart.tag = indexPath.item
        cell.removeFromCart.addTarget(self, action: #selector(cartViewController.removeFromCartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return cell
    }

}

extension cartViewController:UITableViewDelegate{


}
