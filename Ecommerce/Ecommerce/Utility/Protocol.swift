//
//  Protocol.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//
protocol UIViewControllerProtocol {
    func setupViewHeirarchy()
    func setupConstraints()
    func setupNavigationBar()
    func prequisteActions()
}
extension UIViewControllerProtocol{
    func prequisteActions() {
        
    }
}
protocol NetworkRequestProtocol {
    func loadRequest() async
}
protocol FilterValueUpdatedDelegate : AnyObject {
    func setMinMaxValue(min:Int,max:Int)
}
