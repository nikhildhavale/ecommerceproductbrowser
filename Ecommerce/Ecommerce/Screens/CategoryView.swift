//
//  CategoryView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
// MARK: - CategoryView
struct CategoryView: View {
    var body: some View {
        VStack {
            HorizontalScroller(viewModel: HorizontalScrollerModel())
            Spacer()
        }
    }
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
