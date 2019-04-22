//
//  CCVehicle.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import MapKit

class CCVehicle: NSObject, NSCoding{
    
    let vehicleAddres : String
    let vehicleLatitude : Double
    let vehicleLongitude : Double
    let id : Int

    init(id : Int, address: String, latitude: Double, longitude: Double) {
        self.vehicleAddres = address
        self.vehicleLatitude = latitude
        self.vehicleLongitude = longitude
        self.id = id
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        let vehicleAddress = aDecoder.decodeObject(forKey:"vehicleAddress") as! String
        let vehicleLatitude = aDecoder.decodeDouble(forKey:"vehicleLatitude")
        let vehicleLongitude = aDecoder.decodeDouble(forKey:"vehicleLongitude")
        let vehicleId = aDecoder.decodeInteger(forKey:"vehicleId")

        self.init(id:vehicleId, address: vehicleAddress, latitude: vehicleLatitude, longitude: vehicleLongitude)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.vehicleAddres, forKey: "vehicleAddress")
        aCoder.encode(self.vehicleLatitude, forKey: "vehicleLatitude")
        aCoder.encode(self.vehicleLongitude, forKey: "vehicleLongitude")
        aCoder.encode(self.vehicleLongitude, forKey: "vehicleId")
    }
}

extension CCVehicle: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: vehicleLatitude, longitude: vehicleLongitude)
        }
    }
    
    var title: String? {
        get {
            let random = Int.random(in: 0 ..< 9999)
            let letters = "BCDFGHJKLMNPQRSTVWXYZ"
            let plate = "\(random)" + "\(letters.randomElement()!)" + "\(letters.randomElement()!)" + "\(letters.randomElement()!)"
            return "\(plate)"
        }
    }
    
    var subtitle: String? {
        get {
            return ""
        }
    }
}

