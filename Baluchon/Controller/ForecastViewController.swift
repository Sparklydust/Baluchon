//
//  ForecastViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController, CLLocationManagerDelegate {
  // Setting up CoreLocation
  let locationManager = CLLocationManager()
  
  @IBOutlet weak var topImage: UIImageView!
  @IBOutlet weak var topCityLabel: UILabel!
  @IBOutlet weak var topTemperatureLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var bottomImage: UIImageView!
  @IBOutlet weak var bottomCityLabel: UILabel!
  @IBOutlet weak var bottomTemperatureLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Setting up CoreLocation
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestAlwaysAuthorization()
    
    activityIndicator.isHidden = true
    
    // Swipe gesture to move between tab Bar
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(rightSwipe)
  }
  
  @IBAction func changeLocation(_ sender: UIButton) {
  }
}

//MARK: - Method to swipe between tab Bar
extension ForecastViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      self.tabBarController!.selectedIndex -= 1
    }
  }
}
