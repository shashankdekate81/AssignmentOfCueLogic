//
//  imageDownloader.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 15/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import Foundation
import UIKit

class PendingOperations {
    
    lazy var downloadsInProgress = [NSIndexPath:NSOperation]()
    lazy var downloadQueue:NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = Download_Queue
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader: NSOperation {
    
    let productInfo:productData
    
    
    init(productInfo: productData) {
        self.productInfo = productInfo
    }
    
    
    override func main() {
        
        if self.cancelled {
            return
        }
        
        let imageData = NSData(contentsOfURL:NSURL(string: self.productInfo.productImgURL)!)
    
        if self.cancelled {
            return
        }
        
        if imageData?.length > 0 {
            self.productInfo.productImage = UIImage(data:imageData!)!
            self.productInfo.prodctImageDownloadState = .Downloaded
        }
        else
        {
            self.productInfo.productImage = UIImage()
        }
    }
    
}
