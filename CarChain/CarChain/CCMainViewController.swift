//
//  CCMainViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import MapKit
import Web3


struct ContractResponse: Codable {
    let itemid: String?
}


class CCMainViewController: UIViewController {
    
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var mapMKView: MKMapView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    
    let managerAddress = try! EthereumAddress(hex: "0x711bb2cDfA7f6d3C2D4d2dd167E45D80A4Af1EfD", eip55: false)
    //        let contractAddress = try! EthereumAddress(hex: "0x711bb2cDfA7f6d3C2D4d2dd167E45D80A4Af1EfD", eip55: true)
    let contractJsonABI = "[{\"constant\":false,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"},{\"name\":\"_credit\",\"type\":\"uint256\"}],\"name\":\"registerNewUser\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"users\",\"outputs\":[{\"name\":\"id\",\"type\":\"uint256\"},{\"name\":\"credit\",\"type\":\"uint256\"},{\"name\":\"carId\",\"type\":\"uint256\"},{\"name\":\"registered\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"},{\"name\":\"_plate\",\"type\":\"string\"}],\"name\":\"registerNewCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"}],\"name\":\"getUserCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_carId\",\"type\":\"uint256\"},{\"name\":\"_userId\",\"type\":\"uint256\"}],\"name\":\"rentCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_carId\",\"type\":\"uint256\"},{\"name\":\"_userId\",\"type\":\"uint256\"}],\"name\":\"returnCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"cars\",\"outputs\":[{\"name\":\"id\",\"type\":\"uint256\"},{\"name\":\"plate\",\"type\":\"string\"},{\"name\":\"userId\",\"type\":\"uint256\"},{\"name\":\"registered\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"minimumRentCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]".data(using: .utf8)!
    
    
    let web3 = Web3(rpcURL: "https://rinkeby.infura.io/v3/911ffdd646fe4561820ce1c146be7250")
//    let contractAddress = try! EthereumAddress(hex: "0x526F5F06D6f1f9e63c6f344Ab5b160DE7b1eaCEa", eip55: true)
    let contractAddress = try! EthereumAddress(hex: "0x5a84615d6c15f7ebe72a32c02a4f251948024de9", eip55: false)

    
    
    //    let fakeVehicles = [MKAnnotation]()
    
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
        startLocationManager()
        
        
//        registerNewUser()
//        getMinimumRentCredit()

    }
    
    func getMinimumRentCredit(){
        let contract = try! web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)
        
        firstly {
            contract["users"]!(BigUInt(1)).call()
            }.done { hash in
                print(hash)
            }.catch { error in
                print(error)
        }
    }
    
    func registerNewUser(){
        
        let contract = try! web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)
        let myPrivateKey = try! EthereumPrivateKey(hexPrivateKey: "0F83EC16705DD8071481592816ABCFDF883A173F9293497C4EEDB33FFC6150CB")
        
        web3.eth.getBalance(address: myPrivateKey.address, block: try! .string("latest") ) { response in
            print("myAccount - result?.quantity(wei): ", response.result?.quantity as Any)
        }
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {
            response in print(response.result?.quantity as Any)
        }
        
        do {
            
            let c = contract["registerNewUser"]?(BigUInt(1), BigUInt(100))
            let transaction: EthereumTransaction = c!
                .createTransaction(nonce: 17,
                                   from: myPrivateKey.address,
                                   value: 0,
                                   gas: 210000,
                                   gasPrice: EthereumQuantity(quantity: 1.gwei))!
            
            let signedTx: EthereumSignedTransaction = try transaction.sign(with: myPrivateKey, chainId: 4)
            
            firstly {
                web3.eth.sendRawTransaction(transaction: signedTx)
                }.done { txHash in
                    print(txHash)
                }.catch { error in
                    print(error)
            }
            
        } catch {
            print(error)
        }
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
                let region = MKCoordinateRegionMakeWithDistance(mapMKView.userLocation.coordinate, 1000, 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    self.createFakeVehicles(region: region)
                    mapMKView.setRegion(mapMKView.regionThatFits(region), animated: true)
                }
            }
        }
    }
    
    func createFakeVehicles (region: MKCoordinateRegion) {
        for i in 0...100 {
            CCVehicleManager.sharedInstance.vehicles.append(CCVehicle(address: "Ejemplo \(i) ", latitude: region.center.latitude + Double.random(in: -0.1...0.1) , longitude: region.center.longitude + Double.random(in: -0.1...0.1)))
            
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
                
                let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1000, 1000)
                if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                    self.mapMKView.setRegion(self.mapMKView.regionThatFits(region), animated: true)
                    self.mapMKView.showsUserLocation = true
                    self.updatingLocation = false
                    self.addButton.isEnabled = true
                }
                
                if let placemark = placemarks?.last {
                    address = self.stringFromPlacemark(placemark: placemark)
                    self.createFakeVehicles(region: region)
                    //                    CCVehicleManager.sharedInstance.vehicles.append(CCVehicle(address: address, latitude: region.center.latitude, longitude: region.center.longitude))
                    //                    CCVehicleManager.sharedInstance.save()
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
        
        annotationView?.image = UIImage(named: "pin_car")
        
        // Resize image
        //        let pinImage = UIImage(named: "img_pin")
        //        let size = CGSize(width: 29.5, height: 36.5)
        //        UIGraphicsBeginImageContext(size)
        //        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        //        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        //
        //        annotationView?.image = resizedImage
        //
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            
        }
    }
    
    
    
}
