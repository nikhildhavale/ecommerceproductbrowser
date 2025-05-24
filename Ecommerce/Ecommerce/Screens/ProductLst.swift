//
//  ProductLst.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
struct ProductResponse:Codable {
    
}
struct ProductList: View {
    @ObservedObject var  model:ProductListModel
    var body: some View {
        
        List {
            
        }.task {
            
        }.refreshable {
            
        }
    }
}
class ProductListModel:ObservableObject {
    var id:String?
}
// MARK: - NetworkRequestProtocol
extension ProductListModel:NetworkRequestProtocol {
    func loadRequest() async {
        var product = ProductListConstants.productList
        
        let result: ResultType<ProductResponse,ErrorResponse, Error> =  await NetworkSession.shared.setupGetRequest(path: product,parameters: [URLQueryItem(name: "categoryId", value: id)])
        
    }
}
