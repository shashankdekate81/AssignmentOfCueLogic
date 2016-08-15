//
//  File.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import Foundation

let requestedURL = "https://mobiletest-hackathon.herokuapp.com/getdata/"

enum productPhotoState {
    case New,Downloaded,Failed
}

// MARK : Parser Constant

let products_ = "products"
let phone_Number = "phoneNumber"
let price_ = "price"
let product_Name = "productname"
let vendor_Address = "vendoraddress"
let vendor_Name = "vendorname"
let product_Img = "productImg"
let product_Gallery = "productGallery"

// MARK : Parser Constant

let Download_Queue = "Download queue"

let price_Lbl = "Price : "

let product_Detail = "productDetail"

let cart_TableViewCell = "cartTableViewCell"

let total_Lbl = "Total : "

let tel_Prompt = "telprompt://"

let qty_Lbl = "Qty : "

// Alert Constant

let alert = "Alert"
let retry = "Retry"
let fetch_Error_Msg = "Error occur while Fetching the Product List "
let close_App = "Close the apps"
let tab_Bar = "tabBar"
let settings = "Settings"
let no_Network_Msg = "Please Your Wifi/network Setting"



