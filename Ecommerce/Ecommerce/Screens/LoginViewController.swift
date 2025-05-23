//
//  LoginViewController.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import UIKit
// MARK: LoginViewController class
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let activityIndicatorController = ActivityIndicatorController(text: LoginConstants.loginLoading)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewHeirarchy()
        setupConstraints()
        loadRequest()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: Any) {
        activityIndicatorController.view.isHidden = false
        loadRequest()
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
// MARK: UIViewControllerProtocol
extension LoginViewController:UIViewControllerProtocol{
    func setupViewHeirarchy() {
        self.emailTextField.placeholder = LoginConstants.emailPlaceholder
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.returnKeyType = .next
        self.passwordTextField.placeholder = LoginConstants.passwordPlaceholder
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.returnKeyType = .go
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func setupConstraints() {
        embedChildAndAlignToSuperview(activityIndicatorController)
        activityIndicatorController.view.isHidden = true
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Login"
    }
    
    
}
// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        else {
            loadRequest()
        }
        return true
    }
}
// MARK: NetworkRequestProtocol
extension LoginViewController: NetworkRequestProtocol {
    func loadRequest() {
        activityIndicatorController.view.isHidden = false
    }
    
    
}
