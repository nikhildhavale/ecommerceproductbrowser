//
//  CategoryView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
// MARK: - CategoryView
struct CategoryView: View {
    @ObservedObject var categoryViewModel = CategoryViewModel()
    var body: some View {
        VStack {
            HorizontalScroller(viewModel: categoryViewModel.model)
            ///products?price_min=100&price_max=500&categoryId=3
        }
    }
}
// MARK: - CategoryViewModel
class CategoryViewModel:ObservableObject {
    var model = HorizontalScrollerModel()
}
// MARK: - CategoryHosting
class CategoryViewHostingController:UIHostingController<CategoryView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    CategoryView()
}
