//
//  CCConstants.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit
import Web3

struct k {
    
    enum Destiny: String{
        case map
        case myprofile
        case addCredit
        case registerCar
    }
    
    static let CCCOLORGREEN = UIColor(red: 0.5137, green: 0.7098, blue: 0.7725, alpha: 1.0)
    
    struct UserDefaults {
        static let userRegistered = "userRegistered"
        static let username = "username"
        static let password = "password"
        static let plate = "plate"
    }
    
    struct SmartContractFunctions{
        static let getUserCredit = "getUserCredit"
        static let getUserCar = "getUserCar"
        static let registerNewUser = "registerNewUser"
        static let registerNewCar = "registerNewCar"
        static let rentCar = "rentCar"
        static let returnCar = "returnCar"
        static let addCredit = "addCredit"
    }

    struct SmartContractData{
        static let privateKey = "0F83EC16705DD8071481592816ABCFDF883A173F9293497C4EEDB33FFC6150CB"
        static let contractAddress = "0xbdbf120be914d7ac03b39e5c05af1ac3e45d2c75"
        static let rinkebyEndpoint = "https://rinkeby.infura.io/v3/911ffdd646fe4561820ce1c146be7250"
        static let managerAddress = "0x711bb2cDfA7f6d3C2D4d2dd167E45D80A4Af1EfD"
        static let contractJsonABI = "[{\"constant\":true,\"inputs\":[],\"name\":\"rentedCars\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_userId\",\"type\":\"string\"}],\"name\":\"getUserCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_userId\",\"type\":\"string\"}],\"name\":\"getUserCar\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"registeredUsers\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"registeredCars\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_userId\",\"type\":\"string\"}],\"name\":\"registerNewUser\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_userId\",\"type\":\"string\"},{\"name\":\"_credit\",\"type\":\"uint256\"}],\"name\":\"addCredit\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"availableCars\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_plate\",\"type\":\"string\"}],\"name\":\"registerNewCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_plate\",\"type\":\"string\"},{\"name\":\"_userId\",\"type\":\"string\"}],\"name\":\"returnCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_plate\",\"type\":\"string\"},{\"name\":\"_userId\",\"type\":\"string\"}],\"name\":\"rentCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"minimumRentCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]"

    }
}
