//
//  LoginViewControllerExt.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-07.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import SnapKit

extension LoginViewController {
    func setConstraints() {
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200).labeled("usernameTextTop")
            make.width.equalToSuperview().multipliedBy(0.5).labeled("usernameTextWidth")
            make.centerX.equalToSuperview().labeled("usernameTextCenterX")
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(30).labeled("passwordTextTop")
            make.width.equalTo(usernameTextField.snp.width).labeled("passwordTextWidth")
            make.centerX.equalToSuperview().labeled("passwordTextCenterX")
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50).labeled("loginBtnTop")
            make.width.equalTo(usernameTextField.snp.width).labeled("loginBtnWidth")
            make.centerX.equalToSuperview().labeled("loginBtnCenterX")
        }
    }
}
