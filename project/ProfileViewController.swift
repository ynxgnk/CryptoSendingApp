//
//  ProfileViewController.swift
//  project
//
//  Created by Nazar Kopeika on 21.06.2023.
//

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
    var id: String
    
    init(currentEmail: String, id: String) {
        self.currentEmail = currentEmail
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.barTintColor = UIColor(named: "background")
            self.view.backgroundColor = UIColor(named: "cellbackground")
            self.profileCryptoTable.backgroundColor = UIColor(named: "background")

        }
        view.addSubview(profileCryptoTable)
        setUpSignOutButton()
        setUpTableHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileCryptoTable.frame = view.bounds
    }
    
    private func setUpTableHeader(
        profilePhotoRef: String? = nil,
        name: String? = nil
    ) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        headerView.backgroundColor = UIColor(named: "background")
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        profileCryptoTable.tableHeaderView = headerView
                
        //Profile picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
//        profilePhoto.tintColor = .white
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
        
        //ID
        let idLabel = UILabel()
        idLabel.backgroundColor = .red
        idLabel.frame = CGRect(
            x: (view.frame.size.width/2)-50,
            y: 150+10,
            width: 100,
            height: 20
        )
        idLabel.text = id
        idLabel.textColor = .white
        idLabel.font = .systemFont(ofSize: 20, weight: .bold)
        idLabel.textAlignment = .center
        headerView.addSubview(idLabel)
        
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
        
        //Name
        if let name = name {
            title = name
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
    
    private func fetchProfileData() {
        DatabaseManager.shared.getUser(email: currentEmail) { [weak self] user in //tyt
            guard let user = user else {
                return
            }
            self?.user = user
            
            DispatchQueue.main.async {
                self?.setUpTableHeader(
                    profilePhotoRef: user.profilePictureRef,
                    name: user.name
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
        let sheet = UIAlertController(title: "Sign Out", message: "Are you sure you'd like to sing out?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        UserDefaults.standard.set(false, forKey: "premium")
                        
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
    
//    private var cryptos: [CryptoTableViewCellViewModel] = []
        
//        private func fetchCryptos() {
//
//
//            print("Fetching posts...")
//
//            DatabaseManager.shared.getPosts(for: currentEmail) { [weak self] cryptos in
//                self?.cryptos = cryptos
//                print("Found \(cryptos.count) cryptos")
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            }
//        }
    
}

//extension ProfileViewController: UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
//
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        cryptos.count
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let crypto = cryptos[indexPath.row]
//               guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
//                   fatalError()
//               }
//        cell.configure(with: .init(cryptoImageUrl: crypto.cryptoImageUrl, cryptoTitle: crypto.cryptoTitle, cryptoSubtitle: crypto.cryptoSubtitle, cryptoPrice: crypto.cryptoPrice, cryptoPercent: crypto.cryptoPercent))
//               return cell /* 590 */
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    
//}

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
