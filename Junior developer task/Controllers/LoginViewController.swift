//
//  LoginViewController.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-07.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureTextFields()
        configureTapGestureRecognizer()
        setTitle()
    }
    
    // MARK: - Config
    
    private func setTitle() {
        self.title = "Login"
    }
    
    private func configureTextFields() {
        usernameTextField.placeholder = "Username:"
        passwordTextField.placeholder = "Password:"
        
        usernameTextField.clearButtonMode = .whileEditing
        passwordTextField.clearButtonMode = .whileEditing
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
    }
    
    private func configureTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    private func logIn() {
        let tesoDataRequest = TesoRequest()
        
        let username = SafeUnwrap.shared.safeUnwrapOfString(string: usernameTextField.text)
        let password = SafeUnwrap.shared.safeUnwrapOfString(string: passwordTextField.text)
        
        tesoDataRequest.getToken(username: username, password: password) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let token):
                self.navigateToServerListVC(withToken: token)
            }
        }
    }
    
    // MARK: - Navigation
    
    private func navigateToServerListVC(withToken: String) {
        DispatchQueue.main.async {
            if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowServerList") as? ServerListViewController {
                destinationVC.token = withToken
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        handleTap()
        logIn()
    }
}
