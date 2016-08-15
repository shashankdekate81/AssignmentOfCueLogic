//
//  modelWrapper.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

@objc protocol modelWrapperDataDownloaderDelegate {
    optional func didRecieveSucessFullyResponse(data:NSData)
    optional func didReciveError(error:NSError)
}

@objc protocol modelWrapperImageDownloadDelegate{
    optional func didImageDownloadSucessFully(indexPath: NSIndexPath)
}


class modelWrapper: NSObject {
    
    static let sharedInstance = modelWrapper()
    private override init() {}
    
    private var jsonParserObj = jsonParser()
    private var internetCheckerObj = internetChecker()
    private var productDataDownloaderObj = productDataDownloader()
    private let pendingOperations = PendingOperations()
    
    var dataDownloadDelegate:modelWrapperDataDownloaderDelegate?
    var imageDownloadDelegate:modelWrapperImageDownloadDelegate?
    
    
    // MARK: jsonParserFunction
    func  modelWrapper_parseTheResponse(responseData:NSData) -> [productData] {
     let arrProductInfo:[productData] = jsonParserObj.parseTheResponse(responseData)
     return arrProductInfo
    }
    
    // MARK: Internet ConnectionChecker
    func modelWrapper_isConnectedToNetwork()->Bool{
        return internetCheckerObj.isConnectedToNetwork()
    }
    
    // MARK: Internet ConnectionChecker
    func modelWrapper_fetchProductList(requestedURL:String){
        productDataDownloaderObj.delegate = self
        productDataDownloaderObj.fetchProductList(requestedURL)
    }
    
    //MARK: Image downloader
    
    func modelWrapper_startImageDownloadForProduct(productDetails:productData, indexPath: NSIndexPath){
        
        if pendingOperations.downloadsInProgress[indexPath] != nil {
            return
        }
        
        let downloader = ImageDownloader(productInfo: productDetails)
        downloader.completionBlock = {
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.pendingOperations.downloadsInProgress.removeValueForKey(indexPath)
                self.imageDownloadDelegate?.didImageDownloadSucessFully!(indexPath)
            })
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
}
    


extension modelWrapper:dataDownloadStatus{

    func sucessInResponse(data:NSData){
        dataDownloadDelegate?.didRecieveSucessFullyResponse!(data)
    }
    
    func errorInResponse(error:NSError){
        dataDownloadDelegate?.didReciveError!(error)
    }

}
