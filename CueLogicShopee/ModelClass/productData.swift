//
//  productData.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class productData: NSObject {
    
    // Parsing Json Variable
    var phoneNumber:String = ""
    var price:String = ""
    var productName:String = ""
    var vendorAddress:String = ""
    var vendorName:String = ""
    var productImgURL:String = ""
    var productGallery:[String] = []
    
    // added to Cart related Variable
    var productAddtoCartCount:Int = 0
    
    //image Downloaded Variable
    var productImage:UIImage = UIImage()
    var prodctImageDownloadState:productPhotoState = productPhotoState.New
    

}
