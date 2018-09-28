/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A struct for accessing generic password keychain items.
 */

import Foundation

struct KeyChainItem {
    
    // MARK: Types
    enum KeychainError: Error {
        case noItem
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    // MARK: Properties
    let service: String
    private(set) var account: String
    let accessGroup: String?
    
    // MARK: Intialization
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: Keychain access
    func readItem() throws -> String  {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeyChainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noItem }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedItemData
        }
        
        return password
    }
    
    func saveItem(_ item: String) throws {
        // Encode the password into an Data object.
        let encodedItem = item.data(using: String.Encoding.utf8)!
        
        do {
            // Check for an existing item in the keychain.
            try _ = readItem()
            
            // Update the existing item with the new password.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedItem as AnyObject?
            
            let query = KeyChainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
        catch KeychainError.noItem {
            /*
             No password was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeyChainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedItem as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    mutating func renameAccount(_ newAccountName: String) throws {
        // Try to update an existing item with the new account name.
        var attributesToUpdate = [String : AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?
        
        let query = KeyChainItem.keychainQuery(withService: service, account: self.account, accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
        
        self.account = newAccountName
    }
    
    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeyChainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    
    
    // MARK: Convenience
    
    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}


struct KeychainConfiguration {
    static let serviceName = Bundle.main.bundleIdentifier!
    static let accessGroup: String? = nil
    static let singletonAccount: String = ""
}

// MARK: - Reponsibility of  CRUD operation from KeyChain
class AccessTokenHelper {
    
    static var shared = AccessTokenHelper()
    
    private init() {}
    
    var isAccessTokenExistInKeyChain: Bool {
        return (getAccessTokenIfExists() != nil) ? true: false
    }
    var accessToken: String? {
        return getAccessTokenIfExists()
    }
    
    
    func saveAccesTokenInKeyChain(token: String) {
        let accessTokenItem = KeyChainItem(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.singletonAccount)
        do {
            try accessTokenItem.saveItem(token)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    func getAccessTokenIfExists() -> String? {
        let accessTokenItem = KeyChainItem(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.singletonAccount)
        return try? accessTokenItem.readItem()
    }
    
    func deleteAccessToken() {
        let accessTokenItem = KeyChainItem(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.singletonAccount)
        do {
            try accessTokenItem.deleteItem()
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    func deleteAccessTokenIfFirstRun() {
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "hasRunBefore") {
            // Remove Keychain items here
            deleteAccessToken()
            // Update the flag indicator
            userDefaults.set(true, forKey: "hasRunBefore")
        }
    }
}
