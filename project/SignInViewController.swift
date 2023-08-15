//
//  SignInViewController.swift
//  project
//
//  Created by Nazar Kopeika on 20.06.2023.
//

/*

import UIKit
import FBSDKLoginKit


class SignInViewController: UIViewController {
    
    private let facebookLoginButton: FBLoginButton = { // Add this property
            let button = FBLoginButton()
            return button
        }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Sign In to CryptoBase!"
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    //ID field
    private let idTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "ID"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Email field
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Email Address"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Password field
    private let passwordTextField: UITextField = {
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(facebookLoginButton)
        view.addSubview(logoImageView)
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(idTextField)
        view.addSubview(createAccountButton)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside) /* 591 */
        
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLoginButton() { //default
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let idString = idTextField.text, !idString.isEmpty,
              let id = Int(idString) else {
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                return
            }
            
            DatabaseManager.shared.getUser(email: email, id: Int64(id)) { [weak self] user in
                if let user = user, user.id == id {
                    // ID match found, proceed with login
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(id, forKey: "id")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Woops", message: "Double check your ID.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        facebookLoginButton.frame = CGRect(
            x: (view.frame.size.width / 2) - 50,
            y: 500,
            width: 100,
            height: 30
        )
        
        logoImageView.frame = CGRect(
            x: (view.frame.size.width/2)-60,
            y: 90,
            width: 120,
            height: 120
        )
        
        signInLabel.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 90 + 120 + 40,
            width: 200,
            height: 40
        )
        
        emailTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 240+60+80,
            width: 350,
            height: 50
        )
        
        passwordTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 240+60+80+70,
            width: 350,
            height: 50
        )
        
        idTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 240+70,
            width: 350,
            height: 50
        )
        
        loginButton.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 240+60+80+150,
            width: 200,
            height: 50
        )
        
        createAccountButton.frame = CGRect(
            x: (view.frame.size.width/2)-75,
            y: 410+120+70,
            width: 150,
            height: 30
        )
    }
    
}

*/

// WORKING 2

