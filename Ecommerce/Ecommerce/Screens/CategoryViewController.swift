//
//  CategoryViewController.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func showLoginScreenIfNotLoggedIn() {
        if !UserData.shared.isLoggedIn
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
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
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupNavigationBar() {
        
    }
    
    
}
