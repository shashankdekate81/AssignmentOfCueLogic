//
//  productDataDownloader.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 15/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import Foundation

protocol dataDownloadStatus {
    func sucessInResponse(data:NSData)
    func errorInResponse(error:NSError)
}

class productDataDownloader{
    
    var delegate:dataDownloadStatus?
    
    
    func fetchProductList(requestedURL:String){
        
        let productListSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        var dataTask: NSURLSessionDataTask?
        
        
        let url = NSURL(string:requestedURL)
        
        dataTask = productListSession.dataTaskWithURL(url!) {
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue(), {
                if(data != nil && response != nil){
                    
                    if let httpResponse = response as? NSHTTPURLResponse {
                        
                        if(httpResponse.statusCode == 200){
                            
                            self.delegate?.sucessInResponse(data!)
                            
                        }else{
                            self.delegate?.errorInResponse(error!)
                        }
                        
                    }else{
                        self.delegate?.errorInResponse(error!)
                    }
                    
                    
                }else{
                    
                    self.delegate?.errorInResponse(error!)
                    
                }
            })
            
        }
        
        dataTask?.resume()
        
    }
    
    
}