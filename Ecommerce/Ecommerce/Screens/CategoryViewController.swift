//
//  CategoryViewController.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import UIKit

class CategoryViewController: UIViewController {
    let activityIndicatorController = ActivityIndicatorController(text: LoginConstants.loginLoading)
    lazy var  categoryHostingController :CategoryViewHostingController =  {
        let model = CategoryViewModel()
        model.setupProductId()
        let categoryView = CategoryView(categoryViewModel: model)
        let controller = CategoryViewHostingController(rootView: categoryView)
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewHeirarchy()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    func showLoginScreenIfNotLoggedIn() {
        if !UserData.shared.isLoggedIn
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else {
            loadRequest()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoginScreenIfNotLoggedIn()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CategoryViewController:UIViewControllerProtocol {
    func setupViewHeirarchy() {
        activityIndicatorController.view.isHidden = true
    }
    
    func setupConstraints() {
        embedChildAndAlignToSuperview(activityIndicatorController)
        embedChildAndAlignToSafeArea(categoryHostingController)
    }
    
    func setupNavigationBar() {

    }
    
    
}
extension CategoryViewController:NetworkRequestProtocol {
    func loadRequest() {
       
    }
    
    
}
