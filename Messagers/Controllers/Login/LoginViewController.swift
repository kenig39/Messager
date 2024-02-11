//
//  loginViewController.swift
//  Messagers
//
//  Created by Alexander on 09.02.2024.
//

import UIKit

class LoginViewController: UIViewController {

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let scrolView: UIScrollView = {
        let scrolView = UIScrollView()
        scrolView.clipsToBounds = true
        return scrolView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address ...."
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        
        //Add subViews
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width/3
        
        imageView.frame = CGRect(x: (view.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
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
  
 
