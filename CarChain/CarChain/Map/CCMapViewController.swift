//
//  CCMainViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa
import RxSwift

class CCMapViewController: CCBaseViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var viewModel : CCMapViewModel?
    
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var mapMKView: MKMapView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var rentedCarView: UIView!
    @IBOutlet weak var carRentedIdLabel: UILabel!
    @IBOutlet weak var returnCarButton: UIButton!
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
        updatingLocation = false
        bindViewModel()
        setStyles()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setup(){
        requestLocationManager()
        mapMKView.delegate = self
        mapMKView.showsUserLocation = true
        mapMKView.addAnnotations(CCVehicleManager.sharedInstance.vehicles)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func bindViewModel() {
        _ = viewModel?.rentedCarViewHidden.asObservable().bind(to: rentedCarView.rx.isHidden)
        _ = returnCarButton.rx.tap.subscribe(){value in self.viewModel?.returnCar()}
        _ = getLocationButton.rx.tap.subscribe(){value in self.zoomIn()}
    }
    
    func setStyles(){
        returnCarButton.addShadow(UIColor.black, 0.8, 0, 2)
        returnCarButton.backgroundColor = k.CCCOLORGREEN
        returnCarButton.layer.cornerRadius = 8
    }
    
    func setRegion(_ region: MKCoordinateRegion) {
        createFakeVehicles(region: region)
        mapMKView.setRegion(mapMKView.regionThatFits(region), animated: true)
        updatingLocation = false
        locationManager.stopUpdatingLocation()
    }

    func zoomIn() {
        if CLLocationManager.locationServicesEnabled() {
            updatingLocation = true
            let region = MKCoordinateRegion(center: mapMKView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                setRegion(region)
            }
        }
    }
    
    func requestLocationManager() {
        let authLocationStatus = CLLocationManager.authorizationStatus()
        switch authLocationStatus {
        case .denied, .restricted:  showLocationServicesDeniedAlert()
        case .notDetermined:  zoomIn()
        default: zoomIn()
        }
    }
    
    func createFakeVehicles (region: MKCoordinateRegion) {
        for i in 0...30 {
            CCVehicleManager.sharedInstance.vehicles.append(CCVehicle(id: i, address: "Ejemplo \(i) ", latitude: region.center.latitude + Double.random(in: -0.1...0.1) , longitude: region.center.longitude + Double.random(in: -0.1...0.1)))
        }
        CCVehicleManager.sharedInstance.save()
        mapMKView.addAnnotations(CCVehicleManager.sharedInstance.vehicles)
    }
    
    func showLocationServicesDeniedAlert() {
        UIAlertController(title: "Location not allowed", message: "Please activate location on Settings", preferredStyle: .alert).show()
    }
    
    //CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("******* Error en Core Location *******")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        setRegion(region)
    }
    
    //    MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
        annotationView.canShowCallout = true
        let image = UIImageView(image: #imageLiteral(resourceName: "spot"))
        image.setImageColor(color: UIColor.red)
        annotationView.image = image.image
        annotationView.rightCalloutAccessoryView = UIButton(type: .contactAdd)
        annotationView.rightCalloutAccessoryView?.tintColor = k.CCCOLORGREEN
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print((view.annotation as! CCVehicle).id)
        viewModel?.rentCar()
    }
    
    /////////////////////////////
    func stringFromPlacemark (placemark: CLPlacemark) -> String {
        if let thoroughfare = placemark.thoroughfare, let subThoroughfare = placemark.subThoroughfare{
            return thoroughfare + ", " + subThoroughfare
        }
        else {
            return " "
        }
    }
}