/*

import UIKit
import FBSDKLoginKit
import FirebaseDatabase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Sign In to CryptoBase!"
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    //ID field
    private let idTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "ID"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Email field
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Email Address"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //Password field
    private let passwordTextField: UITextField = {
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.delegate = self
        facebookLoginButton.contentMode = .center
        facebookLoginButton.layer.cornerRadius = 8
        facebookLoginButton.permissions = ["public_profile", "email"]
        view.addSubview(facebookLoginButton)
        facebookLoginButton.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 590,
            width: 200,
            height: 50
        )
        
        if let email = UserDefaults.standard.string(forKey: "email"),
               let id = UserDefaults.standard.value(forKey: "id") as? Int {
                AuthManager.shared.signIn(email: email, password: "password") { [weak self] success in
                    if success {
                        DispatchQueue.main.async {
                            let vc = TabBarController()
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: false)
                        }
                    }
                }
            }
        
        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completion: { connection, result, error in
                print("\(result)")
            })
        }
        
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(logoImageView)
        view.addSubview(createAccountButton)
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(idTextField)
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.frame = CGRect(
            x: (view.frame.size.width/2)-60,
            y: 90,
            width: 120,
            height: 120
        )
        
        signInLabel.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 90+160,
            width: 200,
            height: 40
        )
        
        emailTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 380,
            width: 350,
            height: 50
        )
        
        passwordTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 450,
            width: 350,
            height: 50
        )
        
        idTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 310,
            width: 350,
            height: 50
        )
        
        loginButton.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 530,
            width: 200,
            height: 50
        )
        
        createAccountButton.frame = CGRect(
            x: (view.frame.size.width/2)-75,
            y: 650,
            width: 150,
            height: 30
        )
    }
    
    @objc private func didTapLoginButton() { //default
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let idString = idTextField.text, !idString.isEmpty,
              let id = Int(idString) else {
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                return
            }
            
            DatabaseManager.shared.getUser(email: email, id: Int64(id)) { [weak self] user in
                if let user = user, user.id == id {
                    // ID match found, proceed with login
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(id, forKey: "id")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Woops", message: "Double check your ID.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func insertUserToDatabase(name: String, email: String, fbId: String) {
        let newUser = User(name: name, email: email, profilePictureRef: nil, id: Int64(fbId) ?? 0, balance: 0)
        DatabaseManager.shared.insert(user: newUser) { inserted in
            if inserted {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(newUser.id, forKey: "id")
                
                DispatchQueue.main.async {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            } else {
                print("Failed to insert user to database")
            }
        }
    }

    
}

extension SignInViewController: LoginButtonDelegate {

//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) { //1
//            if let error = error {
//                print("Facebook login error: \(error.localizedDescription)")
//                return
//            }
//
//            if let token = result?.token?.tokenString {
//                let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"], tokenString: token, version: nil, httpMethod: .get)
//                request.start { connection, result, error in
//                    if let error = error {
//                        print("Facebook Graph API error: \(error.localizedDescription)")
//                        return
//                    }
//
//                    guard let result = result as? [String: Any],
//                          let email = result["email"] as? String,
//                          let name = result["name"] as? String,
//                          let fbId = result["id"] as? String else {
//                        print("Failed to extract required user data from Facebook result")
//                        return
//                    }
//
//                    // Generate a new ID for the Facebook user
//                    DatabaseManager.shared.getNextAvailableUserID { newID in
//                        guard newID > 0 else {
//                            print("Failed to generate a new user ID")
//                            return
//                        }
//
//                        // Create the user in Firebase Authentication
//                        Auth.auth().createUser(withEmail: email, password: "password") { authResult, error in
//                            if let error = error {
//                                print("Failed to create user in Firebase Authentication: \(error.localizedDescription)")
//                                return
//                            }
//
//                            // Insert the user's data into the Firebase Realtime Database
//                            self.insertUserToDatabase(name: name, email: email, id: newID)
//                        }
//                    }
//                }
//            }
//        }
    
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) { //2 current
//        if let error = error {
//            print("Facebook login error: \(error.localizedDescription)")
//            return
//        }
//
//        if let token = result?.token?.tokenString {
//            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"], tokenString: token, version: nil, httpMethod: .get)
//            request.start { connection, result, error in
//                if let error = error {
//                    print("Facebook Graph API error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let result = result as? [String: Any],
//                      let email = result["email"] as? String,
//                      let name = result["name"] as? String,
//                      let fbId = result["id"] as? String else {
//                    print("Failed to extract required user data from Facebook result")
//                    return
//                }
//
//                // Generate a new ID for the Facebook user
////                DatabaseManager.shared.getNextAvailableUserID { newID in
////                    guard newID > 0 else {
////                        print("Failed to generate a new user ID")
////                        return
////                    }
//
//                    // Create the user in Firebase Authentication
//                    Auth.auth().createUser(withEmail: email, password: "password") { authResult, error in
//                        if let error = error {
//                            print("Failed to create user in Firebase Authentication: \(error.localizedDescription)")
//                            return
//                        }
//
//                        guard let user = authResult?.user else {
//                            print("No authenticated user found")
//                            return
//                        }
//
//                        // Link the user with the Facebook provider
//                        let credential = FacebookAuthProvider.credential(withAccessToken: token)
//                        user.link(with: credential) { authResult, error in
//                            if let error = error {
//                                print("Failed to link user with Facebook provider: \(error.localizedDescription)")
//                                return
//                            }
//
//                            // User successfully linked with Facebook provider
//                            // Insert the user's data into the Firebase Realtime Database
//                            self.insertUserToDatabase(name: name, email: email, fbId: String(fbId))
//                        }
//                    }
//                }
//            }
////        }
//    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Facebook login error: \(error.localizedDescription)")
            return
        }

        if let token = result?.token?.tokenString {
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"], tokenString: token, version: nil, httpMethod: .get)
            request.start { _, result, error in
                if let error = error {
                    print("Facebook Graph API error: \(error.localizedDescription)")
                    return
                }

                guard let result = result as? [String: Any],
                      let email = result["email"] as? String,
                      let name = result["name"] as? String,
                      let fbId = result["id"] as? String else {
                    print("Failed to extract required user data from Facebook result")
                    return
                }

                // Check if the user already exists in the Firebase Database
                DatabaseManager.shared.getUser(email: email, id: Int64(fbId) ?? 0) { [weak self] existingUser in
                    if let existingUser = existingUser {
                        // User already exists in the database, proceed with login
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(existingUser.id, forKey: "id")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    } else {
                        // User does not exist, create in Firebase Authentication and link with Facebook provider
                        Auth.auth().createUser(withEmail: email, password: "password") { authResult, error in
                            if let error = error {
                                print("Failed to create user in Firebase Authentication: \(error.localizedDescription)")
                                return
                            }

                            guard let user = authResult?.user else {
                                print("No authenticated user found")
                                return
                            }

                            // Link the user with the Facebook provider
                            let credential = FacebookAuthProvider.credential(withAccessToken: token)
                            user.link(with: credential) { authResult, error in
                                if let error = error {
                                    print("Failed to link user with Facebook provider: \(error.localizedDescription)")
                                    return
                                }

                                // User successfully linked with Facebook provider
                                // Insert the user's data into the Firebase Realtime Database

                                let vc = TabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true)

                                // Insert the user's data into the Firebase Realtime Database
                                self?.insertUserToDatabase(name: name, email: email, fbId: String(fbId))
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {

    }
}


*/

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class SignInViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Sign In to CryptoBase!"
        return label
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()

    private let idTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "ID"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    private let emailTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Email Address"
        field.textColor = .white
        field.backgroundColor = UIColor(named: "cellbackground")
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    private let passwordTextField: UITextField = {
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

    private let loginButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.delegate = self
        facebookLoginButton.contentMode = .center
        facebookLoginButton.layer.cornerRadius = 8
        facebookLoginButton.permissions = ["public_profile", "email"]
        view.addSubview(facebookLoginButton)
        facebookLoginButton.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 590,
            width: 200,
            height: 50
        )

        checkLoginStatus()

        view.backgroundColor = UIColor(named: "background")
        view.addSubview(logoImageView)
        view.addSubview(createAccountButton)
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(idTextField)
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.frame = CGRect(
            x: (view.frame.size.width/2)-60,
            y: 90,
            width: 120,
            height: 120
        )

        signInLabel.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 90+160,
            width: 200,
            height: 40
        )

        emailTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 380,
            width: 350,
            height: 50
        )

        passwordTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 450,
            width: 350,
            height: 50
        )

        idTextField.frame = CGRect(
            x: (view.frame.size.width/2)-175,
            y: 310,
            width: 350,
            height: 50
        )

        loginButton.frame = CGRect(
            x: (view.frame.size.width/2)-100,
            y: 530,
            width: 200,
            height: 50
        )

        createAccountButton.frame = CGRect(
            x: (view.frame.size.width/2)-75,
            y: 650,
            width: 150,
            height: 30
        )
    }

    @objc private func didTapLoginButton() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let idString = idTextField.text, !idString.isEmpty,
              let id = Int(idString) else {
            return
        }

        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                return
            }

            DatabaseManager.shared.getUser(email: email, id: Int64(id)) { [weak self] user in
                if let user = user, user.id == id {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(id, forKey: "id")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Woops", message: "Double check your ID.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    private func checkLoginStatus() {
        if let email = UserDefaults.standard.string(forKey: "email"),
           let id = UserDefaults.standard.value(forKey: "id") as? Int {
            AuthManager.shared.signIn(email: email, password: "password") { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: false)
                    }
                }
            }
        }
    }
}

