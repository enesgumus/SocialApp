//
//  UploadViewController.swift
//  SocialApp
//
//  Created by Enes Gümüş on 22.10.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    

        
    }
    
    @objc func gorselSec(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @IBAction func yukleButton(_ sender: Any) {
        
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        let uuid = UUID()
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { storagemetadata, error in
                
                if error != nil{
                    self.hataMesaji(title: "HATA", message: error?.localizedDescription ?? "Hata Aldınız,tekrar deneyin")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                            
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["gorselurl":imageUrl, "yorum":self.yorumTextField.text!, "kullaniciAdi":Auth.auth().currentUser!.email!, "tarih": FieldValue.serverTimestamp()] as [String:Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil {
                                        self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata Aldınız, tekrar deneyin")
                                    }else{
                                        self.imageView.image = UIImage(named: "gorselSec")
                                        self.yorumTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func hataMesaji(title:String,message:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "HATA", style: .default)
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true)
        
        
        
        
    }
    

}
