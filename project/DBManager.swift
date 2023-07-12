//
//  DBManager.swift
//  project
//
//  Created by Nazar Kopeika on 02.07.2023.
//

import Foundation
import SQLite

enum Tables: String {
    case transfers = "transfers"
    case users = "users"
}

class DBManager {
    private var db: Connection!
    
    init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent("db").appendingPathExtension("sqlite3")
            let db = try Connection(fileURL.path)
            self.db = db
            
            // Create Tables if there is no tables
            createUserTable()
            createTransferTable()
            
        } catch {
            print(error)
        }
    }
    
    public func transferMoney(from senderId: Int, to receiverId: Int, amount: Int, compeletion: (Error?) -> Void){
        do {
            let sender = try db.prepare("SELECT balance FROM users WHERE id = \(senderId)")
            let recevier = try db.prepare("SELECT balance FROM users WHERE id = \(receiverId)")
            
            var senderBalance: Int = 0
            for element in sender{
                senderBalance = element[0] as! Int
            }
            
            var receiverBalance: Int = 0
            for element in recevier{
                receiverBalance = element[0] as! Int
            }
            
            let newSenderBalance = senderBalance - amount
            let newReceiverBalance = receiverBalance + amount
            
            if newSenderBalance < 0 {
                compeletion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Transfer can't be done because you don't have enough balance."]))
                return
            }
            
            addNewTransferRecord(sender: senderId, receiver: receiverId, amount: amount)
            
            _ = try db.run("UPDATE users SET balance = \(newSenderBalance) WHERE id = \(senderId)")
            _ = try db.run("UPDATE users SET balance = \(newReceiverBalance) WHERE id = \(receiverId)")
            
            compeletion(nil)
            
        } catch {
            compeletion(error)
        }
    }
     
    
    public func transferMoney(to receiverId: Int, amount: Int, compeletion: (Error?) -> Void){
        do {
            let recevier = try db.prepare("SELECT balance FROM users WHERE id = \(receiverId)")

            var receiverBalance: Int = 0
            for element in recevier{
                receiverBalance = element[0] as! Int
            }

            let newReceiverBalance = receiverBalance + amount

            addNewTransferRecord(receiver: receiverId, amount: amount)

            _ = try db.run("UPDATE users SET balance = \(newReceiverBalance) WHERE id = \(receiverId)")

            compeletion(nil)

        } catch {
            compeletion(error)
        }
    }
    
    private func addNewTransferRecord(sender: Int? = nil, receiver: Int, amount: Int){
        do {
            if let sender = sender {
                let stmt = try db.prepare("INSERT INTO transfers (senderId, receiverId, amount) VALUES (?, ?, ?)")
                try stmt.run([sender, receiver, amount])
                
            }else{
                let stmt = try db.prepare("INSERT INTO transfers (receiverId, amount) VALUES (?, ?)")
                try stmt.run([receiver, amount])
            }
            
        } catch {
            print(error)
        }
    }
    
    public func getUsers() -> [Customer]{
        var users: [Customer] = []
        
        do {
            let stmt = try db.prepare("SELECT * FROM users")
            
            for element in stmt{
                let id = element[0] as! Int
                let name = element[1] as! String
                let email = element[2] as! String
                let balance = element[3] as! Int
                
                let user = Customer(id1: id, name: name, email: email, balance: balance)
                users.append(user)
            }
            
        } catch {
            print(error)
        }
        return users
    }



    public func getTransfers() -> [Transction]{
        var transfers: [Transction] = []
        do {
            let stmt = try db.prepare("SELECT * FROM transfers")

            for element in stmt{
                let id = element[0] as! Int
                let sender = element[1] as? Int
                let receiver = element[2] as! Int
                let amount = element[3] as! Int
                
                let transfer = Transction(id: id, sender: sender, receiver: receiver, amount: amount)
                transfers.append(transfer)
            }
            
        } catch {
            print(error)
        }
        
        return transfers
    }
}



// MARK: - Not Asked in Task
extension DBManager {
    private func createUserTable(){
        let users = Table("users")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let email = Expression<String>("email")
        let balance = Expression<Int>("balance")
        
        do {
            try db.run(users.create{ table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(email, unique: true)
                table.column(balance)
            })
        } catch {
            print(error)
        }
    }
    
    private func createTransferTable() {
        let transfers = Table("transfers")
        let id = Expression<Int>("id")
        let senderId = Expression<Int?>("senderId")
        let receiverId = Expression<Int>("receiverId")
        let amount = Expression<Int>("amount")
        
        do {
            try db.run(transfers.create{ table in
                table.column(id, primaryKey: true)
                table.column(senderId)
                table.column(receiverId)
                table.column(amount)
            })
        } catch {
            print(error)
        }
    }
    
    func insertUser(name: String, email: String, balance: Int){
        do {
            let stmt = try db.prepare("INSERT INTO users (name, email, balance) VALUES (?, ?, ?)")
            try stmt.run([name, email, balance])
            
        } catch {
            print(error)
        }
    }
}
