//
//  CCSmartContract.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import Web3


class CCSmartContract{
    
    let managerAddress = try! EthereumAddress(hex: "0x711bb2cDfA7f6d3C2D4d2dd167E45D80A4Af1EfD", eip55: false)
    //        let contractAddress = try! EthereumAddress(hex: "0x711bb2cDfA7f6d3C2D4d2dd167E45D80A4Af1EfD", eip55: true)
    let contractJsonABI = "[{\"constant\":false,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"},{\"name\":\"_credit\",\"type\":\"uint256\"}],\"name\":\"registerNewUser\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"users\",\"outputs\":[{\"name\":\"id\",\"type\":\"uint256\"},{\"name\":\"credit\",\"type\":\"uint256\"},{\"name\":\"carId\",\"type\":\"uint256\"},{\"name\":\"registered\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"},{\"name\":\"_plate\",\"type\":\"string\"}],\"name\":\"registerNewCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_id\",\"type\":\"uint256\"}],\"name\":\"getUserCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_carId\",\"type\":\"uint256\"},{\"name\":\"_userId\",\"type\":\"uint256\"}],\"name\":\"rentCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_carId\",\"type\":\"uint256\"},{\"name\":\"_userId\",\"type\":\"uint256\"}],\"name\":\"returnCar\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"cars\",\"outputs\":[{\"name\":\"id\",\"type\":\"uint256\"},{\"name\":\"plate\",\"type\":\"string\"},{\"name\":\"userId\",\"type\":\"uint256\"},{\"name\":\"registered\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"minimumRentCredit\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]".data(using: .utf8)!
    
    
    let web3 = Web3(rpcURL: "https://rinkeby.infura.io/v3/911ffdd646fe4561820ce1c146be7250")
    //    let contractAddress = try! EthereumAddress(hex: "0x526F5F06D6f1f9e63c6f344Ab5b160DE7b1eaCEa", eip55: true)
    let contractAddress = try! EthereumAddress(hex: "0x5a84615d6c15f7ebe72a32c02a4f251948024de9", eip55: false)
    
    
    func getUserData(_ uuid : BigUInt, completion :@escaping ( _ result : [String:Any]) -> () ){
        let contract = try! web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)
        firstly {
            contract["users"]!(uuid).call()
            }.done { hash in
                print(hash)
                completion(hash)
            }.catch { error in
                print(error)
                completion([:])
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
            
            do {
                let c = contract["registerNewUser"]?(BigUInt(1), BigUInt(100))
                let transaction: EthereumTransaction = c!
                    .createTransaction(nonce: response.result,
                                       from: myPrivateKey.address,
                                       value: 0,
                                       gas: 210000,
                                       gasPrice: EthereumQuantity(quantity: 1.gwei))!
                
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: myPrivateKey, chainId: 4)
                
                firstly {
                    self.web3.eth.sendRawTransaction(transaction: signedTx)
                    }.done { txHash in
                        print(txHash)
                    }.catch { error in
                        print(error)
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func registerNewCar(_ carId : BigUInt, _ plate : String){
        let contract = try! web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)
        let myPrivateKey = try! EthereumPrivateKey(hexPrivateKey: "0F83EC16705DD8071481592816ABCFDF883A173F9293497C4EEDB33FFC6150CB")
        web3.eth.getBalance(address: myPrivateKey.address, block: try! .string("latest") ) { response in
            print("myAccount - result?.quantity(wei): ", response.result?.quantity as Any)
        }
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {
            response in print(response.result?.quantity as Any)
            do {
                let c = contract["registerNewCar"]?(carId, plate)
                let transaction: EthereumTransaction = c!
                    .createTransaction(nonce: response.result,
                                       from: myPrivateKey.address,
                                       value: 0,
                                       gas: 210000,
                                       gasPrice: EthereumQuantity(quantity: 1.gwei))!
                
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: myPrivateKey, chainId: 4)
                
                firstly {
                    self.web3.eth.sendRawTransaction(transaction: signedTx)
                    }.done { txHash in
                        print(txHash)
                    }.catch { error in
                        print(error)
                }
            } catch {
                print(error)
            }
        }
    }
    
}


