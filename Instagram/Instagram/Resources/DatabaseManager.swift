//
//  DatabaseManager.swift
//  Instagram
//
//  Created by jiyun moon on 2022/08/31.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public

    /// Check if username and email is available
    ///  - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, compeltion: (Bool) -> Void) {
        compeltion(true)
    }
    
    
    /// Check if username and email is available
    ///  - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // succeeded
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
    
    // MARK: - Private
    
    private func safeKey() {
        
    }
}
