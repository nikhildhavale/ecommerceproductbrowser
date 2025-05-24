import Foundation

//
//  Untitled.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//
struct UserProfileResponse: Codable {
    let id: Int?
    let email, password, name, role: String?
    let avatar: String?
    let creationAt, updatedAt: String?
}
class UserData {
    static var shared = UserData()
    var userProfileResponse:UserProfileResponse?
    init() {
        if let data = UserDefaults.standard.data(forKey: "userData") {
            loginResonse = try? JSONDecoder().decode(LoginResponse.self, from: data)
            fetchUserProfile()
        }
    }
    var loginResonse:LoginResponse? {
        didSet{
            if let data = try? JSONEncoder().encode(loginResonse) {
                UserDefaults.standard.set(data, forKey: "userData")
                fetchUserProfile()
            }
        }
    }
    var isLoggedIn: Bool  {
        loginResonse != nil && loginResonse?.accessToken != nil
    }
    func fetchUserProfile() {
        Task {
            let resultType : ResultType<UserProfileResponse,ErrorResponse, Error> = await NetworkSession.shared.setupGetRequest(path:CategoryConstants.category)
            switch resultType {
            case .success(let userResponse):
                self.userProfileResponse = userResponse
            case .failedResponse:
                print("user profile failed")
            case .failure:
                print("user profile failed")
            }
        }
        
    }
}

