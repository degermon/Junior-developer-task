//
//  LoginViewController.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-07.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit
import PromiseKit
import AyLoading

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var networkRequest: NetworkingProtocol!
    
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
    
    private func clearTextFields() {
        usernameTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }
    
    private func logIn() {        
        let username = SafeUnwrap.shared.safeUnwrapOfString(string: usernameTextField.text)
        let password = SafeUnwrap.shared.safeUnwrapOfString(string: passwordTextField.text)
        
        networkRequest.promiseLogin(url: UrlKeeper.tokenUrl, username: username, password: password).done { (_) in
            self.clearTextFields()
            self.navigateToServerListVC()
        }.ensure {
            self.loginButton.ay.stopLoading()
        }.catch { (error) in
            print(error)
            self.displayLoginAlert()
        }
    }
    
    // MARK: - Alerts
    
    private func displayLoginAlert() {
        let alert = UIAlertController(title: "Error", message: "Check login credentials and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - Navigation
    
    private func navigateToServerListVC() {
        DispatchQueue.main.async {
            if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowServerList") as? ServerListViewController {
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        handleTap()
        logIn()
        loginButton.ay.startLoading()
    }
}
