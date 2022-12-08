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

    @Published var Currentlong: Double?
    @Published var Currentlat: String?
    
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
            DispatchQueue.main.async { [self] in
                locationStatus = status
            }
            print(#function, statusString)
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            lastLocation = location
            print(#function, location)
            
            self.Currentlong = locations.last?.coordinate.longitude
            self.Currentlat = "\(location.coordinate.latitude)"
        }
    
    
    //MARK: --- get addres string from lat & long ---
    @Published var lat = ""
    @Published var long = ""
    @Published var Publishedaddress = ""

    func getAddressFromLatLon(completion: @escaping (String) -> Void) {
//            var Address = ""
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(lat)") ?? Double(lastLocation?.coordinate.latitude ?? 0 )          //21.228124
        let long: Double = Double("\(long)") ?? Double(lastLocation?.coordinate.longitude ?? 0)     //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = long
        
        
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let location = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)

        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                   
                   // check for errors
                   guard let placeMarkArr = placemarks else {
                       completion("")
                       debugPrint(error ?? "")
                       return
                   }
                   // check placemark data existence
                   
                   guard let placemark = placeMarkArr.first, !placeMarkArr.isEmpty else {
                       completion("")
                       return
                   }
                   // create address string
                   
                   let outputString = [placemark.locality,
                                       placemark.subLocality,
//                                       placemark.thoroughfare,
//                                       placemark.postalCode,
//                                       placemark.subThoroughfare,
                                       placemark.country].compactMap { $0 }.joined(separator: ", ")
            print(placemark.locality ?? "1") // subcity
            print(placemark.subLocality ?? "2") // village
            print(placemark.thoroughfare ?? "3")
            print(placemark.subThoroughfare ?? "4")
            print(placemark.country ?? "5") //country
                   completion(outputString)

               })
        
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//        ceo.reverseGeocodeLocation(loc) { placemarks, error in
//                            if (error != nil)
//                            {
//                                print("reverse geodcode fail: \(error!.localizedDescription)")
//                            }
//                             let pm = placemarks! as [CLPlacemark]
//                            if pm.count > 0 {
//                                let pm = placemarks![0]
//
//                                var addressString : String = ""
//                                if pm.subLocality != nil {
//                                    addressString = addressString + pm.subLocality! + ", "
//                                }
//                                if pm.thoroughfare != nil {
//                                    addressString = addressString + pm.thoroughfare! + ", "
//                                }
//                                if pm.locality != nil {
//                                    addressString = addressString + pm.locality! + ", "
//                                }
//                                if pm.country != nil {
//                                    addressString = addressString + pm.country! + ", "
//                                }
//                                if pm.postalCode != nil {
//                                    addressString = addressString + pm.postalCode! + " "
//                                }
//                                print(addressString)
////                                Address = addressString
//                                self.Publishedaddress = addressString
//                                Helper.setUseraddress(CurrentAddress: addressString)
//                          }
//        }
//        return Address
        }
    
//    func getAddressFromLatLon() {
////            var Address = ""
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//            let lat: Double = Double("\(lat)")!           //21.228124
//            let lon: Double = Double("\(long)")!          //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//        ceo.reverseGeocodeLocation(loc) { placemarks, error in
//                            if (error != nil)
//                            {
//                                print("reverse geodcode fail: \(error!.localizedDescription)")
//                            }
//                             let pm = placemarks! as [CLPlacemark]
//                            if pm.count > 0 {
//                                let pm = placemarks![0]
//
//                                var addressString : String = ""
//                                if pm.subLocality != nil {
//                                    addressString = addressString + pm.subLocality! + ", "
//                                }
//                                if pm.thoroughfare != nil {
//                                    addressString = addressString + pm.thoroughfare! + ", "
//                                }
//                                if pm.locality != nil {
//                                    addressString = addressString + pm.locality! + ", "
//                                }
//                                if pm.country != nil {
//                                    addressString = addressString + pm.country! + ", "
//                                }
//                                if pm.postalCode != nil {
//                                    addressString = addressString + pm.postalCode! + " "
//                                }
//                                print(addressString)
////                                Address = addressString
//                                self.Publishedaddress = addressString
//                                Helper.setUseraddress(CurrentAddress: addressString)
//                          }
//        }
////        return Address
//        }
}

