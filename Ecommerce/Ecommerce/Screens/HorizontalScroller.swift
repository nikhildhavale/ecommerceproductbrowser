//
//  HorizontalScroller.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI
// MARK: - Category
struct Category: Codable,Hashable {
    let id: Int?
    let name, slug: String?
    let image: String?
    let creationAt, updatedAt: String?
}
// MARK: - HorizontalScroller
struct HorizontalScroller: View {
    // Define multiple flexible rows
    @ObservedObject var  viewModel:HorizontalScrollerModel
   
    var body: some View {
        if viewModel.rows.isEmpty {
            ProgressView()
        }
        else {
            ScrollView(.horizontal) {
                LazyHGrid(rows: viewModel.rows, spacing: 16) {
                    ForEach(viewModel.arrayCategory, id: \.self) { item in
                        Button(action: {
                            if viewModel.selectedID == item.id {
                                viewModel.selectedID = nil

                            }else {
                                viewModel.selectedID = item.id

                            }
                        }) {
                            VStack {
                                CustomImageView(viewModel: CustomImageViewModel(url: item.image,title: item.name,size: CGSize(width: 50, height: 50)))
                                    .background(
                                                    Circle()
                                                        .stroke(viewModel.selectedID == item.id ? Color.blue : Color.clear, lineWidth: 3)
                                                )
                                Text(item.name ?? "").lineLimit(nil).foregroundStyle(Color.primary)
                            }.frame(minWidth: 60, minHeight: 60)
                        }

                    }
                               
                            }
                            .padding()
            }.task {
                await viewModel.loadRequest()
            }.alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.alert ?? "" ),
                    dismissButton: .default(Text("OK"))
                )
            }.refreshable {
                await viewModel.loadRequest()
            }
        }
       
    }
}
// MARK: - HorizontalViewModel
class HorizontalScrollerModel:ObservableObject {
    @Published var arrayCategory:[Category] = []
    let rows = [
        GridItem(.fixed(60))    ]
     var alert:String?
    @Published var showAlert = false
    @Published var selectedID:Int?
}
// MARK: - NetworkRequestProtocol
extension HorizontalScrollerModel:NetworkRequestProtocol {
    
    
    func loadRequest() async {
        let result: ResultType<[Category],ErrorResponse, Error> =  await NetworkSession.shared.setupGetRequest(path: CategoryConstants.category)
        switch result {
        case .success(let response):
            DispatchQueue.main.async {
                self.arrayCategory = response
            }
        case .failedResponse(let failedResponse):
            alert = failedResponse.message
            showAlert = true
        case .failure(let failure):
            alert = failure.localizedDescription
            showAlert = true
        }
    }
    
    
}
