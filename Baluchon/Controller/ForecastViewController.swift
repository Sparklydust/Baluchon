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
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let WEATHER_ID = ""
  
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
    locationManager.startUpdatingLocation()
    
    activityIndicator.isHidden = true
    
    // Swipe gesture to move between tab Bar
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(rightSwipe)
  }
  
  @IBAction func changeLocation(_ sender: UIButton) {
  }
}

//MARK: - Location Manager Delegate Methods
extension ForecastViewController {
  // Retrieve the GPS coordinates from CoreLocation
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      locationManager.delegate = nil
      
      print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
      
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      
      let coordinates: [String: String] = ["lat": latitude, "lon": longitude, "appid": WEATHER_ID]
      
      // TODO: Call the api with a function here to get the weather with the coordinates
    }
  }
  
  // Handle error if there are no coordianates found
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    topCityLabel.text = "Location Unavailable"
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

//MARK: - Delegate of the ChangeCity protocol
extension ForecastViewController: ChangeCityDelegate {
  func userEnteredNewCityName(top: String, bottom: String) {
    topCityObserver(topCity: top)
    bottomCityObserver(bottomCity: bottom)
    
    let topCityWeather: [String: String] = ["q": top, "appid": WEATHER_ID]
    let bottomCityWeather: [String: String] = ["q": bottom, "appid": WEATHER_ID]
    
    // TODO: Call the api with a function here to get the weather
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPreferences" {
      let destinationVC = segue.destination as! ForecastPreferencesVC
      destinationVC.delegate = self
    }
  }
  
  //TODO: Setup the weather state observer
  // Observe the state of the top and bottom user entry
  func topCityObserver(topCity: String) {
    if topCity.isEmpty == true {
      topCityLabel.text = "Coordinate"
    }
    else {
      topCityLabel.text = topCity
    }
  }
  
  func bottomCityObserver(bottomCity: String) {
    if bottomCity.isEmpty == true {
      bottomCityLabel.text = ""
      bottomImage.isHidden = true
      bottomImage.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
      bottomTemperatureLabel.text = ""
    }
    else {
      bottomCityLabel.text = bottomCity
    }
  }
}

