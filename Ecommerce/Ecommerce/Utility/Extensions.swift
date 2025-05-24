import UIKit

//
//  UIConstants.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//
struct Constaints {
    var leadingAnchor: NSLayoutConstraint
    var trailingAnchor: NSLayoutConstraint
    var topAnchor: NSLayoutConstraint
    var bottomAnchor: NSLayoutConstraint
}
extension UIView {
    @discardableResult
    func addAndAlignToSuperview(_ superView: UIView) ->  Constaints {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let leadingAnchor =     superView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingAnchor =    superView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let topAnchor =  superView.topAnchor.constraint(equalTo: topAnchor)
        let bottomAnchor = superView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leadingAnchor, trailingAnchor, topAnchor, bottomAnchor])
        return Constaints(leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, topAnchor: topAnchor, bottomAnchor: bottomAnchor)
    }
    @discardableResult
    func addandAlignToSafeAreaSuperView(_ superView:UIView) -> Constaints {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let leadingAnchor =     superView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingAnchor =    superView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        let topAnchor =  superView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor)
        let bottomAnchor = superView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leadingAnchor, trailingAnchor, topAnchor, bottomAnchor])
        return Constaints(leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, topAnchor: topAnchor, bottomAnchor: bottomAnchor)
    }
    var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
    }
}
extension UIViewController {
    func embedChildAndAlignToSuperview(_ child: UIViewController) {
        addChild(child)
        child.view.addAndAlignToSuperview(view)
        child.didMove(toParent: self)
    }
    func embedChildAndAlignToSafeArea(_ child: UIViewController) {
        addChild(child)
        child.view.addandAlignToSafeAreaSuperView(view)
        child.didMove(toParent: self)
    }
    func embedChildCenteredInSuperview(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        child.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        child.didMove(toParent: self)
    }
    func showAlertOK(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}
extension URLCache {
   public static let imageCache = URLCache(memoryCapacity: 512_000_000,
                                           diskCapacity: 10_000_000_000,
                                           directory:
                                            try? FileManager.default.url(for: .cachesDirectory,
                                                                         in: .userDomainMask,
                                                                         appropriateFor: nil,
                                                                         create: false))
}

extension Data {
    func printString() {
        print(String(data: self, encoding: .utf8)!)
    }
}
