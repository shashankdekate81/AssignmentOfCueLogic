//
//  productDetailViewCell.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 14/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class productDetailViewCell: UICollectionViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productVendorName: UILabel!
    @IBOutlet var productVendorAddress: UILabel!
    @IBOutlet var addToCart: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var productDetail:productData?{
        didSet {
            if let productDetail = productDetail {
                productPrice.text = price_Lbl + productDetail.price
                productName.text = productDetail.productName
                productVendorName.text = productDetail.vendorName
                productVendorAddress.text = productDetail.vendorAddress
                productImage.image = productDetail.productImage
                
                switch productDetail.prodctImageDownloadState {
                case .New:
                    activityIndicator.hidden = false
                    activityIndicator.startAnimating()
                case .Downloaded:
                    activityIndicator.stopAnimating()
                    activityIndicator.hidden = true
                default:
                    print("Unexcepted behavior")
                }
                
                self.setBorder()
            }
        }
    }

    func setBorder(){
        
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2.0
        
        self.addToCart.layer.borderWidth = 2.0
        self.addToCart.layer.borderColor = UIColor.grayColor().CGColor
        
        self.productImage.layer.borderWidth = 3.0
        self.productImage.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
}
