//
//  productViewController.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit

class productViewController: UIViewController {
    
    @IBOutlet var productCollectionView: UICollectionView!
    @IBOutlet var shopTitleLbl: UILabel!
    
    var arrProductInfo:[productData] = []
    var intialViewController:intialScreen?
    let pendingOperations = PendingOperations()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productCollectionView.backgroundColor = UIColor.whiteColor()
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        intialViewController = self.tabBarController as? intialScreen
        arrProductInfo = (intialViewController?.arrProductInfo)!
        
        self.shopTitleLbl.backgroundColor = UIColor.grayColor()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

    func addToCartButtonClicked(sender: AnyObject){
        
        if(arrProductInfo[sender.tag].productAddtoCartCount == 0){
            
            arrProductInfo[sender.tag].productAddtoCartCount += 1
            intialViewController!.arrSelectedProduct.append(arrProductInfo[sender.tag])
            
        }else{
            
            arrProductInfo[sender.tag].productAddtoCartCount += 1
            
        }
    
    }
    
    func startImageDownloadForProduct(productDetails:productData, indexPath: NSIndexPath){
        
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
                self.productCollectionView.reloadItemsAtIndexPaths([indexPath])
            })
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
}

extension productViewController:UICollectionViewDataSource{
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrProductInfo.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(product_Detail, forIndexPath: indexPath) as! productDetailViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        
        cell.productDetail = arrProductInfo[indexPath.item]
        
        cell.addToCart.tag = indexPath.item
        
        cell.addToCart.addTarget(self, action: #selector(productViewController.addToCartButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        switch arrProductInfo[indexPath.item].prodctImageDownloadState {
        case .New:
            startImageDownloadForProduct(arrProductInfo[indexPath.item], indexPath: indexPath)
        case .Downloaded:
            print("Donot Download")
        default:
            print("Unascepted behavior")
        }
    
        return cell
        
    }

}

extension productViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake((UIScreen.mainScreen().bounds.width - 30)/2,307);
    }

    
    

}

