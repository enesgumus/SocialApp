//
//  SettingViewController.swift
//  SocialApp
//
//  Created by Enes Gümüş on 22.10.2023.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func cikisYap(_ sender: Any) {
        
        
        
        
        do {
            try Auth.auth().signOut()
            
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch{
            print(error.localizedDescription)
        }
        
    }
    

}
