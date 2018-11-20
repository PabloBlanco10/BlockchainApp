//
//  CCMainViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import MapKit

class CCMainViewController: UIViewController {

    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var mapMKView: MKMapView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var updatingLocation = false {
        didSet{
            if updatingLocation {
                getLocationButton.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                activityIndicatorView.isHidden = false
                activityIndicatorView.startAnimating()
                getLocationButton.isUserInteractionEnabled = false
            }
            else {
                getLocationButton.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                activityIndicatorView.isHidden = true
                activityIndicatorView.stopAnimating()
                getLocationButton.isUserInteractionEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CCVehicleManager.sharedInstance.load()
        updatingLocation = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapMKView.delegate = self
        self.mapMKView.addAnnotations(CCVehicleManager.sharedInstance.vehicles)
    }
    
    @IBAction func buttonLocationAction(_ sender: UIButton) {
        startLocationManager()
    }
    
    func startLocationManager() {
        let authLocationStatus = CLLocationManager.authorizationStatus()
        
        switch authLocationStatus {
        case .denied, .restricted:
            showLocationServicesDeniedAlert()
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        default:
            if CLLocationManager.locationServicesEnabled() {
                self.updatingLocation = true
                self.addButton.isEnabled = false
                
                self.locationManager.delegate = self
                
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.requestLocation()
                
                //make zoom to location
                let region = MKCoordinateRegion(center: mapMKView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    mapMKView.setRegion(mapMKView.regionThatFits(region), animated: true)
                }
            }
        }
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location not allowed", message: "Please activate location on Settings", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func stringFromPlacemark (placemark: CLPlacemark) -> String {
        if let thoroughfare = placemark.thoroughfare, let subThoroughfare = placemark.subThoroughfare{
            return thoroughfare + ", " + subThoroughfare
        }
        else {
            return " "
        }
//        placemark.locality
//        placemark.administrativeArea
//        placemark.country
    }
    
}


extension CCMainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("******* Error en Core Location *******")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        
        //create new item ?
//        newLocation.coordinate.latitude
//        newLocation.coordinate.longitude
        
        geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if error == nil {
                var address = "Not determined"
                
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    self.mapMKView.setRegion(self.mapMKView.regionThatFits(region), animated: true)
                    self.mapMKView.showsUserLocation = true
                    self.updatingLocation = false
                    self.addButton.isEnabled = true
                }
                
                if let placemark = placemarks?.last {
                    address = self.stringFromPlacemark(placemark: placemark)
                    CCVehicleManager.sharedInstance.vehicles.append(CCVehicle(address: address, latitude: region.center.latitude, longitude: region.center.longitude))
                }
                print(address)
            }
        }
    }
}

extension CCMainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "vehiclePin")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "vehiclePin")
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "img_pin")
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            
        }
    }
}
