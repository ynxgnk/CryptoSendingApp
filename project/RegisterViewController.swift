//
//  RegisterViewController.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //Header View
    private let headerView = SignInHeaderView()
    
    //Name field
    private let nameField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Full Name"
        field.autocorrectionType = .no
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Email field
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Email Address"
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Password field
    private let passwordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    private let idField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "ID"
        field.autocorrectionType = .no
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Sign In Button
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(headerView)
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(idField)
        view.addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: (view.frame.size.width/4), y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height/5)
        
        nameField.frame = CGRect(x: 20, y: headerView.bottom, width: view.width-40, height: 50)
        emailField.frame = CGRect(x: 20, y: nameField.bottom+10, width: view.width-40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 50)
        idField.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: idField.bottom+10, width: view.width-40, height: 50)
        
    }
    
    @objc func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty,
              let idString = idField.text, !idString.isEmpty,
              let id = Int(idString) else {
            return
        }
        
        //Create Account
        AuthManager.shared.signUp(email: email, password: password, id: idString) { [weak self] success in   /* 591 add weak self */
            if success {
                //Update database
                
                let balanceZero: Int64 = 20
                let newUser = User(name: name, email: email, profilePictureRef: nil, id: Int64(id), balance: balanceZero)
                DatabaseManager.shared.insert(user: newUser) { inserted in
                    guard inserted else {
                        return
                    }
                    
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(id, forKey: "id")
                    
                    print("HERE ID \(id)")
                    
                    DispatchQueue.main.async {
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                }
            } else {
                print("Failed to create account")
            }
        }
        //Update database
    }
}
