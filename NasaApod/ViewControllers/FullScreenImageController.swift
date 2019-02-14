//
//  FullScreenImageController.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/31/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import Foundation
import UIKit

//This protocol is necessary for when we want to show the label coming back from the Full Screen Image View 
protocol FullScreenImageControllerDelegate {
    func labelVisibility(shouldHide:Bool)
}

class FullScreenImageController: UIViewController {
    
    @IBOutlet weak var apodFullScreenActivityLoader: UIActivityIndicatorView!
    @IBOutlet weak var apodFullScreenImageView: UIImageView!
    var cachedImage:UIImage?
    var transitionController:NBNavigationController?
    var delegate: FullScreenImageControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///We setup the view with image if we already have a cached image
    ///If there is no cached image then we download an HD image
    func setup() {
        transitionController = NBNavigationController()
        let viewData = ApodViewHolder(imageView: apodFullScreenImageView,
                                      label: nil,
                                      activityIndicator: apodFullScreenActivityLoader)
        //Add Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        apodFullScreenImageView.addGestureRecognizer(tapGesture)
        apodFullScreenImageView.isUserInteractionEnabled = true
        
        if cachedImage != nil {
            apodFullScreenActivityLoader.isHidden = true
            apodFullScreenImageView.image = cachedImage
            return
        }else {
            updateImage(with: viewData, isHd: true)
        }
    }
    
    @objc func imageTapped() {
        dismissViewController()
    }
    
    ///Use custom NBNavigation controller to pop the view with custom transtion
    ///and also call the label visibity delegate so that we can show the label again
    func dismissViewController() {
        self.delegate?.labelVisibility(shouldHide: false)
        let customTransition = TopDownTransition(transitionDuration: ApodUIConstants.transitionDuration)
        transitionController?.popNavigationController(self.navigationController!, animatedTransition: customTransition)
    }
}
