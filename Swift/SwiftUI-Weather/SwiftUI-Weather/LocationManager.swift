//
//  LocationManager.swift
//  SwiftUI-Weather
//
//  Created by Benjamin Bauten on 15/04/2021.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    private var locationStatus: CLAuthorizationStatus?
    @Published var locationCityName: String = "47574"
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorized Always"
        case .restricted: return "restricted"
        case .denied: return "denied"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)
    }
    func convertCoordinatesToPostCode(){

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: Double(self.lastLocation?.coordinate.latitude ?? 0), longitude: Double(self.lastLocation?.coordinate.longitude ?? 0))

        geoCoder.reverseGeocodeLocation(location, completionHandler:
                    {
                        placemarks, error -> Void in

                        // Place details
                        guard let placeMark = placemarks?.first else { return }

                        // City
                        if let city = placeMark.subAdministrativeArea {
                            self.locationCityName = city
                            print(city)
                        }
                })

    }
}
