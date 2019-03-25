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
  let defaults = UserDefaults.standard

  private var latLongParams = [String: String]()
  private var bottomCityParams = [String: String]()

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
    locationManager.allowsBackgroundLocationUpdates = true

    activityIndicator.isHidden = true
    swapBetweenTabBars()
    showSavedBottomCity()
  }

  // Button that goes to User Preferences
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
      APIsRuler.shared.getLatLongForecast(
      lat: latitude, lon: longitude) { (success, weatherLatLonResult) in
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

  // Update the top user view when data comes back
  func updateTopUserView(with: WeatherResult) {
    topCityLabel.text! = with.city
    topCityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    topCityLabel.font = UIFont(name: "SnellRoundhand-Black", size: 37)
    topTemperatureLabel.text! = "\(Int(with.temperature))℃"
    topImage.image = UIImage(named: with.weatherCondition)
  }

  // Update the bottom user view when data comes back
  func updateBottomUserView(with: WeatherResult) {
    bottomCityLabel.text! = with.city
    bottomTemperatureLabel.text! = "\(Int(with.temperature))℃"
    bottomImage.image = UIImage(named: with.weatherCondition)
  }

  // Show alert in case data can not be retrieve from network
  func presentAlert() {
    let alertVC = UIAlertController(
      title: "Error",
      message: "Sorry, there was an error loading data",
      preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }

  // Handle error if there are no coordianates found
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    topCityLabel.text = "Location Service Off"
    topCityLabel.textColor = UIColor(
      red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    topCityLabel.font = UIFont(
      name: "HelveticaNeue-Medium", size: 19.5)
    topImage.image = nil
    topTemperatureLabel.text! = ""
  }
}

//MARK: - Delegate of the ChangeCity protocol that brings user city preferences
extension ForecastViewController: ChangeCityDelegate {
  func userEnteredNewCityName(_ name: String) {
    bottomCityObserver(bottomCity: name)
    bottomCityParams = ["q": name]

    // Calling the api with a function here to get the weather
    activityIndicator.isHidden = false
    APIsRuler.shared.getCityForecast(city: name) {
      (success, weatherCityResult) in
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

  // Observe the state of the preferences user entry
  func bottomCityObserver(bottomCity: String) {
    if bottomCity.isEmpty == true {
      bottomCityLabel.text = ""
      bottomImage.isHidden = true
      bottomImage.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
      bottomTemperatureLabel.text = ""
    }
    else {
      bottomImage.isHidden = false
    }
  }

  func getUserFavoriteCity() -> String {
    return defaults.string(forKey: ForecastPreferencesVC.cityKey)!
  }
}

// Retrieve user saved city to pop up at launch if any
extension ForecastViewController {
  func setSavedUserCity(_ userFavoriteCity: String) {
    APIsRuler.shared.getCityForecast(city: userFavoriteCity) {
      (success, weatherCityResult) in
      self.activityIndicator.isHidden = true
      if success, let weatherCityResult = weatherCityResult {
        self.updateBottomUserView(with: weatherCityResult)
      }
      else {
        self.presentAlert()
      }
    }
  }

  func showSavedBottomCity() {
    if let byTheUser = defaults.string(
      forKey: ForecastPreferencesVC.cityKey) {
      if byTheUser.isEmpty == false {
        setSavedUserCity(byTheUser)
      }
    }
  }
}

//MARK: - Method used to swipe between tab Bar
extension ForecastViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      self.tabBarController!.selectedIndex -= 1
    }
  }

  func swapBetweenTabBars() {
    let rightSwipe = UISwipeGestureRecognizer(
      target: self, action: #selector(handleSwipes(_:)))
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(rightSwipe)
  }
}
