//
//  RegistrationControllet.swift
//  fefuactivity
//
//  Created by иван on 15.12.2021.
//

import UIKit

struct Gender: Decodable {
    var code: Int
    var name: String
}

struct User: Decodable {
    var id: Int
    var name: String
    var login: String
    var gender: Gender
}

struct Tocken : Decodable {
    var token: String
    var user : User
}


class RegistrationControllet: UIViewController {

    @IBOutlet weak var genderTextField: Fefu_text_field_type_1!
    @IBOutlet weak var nicknameTextField: Fefu_text_field_type_1!
    @IBOutlet weak var loginTextField: Fefu_text_field_type_1!
    @IBOutlet weak var buttonShowPassword: UIButton!
    @IBOutlet weak var buttonShowRepeatPassword: UIButton!
    @IBOutlet weak var passwordTextField: Fefu_text_field_type_1!
    @IBOutlet weak var repeatPasswordTextField: Fefu_text_field_type_1!
    @IBAction func showPasswordField(_ sender: Any) {
    }
    @IBAction func showRepeatPasswordField(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        guard let url = URL(string: "https://fefu.t.feip.co/api/auth/register") else {return}
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { data, _, error in
            
            if let data = data {
                let decoder  = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let dataUsersModel = try decoder.decode([Tocken].self, from: data)
                    
                    let firstStruct = dataUsersModel.first
                    print(firstStruct?.user.id, " ", firstStruct?.user.name, " ",
                          firstStruct?.user.gender.name)
                    
                } catch let decodingError{
                    print("Ошибка - ", decodingError )
                }
            }
            return
            
        }
        task.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit(){
        // в этом моменте так и просятся питоновские замыкания, но когда я попытался выяснить как делать подобные вещи на свифте, понял что это затянется на долго, поэтому пока оставил такой вот стремный варик с двумя почти одинаковыми функциями longTap и longTap2. Потом почитаю и постараюсь поправить Еще я хотел попробовать вместо 2х одинаковых функций передавать textField в качестве параметра, но там возникают заморочки
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        let longGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(longTap2(_:)))
        buttonShowPassword.addGestureRecognizer(longGesture)
        buttonShowRepeatPassword.addGestureRecognizer(longGesture2)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            self.passwordTextField.isSecureTextEntry = true
        }
        else if sender.state == .began {
            self.passwordTextField.isSecureTextEntry = false
        }
    }
    @objc func longTap2(_ sender: UIGestureRecognizer){

        if sender.state == .ended {
            self.repeatPasswordTextField.isSecureTextEntry = true;
            
        }
        else if sender.state == .began {
            self.repeatPasswordTextField.isSecureTextEntry = false;
        }
    }
}


func saveForLogin(){
    guard let url = URL(string: "https://fefu.t.feip.co/api/auth/register") else {return}
    let urlRequest = URLRequest(url: url)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: urlRequest) { data, _, error in
        
        if let data = data {
            let decoder  = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let dataUsersModel = try decoder.decode([Tocken].self, from: data)
                
                let firstStruct = dataUsersModel.first
                print(firstStruct?.user.id, " ", firstStruct?.user.name, " ",
                      firstStruct?.user.gender.name)
                
            } catch let decodingError{
                print("Ошибка - ", decodingError )
            }
        }
        return
        
    }
    task.resume()
}
