//
//  ViewController.swift
//  Spotify
//
//  Created by LeeHsss on 2022/01/23.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.borderWidth = 3
            $0?.layer.cornerRadius = 10
        }
    }

    @IBAction func clickGoogleLoginButton(_ sender: UIButton) {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientId)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            EmailLoginViewModel.shared.googleLogin(with: credential) { result, error in
                if error == nil {
                    //MARK: 로그인이 성공했다.
                    if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as? CompleteViewController {
                        show(viewController, sender: nil)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func clickAppleLoginButton(_ sender: UIButton) {
        print("Apple")
    }
}

