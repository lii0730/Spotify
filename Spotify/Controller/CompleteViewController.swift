//
//  CompleteViewController.swift
//  Spotify
//
//  Created by LeeHsss on 2022/01/23.
//

import UIKit
import FirebaseAuth

class CompleteViewController: UIViewController {

    @IBOutlet weak var loginSuccessLabel: UILabel!
    var test: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginSuccessLabel.text = """
        환영합니다.
        \(Auth.auth().currentUser?.email ?? "고객")님
        """
    }
    @IBAction func clickLogoutButton(_ sender: UIButton) {
        //MARK: 로그아웃 버튼 클릭시
        EmailLoginViewModel.shared.signOut()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
