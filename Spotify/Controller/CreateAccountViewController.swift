//
//  CreateAccountViewController.swift
//  Spotify
//
//  Created by LeeHsss on 2022/01/23.
//

import UIKit
import Firebase
import SwiftUI

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var inputPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createAccountButton.isEnabled = false
        self.title = "계정 생성"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.inputEmailTextField.becomeFirstResponder()
        self.inputEmailTextField.delegate = self
        self.inputPasswordTextField.delegate = self
        
    }
    
    @IBAction func clickNextButton(_ sender: UIButton) {
        //MARK: 다음버튼 클릭시
        
        EmailLoginViewModel.shared.createAccount(
            with: self.inputEmailTextField.text!,
            Password: self.inputPasswordTextField.text!
        ) { result, error in
            guard let viewController: CompleteViewController = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as? CompleteViewController else { return }
            if error == nil {
                guard let userEmail = result?.user.email else { return }
                viewController.test = "환영합니다! \(userEmail)님"
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                self.errorMessageLabel.text = error?.localizedDescription
            }
        }
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 엔터 클릭햇을 때
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Validation 처리
        let isEmailEmpty = self.inputEmailTextField.text == ""
        let isPasswordEmpty = self.inputPasswordTextField.text == ""
        
        self.createAccountButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
