//
//  LocationAddressVM.swift
//  Camel Gate
//
//  Created by wecancity on 19/09/2022.
//

import Foundation
import Combine
import CoreLocation

class LocationAddressVM : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //MARK: --- current location coordinates ---
    private let locationManager = CLLocationManager()
        @Published var locationStatus: CLAuthorizationStatus?
        @Published var lastLocation: CLLocation?
    
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
            case .notDetermined:
                locationManager.requestLocation()
                return "notDetermined"
            case .authorizedWhenInUse:
                locationManager.requestLocation()
                return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            default: return "unknown"
            }
        }
    
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
    }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            locationStatus = status
            print(#function, statusString)
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            lastLocation = location
            print(#function, location)
//            self.Currentlong = "\(location.coordinate.longitude)"
//            self.Currentlat = "\(location.coordinate.latitude)"
        }
    
    
    //MARK: --- get addres string from lat & long ---
    @Published var lat = ""
    @Published var long = ""
    @Published var Publishedaddress = ""

    func getAddressFromLatLon() {
//            var Address = ""
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(lat)")!           //21.228124
            let lon: Double = Double("\(long)")!          //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc) { placemarks, error in
                            if (error != nil)
                            {
                                print("reverse geodcode fail: \(error!.localizedDescription)")
                            }
                             let pm = placemarks! as [CLPlacemark]
                            if pm.count > 0 {
                                let pm = placemarks![0]
            
                                var addressString : String = ""
                                if pm.subLocality != nil {
                                    addressString = addressString + pm.subLocality! + ", "
                                }
                                if pm.thoroughfare != nil {
                                    addressString = addressString + pm.thoroughfare! + ", "
                                }
                                if pm.locality != nil {
                                    addressString = addressString + pm.locality! + ", "
                                }
                                if pm.country != nil {
                                    addressString = addressString + pm.country! + ", "
                                }
                                if pm.postalCode != nil {
                                    addressString = addressString + pm.postalCode! + " "
                                }
                                print(addressString)
//                                Address = addressString
                                self.Publishedaddress = addressString
                                Helper.setUseraddress(CurrentAddress: addressString)
                          }
        }
//        return Address
        }
}
