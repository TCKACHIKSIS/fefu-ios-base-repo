//
//  LoginController.swift
//  fefuactivity
//
//  Created by иван on 16.12.2021.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var loginTextField: Fefu_text_field_type_1!
    static private let encoder = JSONEncoder()
    @IBOutlet weak var passwordTextField: Fefu_text_field_type_1!
    @IBAction func loginButton(_ sender: Any) {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
                
        let body = UserLoginBody(login: login, password: password)
                
        do {
            let reqBody = try LoginController.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            ConnectToBackend.login(reqBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
            }onError: { err in
                DispatchQueue.main.async {
                    print(err)
                }
        }

        } catch {
            print(error)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
}
