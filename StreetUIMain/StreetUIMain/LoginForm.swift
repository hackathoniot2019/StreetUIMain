//
//  LoginForm.swift
//  StreetUIMain
//
//  Created by Denis Abramov on 30/03/2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import UIKit

struct User {
    let login: String
    let password: String
    
    static func login(login:String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
    return nil
}

    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for  user in [
        User(login: "user1", password: "pass1"),
        User(login: "user2", password: "pass2"),
        User(login: "user3", password: "pass3"),
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}
