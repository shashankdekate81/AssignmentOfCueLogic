//
//  jsonParser.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class jsonParser: NSObject {

    
    func parseTheResponse(responseData:NSData) -> [productData]{
        
        var arrProductInfo:[productData] = []
        
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions())
            
            let productArray = json[products_] as! NSArray
            
            for product in productArray{
                
                let productInfo:productData = productData()
                
                let phoneNumber = product[phone_Number] as! String
                if(!phoneNumber.isEmpty){
                    productInfo.phoneNumber = phoneNumber
                    print(productInfo.phoneNumber)
                }
                
                let price = product[price_] as! String
                if(!price.isEmpty){
                    productInfo.price = price
                    print(productInfo.price)
                }
                
                let productname = product[product_Name] as! String
                if(!productname.isEmpty){
                    productInfo.productName = productname
                }
                
                let vendoraddress = product[vendor_Address] as! String
                if(!vendoraddress.isEmpty){
                    productInfo.vendorAddress = vendoraddress
                }
                
                let vendorname = product[vendor_Name] as! String
                if(!vendorname.isEmpty){
                    productInfo.vendorName = vendorname
                }
                
                let productImg = product[product_Img] as! String
                if(!productImg.isEmpty){
                    productInfo.productImgURL = productImg
                }
                
                let productgallery = product[product_Gallery] as! NSArray
                if(productgallery.count > 0){
                    productInfo.productGallery = productgallery as! [String]
                }
                
                arrProductInfo.append(productInfo)
            }
            
        }catch  let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            abort()
        }
        
        return arrProductInfo
    }
    
}
