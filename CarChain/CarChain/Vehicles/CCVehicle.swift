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
    
    static let vehiclePlates = ["2353HYP", "5432TPK", "0975KPF", "0156GGG", "1234SWD", "5678DSB", "1100JKL", "3436ZJF", "3356MNB", "0987HJK", "4400TPS", "1234DDD", "4326JKL", "9865WQL", "7863RFL", "4356HSZ", "4388PPT", "6789BBB"]
//    , "3324VCB", "1198YZX", "0000PLK", "3356VBV", "8932TTT", "1190PLN", "3290GHJ", "5578TRW", "6567WWQ", "1416QQR", "5678XXV", "1111QQQ", "2222WWW", "3333RRR", "4567LNB", "0987MPY", "6666PYL", "8865TTT", "1222RTY", "8888LKM", "3345THB", "7777MMM", "5544KJY",  "0099LLM", "1010CCC", "2990FFF", "9870DDT", "4731HJK", "8828LSQ", "2532BNY", "4211PXP", "0205PBP", "0500PCM"]
    
    let vehicleAddres : String
    let vehicleLatitude : Double
    let vehicleLongitude : Double
    let id : Int
    lazy var plate: String = {
        return CCVehicle.vehiclePlates[id]
    }()

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
        aCoder.encode(self.id, forKey: "vehicleId")
        aCoder.encode(self.plate, forKey: "vehiclePlate")
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
            return CCVehicle.vehiclePlates[id]
        }
    }
    
    var subtitle: String? {
        get {
            return ""
        }
    }
}

