//
//  ProfileViewController.swift
//  project
//
//  Created by Nazar Kopeika on 21.06.2023.
//

import FBSDKLoginKit
import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    private var user: User?
    
    private let profileCryptoTable: UITableView = {
        let table = UITableView()
        table.register(CryptoTableViewCell.self,
                       forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return table
    }()
    
    let currentEmail: String
    let id: Int64
    var balance: Int64
    
    init(currentEmail: String, id: Int64, balance: Int64) {
        self.currentEmail = currentEmail
        self.id = id
        self.balance = balance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.barTintColor = UIColor(named: "background")
            self.view.backgroundColor = UIColor(named: "background")
            self.profileCryptoTable.backgroundColor = UIColor(named: "background")
        }
        view.addSubview(profileCryptoTable)
        setUpSignOutButton()
        setUpTableHeader(balance: balance)
        fetchProfileData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileCryptoTable.frame = view.bounds
    }
    
    private func setUpTableHeader(
        profilePhotoRef: String? = nil,
        name: String? = nil,
        balance: Int64
    ) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        headerView.backgroundColor = UIColor(named: "background")
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        profileCryptoTable.tableHeaderView = headerView
        
        //Profile picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(
            x: (view.width-(view.width/4))/2,
            y: (headerView.height-(view.width/4))/2.5,
            width: view.width/4,
            height: view.width/4
        )
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.width/2
        profilePhoto.isUserInteractionEnabled = true
        headerView.addSubview(profilePhoto)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto))
        profilePhoto.addGestureRecognizer(tap)
        
        //Name
        if let name = name {
            title = name
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        if let ref = profilePhotoRef {
            //Fetch image
            StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
                guard let url = url else {
                    return
                }
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        profilePhoto.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        }
        
        //ID
        let idLabel = UILabel()
        idLabel.contentMode = .center
        idLabel.frame = CGRect(
            x: (view.frame.size.width/2)-150,
            y: 150+25,
            width: 300,
            height: 20
        )
        headerView.addSubview(idLabel)
        idLabel.text = "ID: \(id)"
        idLabel.textAlignment = .center
        idLabel.textColor = .white
        idLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        //Email
        let emailLable = UILabel(frame: CGRect(
            x: 20,
            y: profilePhoto.bottom+10,
            width: view.width-40,
            height: 100)
        )
        headerView.addSubview(emailLable)
        emailLable.text = currentEmail
        emailLable.textAlignment = .center
        emailLable.textColor = .white
        emailLable.font = .systemFont(ofSize: 25, weight: .bold)
        
        //Settings
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.frame = CGRect(
            x: profilePhoto.right+60,
            y: -62,
            width: 150,
            height: 150
        )
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        headerView.addSubview(settingsButton)
        
        //Balance
        let balanceLabel = UILabel(frame: CGRect(
            x: profilePhoto.left-173,
            y: 5,
            width: 200,
            height: 17)
        )
        balanceLabel.tag = 100 // Set a unique tag for the label
        headerView.addSubview(balanceLabel)
        balanceLabel.text = "Balance: \(balance) $"
        balanceLabel.textAlignment = .center
        balanceLabel.textColor = .white
        balanceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        //Update Balance
        let updateButton = UIButton()
        updateButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        updateButton.frame = CGRect(
            x: settingsButton.left-30,
            y: -62,
            width: 150,
            height: 150
        )
        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        headerView.addSubview(updateButton)
    }
    
    @objc private func didTapUpdateButton() {
        // Fetch the updated balance from Firebase
        DatabaseManager.shared.getUser(email: currentEmail, id: id) { [weak self] user in
            guard let user = user else {
                return
            }
            // Update the balance property with the new value from Firebase
            self?.balance = user.balance
            
            // Get the balanceLabel from the headerView using the tag
            if let balanceLabel = self?.profileCryptoTable.tableHeaderView?.viewWithTag(100) as? UILabel {
                DispatchQueue.main.async {
                    // Update the balanceLabel text with the new balance value
                    balanceLabel.text = "Balance: \(self?.balance ?? 0) $"
                }
            }
        }
    }
    
    @objc private func didTapSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapProfilePhoto() {
        guard let myEmail = UserDefaults.standard.string(forKey: "email"),
              myEmail == currentEmail else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func fetchProfileData() { //default
        DatabaseManager.shared.getUser(email: currentEmail, id: id) { [weak self] user in
            guard let user = user else {
                return
            }
            self?.user = user
            
            DispatchQueue.main.async {
                self?.setUpTableHeader(
                    profilePhotoRef: user.profilePictureRef,
                    name: user.name,
                    balance: user.balance
                )
            }
        }
    }
    
    private func setUpSignOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(didTapSignOut)
        )
    }
    
    /// Sign Out
    @objc private func didTapSignOut() {
        let sheet = UIAlertController(title: "Sign Out", message: "Are you sure you'd like to sign out?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            FBSDKLoginKit.LoginManager().logOut() // Log out from Facebook
            AuthManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        UserDefaults.standard.set(nil, forKey: "id")
                        
                        let signInVC = SignInViewController()
                        signInVC.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVC = UINavigationController(rootViewController: signInVC)
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: nil)
                    }
                }
            }
        }))
        present(sheet, animated: true)
    }


}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationBarDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        StorageManager.shared.uploadUserProfilePicture(
            email: currentEmail,
            image: image
        ) { [weak self] success in
            guard let strongSelf = self else { return }
            if success {
                //Update database
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                    guard updated else {
                        return
                    }
                    DispatchQueue.main.async {
                        strongSelf.fetchProfileData()
                    }
                }
            }
        }
    }
}
