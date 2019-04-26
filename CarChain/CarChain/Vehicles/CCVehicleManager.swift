//
//  CCVehicleManager.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 20/11/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

import Foundation

class CCVehicleManager {
    
    static let sharedInstance = CCVehicleManager()
    var vehicles : [CCVehicle] = [CCVehicle]()
    
    func save() {
        if let url = databaseURL() {
                NSKeyedArchiver.archiveRootObject(vehicles, toFile: url.path)
        }
        else{
            print("Error saving data")
        }
    }
    
    func load() {
        if let url = databaseURL(),
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [CCVehicle] {
            vehicles = savedData
        }
        else{
            print ("Error loading data")
        }
    }
    
    func databaseURL() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let url = URL(fileURLWithPath: documentDirectory)
            return url.appendingPathComponent("vehicles.data")
        }
        else {
            return nil
        }
    }
}
