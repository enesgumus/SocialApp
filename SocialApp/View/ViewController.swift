//
//  ViewController.swift
//  SocialApp
//
//  Created by Enes Gümüş on 21.10.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sifreTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    @IBAction func girisYapButton(_ sender: Any) {
        
        if emailTextField.text != "" && sifreTextfield.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextfield.text!) { autdataresult, error in
                
                if error != nil {
                    self.hataGoster(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız, tekrar deneyin")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
        }else{
            hataGoster(titleInput: "HATA!", messageInput: "E-mail ve Şifre Giriniz")
        }
        
        
    }
    
    
    
    @IBAction func kayitButton(_ sender: Any) {
        
        if emailTextField.text != "" && sifreTextfield.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextfield.text!) { authdataresult, error in
                
                if error != nil{
                    self.hataGoster(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız, tekrar deneyin")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
                
            }
            
        }else{
            
            hataGoster(titleInput: "HATA!", messageInput: "E-mail ve Şifre Giriniz")
            
        }
        
        
    }
    
    func hataGoster(titleInput:String,messageInput:String){
        
        let alertController = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        self.present(alertController,animated: true
        )
        
    }
    
    
    

}

