//
//  Validator.swift
//  ReusableModules
//
//  Created by Mac mini on 12/10/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation

struct Validator<Value> {
    let closure: (Value) throws -> Void
}

struct ValidationError: LocalizedError {
    let message: String
    var errorDescription: String? { return message.localized }
}

func validate(
    _ condition: @autoclosure () -> Bool,
    errorMessage messageExpression: @autoclosure () -> String
    ) throws {
    guard condition() else {
        let message = messageExpression()
        throw ValidationError(message: message)
    }
}



extension Validator where Value == String {
    static var password: Validator {
        return Validator { string in
            try validate(
                string.count >= 7,
                errorMessage: "Password must contain min 7 characters"
            )
            try validate(
                string.lowercased() != string,
                errorMessage: "Password must contain an uppercased character"
            )
            try validate(
                string.uppercased() != string,
                errorMessage: "Password must contain a lowercased character"
            )
        }
    }
}


/*
 Validate with Syntatic sugar
 */

func validate<T> (_ value: T, using validator: Validator<T>) throws {
    try validator.closure(value)
}



/*
 func signUpIfPossible(with credentials: Credentials) throws {
  try validate(credentials.username, using: .username)
  try validate(credentials.password, using: .password)
 
  service.signUp(with: credentials) { result in
  ...
  }
 }
 
 
------ Instead -------
 
 func signUpIfPossible(with credentials: Credentials) {
  guard credentials.username.count >= 3 else {
   errorLabel.text = "Username must contain min 3 characters"
   return
  }
 
 guard credentials.password.count >= 7 else {
  errorLabel.text = "Password must contain min 7 characters"
  return
 }
 
 // Additional validation
 ...
 
 service.signUp(with: credentials) { result in
 ...
 }
 }
 
 
 
 
 do {
 try signUpIfPossible(with: credentials)
 } catch {
 errorLabel.text = error.localizedDescription
 }
 
 
 **/
