//
//  Constants.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import CoreFoundation
struct LoginConstants {
    static let loginTitle = "Login"
    static let loginLoading = "Logging in..."
    static let emailPlaceholder = "Email"
    static let passwordPlaceholder = "Password"
    static let loginURL = "/api/v1/auth/login"
    static let userProfile = "/api/v1/auth/profile"
}
struct CategoryConstants {
    static let category = "/api/v1/categories"

}
struct ProductListConstants {
    static let productList = "/api/v1/product"

}
struct UIConstants {
    static let cornerRadius: CGFloat = 8
}
struct HTTPConstants {
    static let post = "POST"
    static let get = "GET"
}
