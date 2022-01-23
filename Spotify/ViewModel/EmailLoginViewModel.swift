//
//  EmailLoginViewModel.swift
//  Spotify
//
//  Created by LeeHsss on 2022/01/23.
//

import Foundation
import Firebase
import GoogleSignIn

class EmailLoginViewModel {
    
    static let shared: EmailLoginViewModel = EmailLoginViewModel()
    
    
    func createAccount(with email: String, Password pw: String, completionHandler completionHandelr: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pw) { result, error in
            // MARK: 계정 생성
            if error == nil {
                print("create Account")
                completionHandelr(result, nil)
            } else {
                completionHandelr(nil, error)
            }
        }
    }
    
    func googleLogin(with credential: AuthCredential, completion completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if error == nil {
                //MARK: 로그인 성공
                print("로그인 성공")
                completionHandler(authResult, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    func appleLogin(with credential: AuthCredential) {
        
    }
    
    func signOut() {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
        } catch {
            print(error)
        }
    }
}
