//
//  ActivityIndicatorView.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import UIKit
class ActivityIndicatorController:UIViewController {
    var text:String
    lazy var activityIndicatorView:UIActivityIndicatorView = {
        let activiyIndicatorView = UIActivityIndicatorView(style: .large)
        activiyIndicatorView.hidesWhenStopped = true
        activiyIndicatorView.startAnimating()
        activiyIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activiyIndicatorView
    }()
    lazy var labelTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  " + text + "  "
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.backgroundColor = .secondarySystemBackground
        stackView.cornerRadius = UIConstants.cornerRadius
        return stackView
    }()
    var spacerView:UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.backgroundColor = .clear
        return view
    }
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHeirarchy()
        setupConstraints()
    }
}
extension ActivityIndicatorController:UIViewControllerProtocol {
    func setupViewHeirarchy() {
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(spacerView)
        view.addSubview(stackView)
        self.view.backgroundColor = .clear
        self.view.isHidden = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1)])
    }
    
    func setupNavigationBar() {
        
    }
    
    
}
