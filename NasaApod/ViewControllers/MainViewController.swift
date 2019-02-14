//
//  ViewController.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/30/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var apodLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var apodLabel: UILabel!
    var tapGesture:UITapGestureRecognizer?
    var transitionController:NBNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Initilizes the NB Navigation Controller for custom transtion.
    ///Fetches new image from the NASA APOD api and updates the view components
    func setup() {
        transitionController = NBNavigationController()
        let viewData = ApodViewHolder(imageView: self.apodImageView,
                     label: self.apodLabel,
                     activityIndicator: self.apodLoadingIndicator)
        updateImage(with: viewData, isHd: false)

        //Add Tap Gesture to make imageview tapable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        apodImageView.addGestureRecognizer(tapGesture)
        apodImageView.isUserInteractionEnabled = true

    }
    
    @objc func imageTapped() {
        guard apodLoadingIndicator.isHidden else { return }
        guard apodLabel.text != ApodStringConstants.genericError else { return }
        //Fade the label
        labelVisibility(shouldHide: true)
        //Present view via custom transition
        self.presentFullScreenView()
    }
    
    //Custom transtion to present view
    func presentFullScreenView() {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenImageController") as! FullScreenImageController
        viewController.cachedImage = apodImageView.image
        viewController.delegate = self
        let customTransition = BottomUpTransition(transitionDuration: ApodUIConstants.transitionDuration)
        transitionController?.pushViewController(viewController, ontoNavigationController: self.navigationController!, animatedTransition: customTransition)
    }
}

//This protocol was necessary for when we want to show the label coming back from the Full Screen Image View
extension MainViewController: FullScreenImageControllerDelegate {
    
    func labelVisibility(shouldHide:Bool) {
        UIView.animate(withDuration: ApodUIConstants.transitionDuration, animations: {
            self.apodLabel.alpha = shouldHide ? 0 : 1
        })
    }
}
