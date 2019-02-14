//
//  UIViewControllerExtension.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/31/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    ///Using the update image method to fetch HD image and update it in the Apod View Holder
    ///The viewData contains imageView to be updated
    func updateImage(with viewData:ApodViewHolder, isHd:Bool) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = ApodUrlConstants.host
        urlComponents.path = ApodUrlConstants.path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: ApodUrlConstants.key)
        ]
        
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        //Using our network manager singleton to fetch response data and see for any errors
        NetworkManager.shared.getApodData(from: url) { (apodResponseData, error) in
            if error != nil {
                self.setupErrorView(with: viewData)
                return
            }
            guard let responseData = apodResponseData else {
                self.setupErrorView(with: viewData)
                return
            }
            let imageUrl:String? = isHd ? responseData.hdurl : responseData.url
            guard let downloadUrl = imageUrl else {
                self.setupErrorView(with: viewData)
                return
            }
            
            //Using our downloadImage methon in network manager to download image and update
            //imageview and rest of the view holder elements
            NetworkManager.shared.downloadImage(url: URL(string: downloadUrl)!, completion: { (data, error) in
                DispatchQueue.main.async() {
                    viewData.imageView.image = UIImage(data: data!)
                    viewData.activityIndicator.isHidden = true
                    viewData.label?.text = responseData.title
                }
            })
        }
    }
    
    ///Helper Methods
    
    ///Helper method to only update the
    //imageview for when we already have a URL to download
    func updateImage(viewData:ApodViewHolder, url:String){
        guard let imageUrl = URL(string: url) else {
            self.setupErrorView(with: viewData)
            return }
        
        NetworkManager.shared.downloadImage(url: imageUrl, completion: { (data, error) in
            DispatchQueue.main.async() {
                viewData.imageView.image = UIImage(data: data!)
                viewData.activityIndicator.isHidden = true
            }
        })
    }
    
    ///Helper method to setup error state for when
    //we have issues getting to the server / image download
    func setupErrorView(with holder:ApodViewHolder) {
        DispatchQueue.main.async() {
            holder.activityIndicator.isHidden = true
            holder.label?.text = ApodStringConstants.genericError
        }
    }
}
