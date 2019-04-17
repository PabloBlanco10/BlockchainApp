//
//  CCMainViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import MapKit

class CCMapViewController: CCBaseViewController {
    
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var mapMKView: MKMapView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
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
//        CCVehicleManager.sharedInstance.load()
        updatingLocation = false
        startLocationManager()
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
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.requestLocation()
                //make zoom to location
                let region = MKCoordinateRegion(center: mapMKView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    self.createFakeVehicles(region: region)
                    mapMKView.setRegion(mapMKView.regionThatFits(region), animated: true)
                }
            }
        }
    }
    
    func createFakeVehicles (region: MKCoordinateRegion) {
        for i in 0...30 {
            CCVehicleManager.sharedInstance.vehicles.append(CCVehicle(id: i, address: "Ejemplo \(i) ", latitude: region.center.latitude + Double.random(in: -0.1...0.1) , longitude: region.center.longitude + Double.random(in: -0.1...0.1)))
        }
        CCVehicleManager.sharedInstance.save()
        self.mapMKView.addAnnotations(CCVehicleManager.sharedInstance.vehicles)
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
    }
}


extension CCMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("******* Error en Core Location *******")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if error == nil {
                var address = "Not determined"
                
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    self.mapMKView.setRegion(self.mapMKView.regionThatFits(region), animated: true)
                    self.mapMKView.showsUserLocation = true
                    self.updatingLocation = false
                }
                
                if let placemark = placemarks?.last {
                    address = self.stringFromPlacemark(placemark: placemark)
                    self.createFakeVehicles(region: region)
                }
                print(address)
            }
        }
    }
}

extension CCMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
        annotationView.canShowCallout = true
        let image = UIImageView(image: #imageLiteral(resourceName: "spot"))
        image.setImageColor(color: UIColor.red)
        annotationView.image = image.image
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            
        }
    }
}
