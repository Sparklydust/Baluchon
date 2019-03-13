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
  
  var latLongParams = [String: String]()
  var topCityParams = [String: String]()
  var bottomCityParams = [String: String]()
  
  @IBOutlet weak var topImage: UIImageView!
  @IBOutlet weak var topCityLabel: UILabel!
  @IBOutlet weak var topTemperatureLabel: UILabel!
  @IBOutlet weak var preferencesButton: UIButton!
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
      
      let latitude = "\(location.coordinate.latitude)"
      let longitude = "\(location.coordinate.longitude)"
      
      latLongParams = ["lat": latitude, "lon": longitude]
      
      // Calling the apito get the weather forecast with coordinates
      activityIndicator.isHidden = false
      APIsRuler.shared.getLatLongForecast(lat: latitude, lon: longitude) { (success, weatherLatLonResult) in
        self.activityIndicator.isHidden = true
        if success, let weatherLatLonResult = weatherLatLonResult {
          self.updateTopUserView(with: weatherLatLonResult)
        }
        else {
          self.presentAlert()
        }
      }
    }
  }
  
  // update the top user view when data comes back
  func updateTopUserView(with: WeatherResult) {
    topCityLabel.text! = with.city
    topTemperatureLabel.text! = "\(Int(with.temperature))℃"
    topImage.image = UIImage(named: with.weatherCondition)
  }
  
  // update the bottom user view when data comes back
  func updateBottomUserView(with: WeatherResult) {
    bottomCityLabel.text! = with.city
    bottomTemperatureLabel.text! = "\(Int(with.temperature))℃"
    bottomImage.image = UIImage(named: with.weatherCondition)
  }
  
  // show alert in case data can not be retrieve from network
  func presentAlert() {
    let alertVC = UIAlertController(title: "Error", message: "Sorry, there was an error loading data", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  // Handle error if there are no coordianates found
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    topCityLabel.text = "Unavailable"
    topImage.image = nil
    topTemperatureLabel.text = nil
  }
}

//MARK: - Delegate of the ChangeCity protocol that brings user city preferences
extension ForecastViewController: ChangeCityDelegate {
  func userEnteredNewCityName(top: String, bottom: String) {
    topCityObserver(topCity: top)
    bottomCityObserver(bottomCity: bottom)
    
    topCityParams = ["q": top]
    bottomCityParams = ["q": bottom]
    
    // Calling the api with a function here to get the weather
    activityIndicator.isHidden = false
    APIsRuler.shared.getCityForecast(city: bottom) { (success, weatherCityResult) in
      self.activityIndicator.isHidden = true
      if success, let weatherCityResult = weatherCityResult {
        self.updateBottomUserView(with: weatherCityResult)
      }
      else {
        self.presentAlert()
      }
    }
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

//MARK: - Method to swipe between tab Bar
extension ForecastViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      self.tabBarController!.selectedIndex -= 1
    }
  }
}
