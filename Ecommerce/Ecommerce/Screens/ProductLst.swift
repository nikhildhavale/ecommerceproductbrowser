//
//  ProductLst.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
// MARK: - Product
struct Product: Codable,Hashable {
    let id: Int?
    let title, slug: String?
    let price: Int?
    let description: String?
    let category: Category?
    let images: [String]?
    let creationAt, updatedAt: String?
}
    
struct ProductList: View {
    @ObservedObject var  model:ProductListModel
    var body: some View {
        ZStack {
            if !model.firstTimeLoading  && model.id != nil  {
                ProgressView()
            }
            else {
                     
                List {
                    ForEach(model.visibleList, id: \.self) { product in
                        Button(action: {
                                    
                                    
                        }){
                            HStack {
                                CustomImageView(
                                    viewModel: CustomImageViewModel(
                                        url: product.images?.first,
                                        size: CGSize(width: 20, height: 20)
                                    )
                                )
                                Text(product.title ?? "" )
                                    .foregroundStyle(Color.primary)
                                        
                            }
                        }
                               
                                
                    }
                }
                .refreshable {
                    await model.loadRequest()
                }.task {
                    await model.loadRequest()
                }.searchable(text: $model.searchText, prompt: "Search Products")
                
                    
                
            }
        }.alert(isPresented: $model.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(model.alert ?? "" ),
                dismissButton: .default(Text("OK"))
            )
        
            
            
        }.onChange(of: model.searchText) {
            model.filterProductList()
        }
       
    }
}
class ProductListModel:ObservableObject {
    @Published var id:String?
    @Published var showAlert:Bool = false
    @Published var alert:String?
    var productList:[Product] = []
   @Published var visibleList:[Product] = []
    @Published var searchText:String = ""
    var firstTimeLoading = false
    func filterProductList()  {
        visibleList =  productList.filter { searchText.isEmpty ? true :  $0.title?.contains(searchText) ?? true }
    }
}
// MARK: - NetworkRequestProtocol
extension ProductListModel:NetworkRequestProtocol {
    func loadRequest() async {
        let result: ResultType<[Product],ErrorResponse, Error> =  await NetworkSession.shared.setupGetRequest(
            path: ProductListConstants.productList,
            parameters: [URLQueryItem(name: "categoryId", value: id)]
        )
        firstTimeLoading = true
        switch result {
        case .success(let response ):
            DispatchQueue.main.async {
                self.productList = response
                self.filterProductList()
            }
        case .failedResponse(let failedResponse):
            DispatchQueue.main.async {
                self.alert = failedResponse.message
                self.showAlert = true
            }
           
        case .failure(let failure):
            DispatchQueue.main.async {
                self.alert = failure.localizedDescription
                self.showAlert = true
            }
        }
    }
}
