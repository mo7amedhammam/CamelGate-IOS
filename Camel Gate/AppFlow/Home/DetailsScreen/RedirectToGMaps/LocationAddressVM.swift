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

                if status == .authorizedAlways || status == .authorizedWhenInUse{
                locationStatus = status
                    locationManager.startUpdatingLocation()
                }else{
                    locationManager.requestLocation()
                }
            }
            print(#function, statusString)
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
//            if lastLocation == nil || lastLocation!.distance(from: location) > 10{
            lastLocation = location
            print(#function, location)
            
            self.Currentlong = locations.last?.coordinate.longitude
            self.Currentlat = "\(location.coordinate.latitude)"
//            }
        }
    
    //MARK: --- get addres string from lat & long ---
    @Published var lat = ""
    @Published var long = ""
    @Published var Publishedaddress = ""

    func getAddressFromLatLon(completion: @escaping (String) -> Void) {
        let lat: Double = Double("\(lat)") ?? Double(lastLocation?.coordinate.latitude ?? 0 )          //21.228124
        let long: Double = Double("\(long)") ?? Double(lastLocation?.coordinate.longitude ?? 0)     //72.833770
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let location = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location,preferredLocale: Locale(identifier: Helper.getLanguage()) ,completionHandler: { (placemarks, error) -> Void in
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
                   let outputString = [
                    placemark.subLocality, // village
                    placemark.subAdministrativeArea, // subcity
                    placemark.administrativeArea, // city
                    placemark.country, // country
//                                      placemark.locality,    // subcity
//                                       placemark.thoroughfare,
//                                       placemark.postalCode,
//                                       placemark.subThoroughfare,
//                                       placemark.country
                   ].compactMap { $0 }.joined(separator: ", ")
            
//            print(placemark.locality ?? "1") // subcity
//            print(placemark.subLocality ?? "2") // village
//            print(placemark.thoroughfare ?? "3")
//            print(placemark.postalCode ?? "3")
//            print(placemark.subAdministrativeArea ?? "4")
//            print(placemark.administrativeArea ?? "4")
//            print(placemark.country ?? "5") //country
                   completion(outputString)

               })
        }
    
    
    //MARK: --- using googlemap ---
//    func getAddressForLatLng(latitude: String, longitude: String) {
//           let url = URL(string: "\(GbaseUrl)latlng=\(latitude),\(longitude)&key=\(Gapikey)")
//           let data = try! Data(contentsOf: url!)
//           let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
//           if let result = json["results"] as? [[String: Any]] {
//               if let address = result[0]["formatted_address"] as? String {
//                   print(address)
//               }
//           }
//       }
}

