//
//  ViewController.swift
//  CueLogicShopee
//
//  Created by Anupam Pahari on 13/08/16.
//  Copyright © 2016 Northzone. All rights reserved.
//

import UIKit
import SystemConfiguration

class customSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        modelWrapper.sharedInstance.dataDownloadDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        if(modelWrapper.sharedInstance.modelWrapper_isConnectedToNetwork()){
            modelWrapper.sharedInstance.modelWrapper_fetchProductList(requestedURL)
        }else{
            
            let alertController = UIAlertController(title: alert, message:no_Network_Msg, preferredStyle: .Alert)
            
            // Create the actions
            let settingsAction = UIAlertAction(title: settings, style: .Default) { (_) -> Void in
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            
            let cancelAction = UIAlertAction(title:close_App, style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                
                NSLog("Cancel Pressed")
                
                abort()
            }

            
            
            // Add the actions
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            
        
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension customSplashScreen:modelWrapperDataDownloaderDelegate{

    func didRecieveSucessFullyResponse(data:NSData){
        
        let arrProductInfo:[productData] = modelWrapper.sharedInstance.modelWrapper_parseTheResponse(data)
        
        let fristScreen = self.storyboard?.instantiateViewControllerWithIdentifier(tab_Bar) as! intialScreen
        fristScreen.arrProductInfo = arrProductInfo
        self.navigationController?.pushViewController(fristScreen, animated: false)
    
    }
    
    func didReciveError(error:NSError){
        
        let alertController = UIAlertController(title: alert, message:fetch_Error_Msg, preferredStyle: .Alert)
        
        // Create the actions
        
        let retryAction = UIAlertAction(title: retry, style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            modelWrapper.sharedInstance.modelWrapper_fetchProductList(requestedURL)
        }
        
        let cancelAction = UIAlertAction(title: close_App, style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            
            NSLog("Cancel Pressed")
            
            abort()
        }
        
        // Add the actions
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        
        // add alert View Controller
    
    }

}

