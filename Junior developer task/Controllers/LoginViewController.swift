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
    }
    
    // MARK: - Config
    
    func configureTextFields() {
        usernameTextField.placeholder = "Username:"
        passwordTextField.placeholder = "Password:"
        
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
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        handleTap()
    }
}