extension SignInViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Facebook login error: \(error.localizedDescription)")
            return
        }

        if let token = result?.token?.tokenString {
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"], tokenString: token, version: nil, httpMethod: .get)
            request.start { _, result, error in
                if let error = error {
                    print("Facebook Graph API error: \(error.localizedDescription)")
                    return
                }

                guard let result = result as? [String: Any],
                      let email = result["email"] as? String,
                      let name = result["name"] as? String,
                      let fbId = result["id"] as? String else {
                    print("Failed to extract required user data from Facebook result")
                    return
                }

                DatabaseManager.shared.getUser(email: email, id: Int64(fbId) ?? 0) { [weak self] existingUser in
                    if let existingUser = existingUser {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(existingUser.id, forKey: "id")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    } else {
                        Auth.auth().createUser(withEmail: email, password: "password") { authResult, error in
                            if let error = error {
                                print("Failed to create user in Firebase Authentication: \(error.localizedDescription)")
                                return
                            }

                            guard let user = authResult?.user else {
                                print("No authenticated user found")
                                return
                            }

                            let credential = FacebookAuthProvider.credential(withAccessToken: token)
                            user.link(with: credential) { authResult, error in
                                if let error = error {
                                    print("Failed to link user with Facebook provider: \(error.localizedDescription)")
                                    return
                                }

                                let vc = TabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true)

                                self?.insertUserToDatabase(name: name, email: email, fbId: String(fbId))
                            }
                        }
                    }
                }
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "id")
            print("User logged out and data cleared.")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    private func insertUserToDatabase(name: String, email: String, fbId: String) {
        let newUser = User(name: name, email: email, profilePictureRef: nil, id: Int64(fbId) ?? 0, balance: 0)
        DatabaseManager.shared.insert(user: newUser) { inserted in
            if inserted {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(newUser.id, forKey: "id")
                
                DispatchQueue.main.async {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            } else {
                print("Failed to insert user to database")
            }
        }
    }
}
