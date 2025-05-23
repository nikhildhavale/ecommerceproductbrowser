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
                    if model.showLoader {
                        HStack {
                            Spacer()
                            ProgressView().onAppear {
                                Task {
                                    await model.loadRequest()
                                }
                            }
                            Spacer()
                        }
                       
                    }
                }
                .refreshable {
                    model.offset = 0 
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
    var minValue:Int?
    var maxValue:Int?
    var offset = 0 {
        didSet{
            if offset == 0 {
                productList.removeAll()
                visibleList.removeAll()
            }
           
        }
    }
    var limit = 10
    @Published var showLoader = false
    func filterProductList()  {
        if searchText.isEmpty {
            visibleList = productList
        }
        else {
            visibleList =  productList.filter {   $0.title?.contains(searchText) ?? true }
        }
       
    }
}
// MARK: - NetworkRequestProtocol
extension ProductListModel:NetworkRequestProtocol {
    func loadRequest() async {
        var paramters = [URLQueryItem(name: "offset", value: "\(offset)"),URLQueryItem(name: "limit", value: "\(limit)")]
        if id != nil {
            paramters.insert(URLQueryItem(name: "categoryId", value: id), at: 0)
            
        }
       
        if let minPrice = minValue {
            paramters.append( URLQueryItem(name: "price_min", value: String(minPrice)))
        }
        if let maxPrice = maxValue {
            paramters.append(URLQueryItem(name: "price_max", value: String(maxPrice)))
        }
        let result: ResultType<[Product],ErrorResponse, Error>? =  await NetworkSession.shared.setupGetRequest(
            path: ProductListConstants.productList,
            parameters: paramters
        )
        firstTimeLoading = true
        switch result {
        case .none:break
        case .success(let response ):
            DispatchQueue.main.async {
                if self.offset == 0 {
                    self.productList = response
                }
                else {
            
                    self.productList += response

                }
                self.offset += response.count
                self.showLoader = !response.isEmpty
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
extension ProductListModel:FilterValueUpdatedDelegate {
    func setMinMaxValue(min: Int?, max: Int?) {
        minValue = min
        maxValue = max
        offset = 0
        Task {
           await loadRequest()

        }
    }
    
    
}
