//
//  cartTableViewCell.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 14/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class cartTableViewCell: UITableViewCell {

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productVendorName: UILabel!
    @IBOutlet var productVendorAddress: UILabel!
    @IBOutlet var callVendor: UIButton!
    @IBOutlet var removeFromCart: UIButton!
    @IBOutlet var quantityCount: UILabel!
    
    var productDetail:productData?{
        didSet {
            if let productDetail = productDetail {
                productImage.image = productDetail.productImage
                productPrice.text = productDetail.price
                productName.text = productDetail.productName
                productVendorName.text = productDetail.vendorName
                productVendorAddress.text = productDetail.vendorAddress
                quantityCount.text = qty_Lbl + String(productDetail.productAddtoCartCount)
                self.setBorder()
            }
        }
    }
    
    func setBorder(){
        
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2.0
        
        self.callVendor.layer.borderWidth = 2.0
        self.callVendor.layer.borderColor = UIColor.grayColor().CGColor
        
        self.removeFromCart.layer.borderWidth = 2.0
        self.removeFromCart.layer.borderColor = UIColor.grayColor().CGColor
        
        self.productImage.layer.borderWidth = 3.0
        self.productImage.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
}
