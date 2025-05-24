//
//  LoginViewController.swift
//  Ecommerce
//
//  Created by Nikhil Dhavale on 24/05/25.
//

import UIKit
// MARK: - LoginRequest
struct LoginRequest: Codable {
    let email, password: String?
}
// MARK: - LoginResponse
struct LoginResponse: Codable {
    let accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
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
      //  loadRequest()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: Any) {
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
        if let userName = self.emailTextField.text, let password = self.passwordTextField.text {
            activityIndicatorController.view.isHidden = false
            Task {
                let request = LoginRequest(email: userName, password: password)
                let result: ResultType<LoginResponse,ErrorResponse, Error> =  await NetworkSession.shared.setupPostRequest(request: request, path: LoginConstants.loginURL)
                switch result {
                case .success(let response):
                    UserData.shared.loginResonse = response
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                case .failedResponse(let response):
                    DispatchQueue.main.async {
                        self.showAlertOK(title: "Error", message: response.message ?? "")
                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        self.showAlertOK(title: "Error", message: failure.localizedDescription)
                    }
                }
            }
           
        }
        
    }
    
    
}
