//
//  Filter.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var showFilter:Bool
    @State var showAlert:Bool = false
    @ObservedObject var model:FilterViewModel
    var body: some View {
        NavigationStack {
            VStack{
                Text("min price \(Int(model.minValue))")
                HStack {
                    Text("0")
                    Slider(value: $model.minValue, in:0...1000, step:1)
                    Text("1000")
                }
                Text("max price \(Int(model.maxValue))")
                HStack {
                    Text("0")
                    Slider(value: $model.maxValue, in:0...1000, step:1)
                    Text("1000")
                }
            }.navigationTitle("Categories").navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showFilter = false
                        model.delegate?.setMinMaxValue(min: nil, max: nil)
                    }) {
                        Text("Clear")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if model.maxValue > model.minValue {
                            showFilter = false
                            model.delegate?.setMinMaxValue(min: Int(model.minValue), max: Int(model.maxValue))
                        }
                        else {
                            showAlert = true
                        }
                    }) {
                        Text("Done")
                    }
                }
            }.padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Min Value should be less than Max Value" ),
                    dismissButton: .default(Text("OK"))
                )
            
                
                
            }
        }
        
    }
}
class FilterViewModel:ObservableObject {
    @Published var minValue:Double = 0
    @Published var maxValue:Double = 0
    weak var delegate:FilterValueUpdatedDelegate?
}
