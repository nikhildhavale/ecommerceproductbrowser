//
//  NetworkSession.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import Foundation
struct ErrorResponse: Decodable {
    let message: String?
    let statusCode: Int?
}
enum ResultType<T,R,Failure: Error> {
    case success(T)
    case failedResponse(R)
    case failure(Failure)
}
enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case noData
    var localisedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingFailed:
            return "Decoding Failed"
        case .noData:
            return "No Data"
        }
    }
}
class NetworkSession {

    static let baseURL = "https://api.escuelajs.co"
    var currentTask:URLSessionDataTask?
    static var shared = NetworkSession()
    func generateURL(with path: String,parameters:[URLQueryItem]? = nil) -> URL? {
        guard var url = URL(string: NetworkSession.baseURL + path) else {
            
        
            return nil
        }
        if let params = parameters {
            var urlParser = URLComponents(string: url.absoluteString)
            urlParser?.queryItems = params
            return urlParser?.url
        }
       
        return url
    }
    func setupGetRequest<Response:Codable>(path: String , parameters:[URLQueryItem]? = nil ) async -> ResultType<Response,ErrorResponse,Error> {
        do {
            if let url = generateURL(with: path,parameters: parameters), let accesToken =  UserData.shared.loginResonse?.accessToken {
                    var urlRequest = URLRequest(url: url)
                    urlRequest.setValue("Bearer \(accesToken)", forHTTPHeaderField: "Authorization")
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    urlRequest.httpMethod = HTTPConstants.get
                    let (data, _) = try await URLSession.shared.data(for: urlRequest)
                    print("URL : \(url.absoluteString)")
                    print("data :")
                    data.printString()
                if let decoded = try? JSONDecoder().decode(ErrorResponse.self, from: data) , decoded.statusCode != nil , decoded.message != nil   {
                        return .failedResponse(decoded)
                    }
                    else if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                        return .success(decoded)
                    }
                    else {
                        return .failure(CustomError.noData)
                    }
                }
                else {
                    return .failure(CustomError.invalidURL)
                }
            }
            catch {
                return .failure(CustomError.noData)
            }
    }
    func setupPostRequest<T: Codable,Response:Codable>(request:T,path:String) async -> ResultType<Response,ErrorResponse,Error> {
        do {
            if let url = generateURL(with: path) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPConstants.post
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try JSONEncoder().encode(request)
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                print("URL : \(url.absoluteString)")
                print("data :")
                data.printString()
                if let decoded = try? JSONDecoder().decode(ErrorResponse.self, from: data) , decoded.statusCode != nil  {
                    return .failedResponse(decoded)
                }
                else if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                    return .success(decoded)
                }
                else {
                    return .failure(CustomError.noData)
                }

            }
            else {
                return .failure(CustomError.invalidURL)
            }
        }
        catch {
                return .failure(error)
        }
    }
}
