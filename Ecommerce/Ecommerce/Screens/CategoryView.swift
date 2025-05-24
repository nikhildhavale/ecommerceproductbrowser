//
//  CategoryView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
// MARK: - CategoryView
struct CategoryView: View {
    @ObservedObject var categoryViewModel:CategoryViewModel
    var body: some View {
        NavigationStack {
            VStack {
                HorizontalScroller(viewModel: categoryViewModel.model).frame(height: 100)
                ProductList(model: categoryViewModel.productListModel)
                Spacer()
            }.navigationTitle("Categories")
        }
       
    }
}
// MARK: - CategoryViewModel
class CategoryViewModel:ObservableObject {
    let productListModel = ProductListModel()
    let model = HorizontalScrollerModel()
    func setupProductId() {
        model.action = { [weak self]  id in
            if let productId  =  id{
                self?.productListModel.id = String(productId)
            }
            else {
                self?.productListModel.id = nil
            }
            Task {
                await self?.productListModel.loadRequest()

            }
        }
        
    }
}
// MARK: - CategoryHosting
class CategoryViewHostingController:UIHostingController<CategoryView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

