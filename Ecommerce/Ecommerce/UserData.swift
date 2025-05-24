
//
//  Untitled.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//
struct UserData {
    static var shared = UserData()
    var loginResonse:LoginResponse?
    var isLoggedIn: Bool  {
        loginResonse != nil && loginResonse?.accessToken != nil
    }
}
