//
//  LoginViewController.swift
//  omniBox
//
//  Created by Артем Закиров on 26.11.2018.
//  Copyright © 2018 bmstu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class LoginViewController : UIViewController{
    
    private let seguename = "toMain"
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        checkRegistrated()
    }
    
    func checkRegistrated(){
        let realm = try! Realm()
        let login = loginField.text!
        let checkingPerson = realm.objects(User.self)   //заходим  в базу
        let filtered = checkingPerson.filter("user_id == %@",login).first //фильтруем и ищем по нужным параметрам
        if filtered != nil {
            let pass = filtered?.password as! String
            if (pass == passwordField.text!){
                print("Excellent!")
            } else {
                print(pass)
                print("POWEL HA XYU! parol")
                callAlert()
                passwordField.text = ""
            }
        } else {
            print("POWEL HA XYU! persona")
            callAlert()
            loginField.text = ""
            passwordField.text = ""
        }
        
    }


func callAlert(){
    let alertView = UIAlertController(title: "Ошибка", message: "Проверьте введенные данные", preferredStyle: .alert)
    
    let add = UIAlertAction(title: "Ок", style: .destructive) { (action) in
    }
   alertView.addAction(add)
    self.present(alertView, animated: true, completion: nil)
}

    
    override func viewWillAppear(_ animated: Bool) {
        loginField.text = ""
        passwordField.text = ""
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguename{
            guard
            let vc = segue.destination as? ViewController
                else {return}
            let realm = try! Realm()
            let login = loginField.text!
            let checkingPerson = realm.objects(User.self)   //заходим  в базу
            let filtered = checkingPerson.filter("user_id == %@",login).first
            if filtered != nil {
                vc.user = filtered!}
        }
    }
    
}