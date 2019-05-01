//
//  CCSmartContract.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import Web3

class CCSmartContractManager{
    
    let managerAddress = try! EthereumAddress(hex: k.SmartContractData.managerAddress, eip55: false)
    let contractJsonABI = k.SmartContractData.contractJsonABI.data(using: .utf8)!
    let web3 = Web3(rpcURL: k.SmartContractData.rinkebyEndpoint)
    let contractAddress = try! EthereumAddress(hex: k.SmartContractData.contractAddress, eip55: false)
    let gasPrice = EthereumQuantity(quantity: 1.gwei)
    let myPrivateKey = try! EthereumPrivateKey(hexPrivateKey: k.SmartContractData.privateKey)

    lazy var contract = try! web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)

    func getUserCredit(_ userId : String, completion :@escaping ( _ result : [String:Any]) -> () ){
        firstly { contract[k.SmartContractFunctions.getUserCredit]!(userId).call() }
            .done { hash in print(hash);  completion(hash) }
            .catch { error in print(error) }
    }
    
    func getUserCar(_ userId : String, completion :@escaping ( _ result : [String:Any]?) -> () ){
        firstly { contract[k.SmartContractFunctions.getUserCar]!(userId).call() }
            .done {
                hash in print(hash) ;
                completion(hash) }
            .catch {
                error in print(error) ;
                completion(nil) }
    }
    
    func registerNewUser(_ userId : String, completion :@escaping ( _ result : EthereumData?) -> ()){
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {response in
            do {
                let c = self.contract[k.SmartContractFunctions.registerNewUser]?(userId)
                let transaction: EthereumTransaction = c!.createTransaction(nonce: response.result, from: self.myPrivateKey.address,value: 0,gas: 210000, gasPrice: self.gasPrice)!
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: self.myPrivateKey, chainId: 4)
                
                firstly { self.web3.eth.sendRawTransaction(transaction: signedTx) }
                    .done { txHash in print(txHash) ; completion(txHash) }
                    .catch { error in print(error) ; completion(nil) }
                
            } catch { print(error) }
        }
    }
    
    func registerNewCar(_ plate : String, completion :@escaping ( _ result : EthereumData?) -> ()){
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {response in
            do {
                let c = self.contract[k.SmartContractFunctions.registerNewCar]?(plate)
                let transaction: EthereumTransaction = c!.createTransaction(nonce: response.result, from: self.myPrivateKey.address, value: 0, gas: 210000, gasPrice: self.gasPrice)!
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: self.myPrivateKey, chainId: 4)
                
                firstly { self.web3.eth.sendRawTransaction(transaction: signedTx) }
                    .done { txHash in print(txHash) ; completion(txHash) }
                    .catch { error in print(error) ; completion(nil) }
                
            } catch { print(error) }
        }
    }
    
    func rentCar(_ plate : String, _ userId : String, completion :@escaping ( _ result : EthereumData?) -> ()){
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {response in
            do {
                let c = self.contract[k.SmartContractFunctions.rentCar]?(plate, userId)
                let transaction: EthereumTransaction = c!.createTransaction(nonce: response.result, from: self.myPrivateKey.address, value: 0, gas: 210000, gasPrice: self.gasPrice)!
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: self.myPrivateKey, chainId: 4)
                
                firstly { self.web3.eth.sendRawTransaction(transaction: signedTx) }
                    .done {
                        txHash in print(txHash) ;
                        completion(txHash) }
                    .catch {
                        error in print(error) ;
                        completion(nil) }
                
            } catch { print(error) }
        }
    }
    
    func returnCar(_ plate : String, _ userId : String, completion :@escaping ( _ result : EthereumData?) -> ()){
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {response in
            do {
                let c = self.contract[k.SmartContractFunctions.returnCar]?(plate, userId)
                let transaction: EthereumTransaction = c!.createTransaction(nonce: response.result, from: self.myPrivateKey.address, value: 0, gas: 210000, gasPrice: self.gasPrice)!
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: self.myPrivateKey, chainId: 4)
                
                firstly { self.web3.eth.sendRawTransaction(transaction: signedTx) }
                    .done {
                        txHash in print(txHash) ;
                        completion(txHash) }
                    .catch {
                        error in print(error) ;
                        completion(nil) }
                
            } catch { print(error) }
        }
    }
    
    func addCredit(_ userId : String, _ credit : BigUInt, completion :@escaping ( _ result : EthereumData?) -> ()){
        web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest) {response in
            do {
                let c = self.contract[k.SmartContractFunctions.addCredit]?(userId, credit)
                let transaction: EthereumTransaction = c!.createTransaction(nonce: response.result, from: self.myPrivateKey.address, value: 0, gas: 210000, gasPrice: self.gasPrice)!
                let signedTx: EthereumSignedTransaction = try transaction.sign(with: self.myPrivateKey, chainId: 4)
                
                firstly { self.web3.eth.sendRawTransaction(transaction: signedTx) }
                    .done { txHash in print(txHash) ; completion(txHash) }
                    .catch { error in print(error) ; completion(nil) }
                
            } catch { print(error) }
        }
    }
}
