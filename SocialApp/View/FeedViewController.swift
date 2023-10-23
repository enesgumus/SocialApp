//
//  FeedViewController.swift
//  SocialApp
//
//  Created by Enes Gümüş on 22.10.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    
    var postDizisi = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTableView.dataSource = self
        postTableView.delegate = self
        
        verileriAl()
        
    }
    
    
    func verileriAl(){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata Aldınız Tekrar deneyin")
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        if let gorselurl = document.get("gorselurl") as? String {
                            if let yorum = document.get("yorum") as? String{
                                if let email = document.get("kullaniciAdi") as? String {
                            
                                    let post = Post(email: email, yorum: yorum, gorselUrl: gorselurl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.postTableView.reloadData()
                }
            }
        }
    }
    

    

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostID", for: indexPath) as! PostTableViewCell
        
        cell.kullaniciLabel.text = postDizisi[indexPath.row].email
        cell.yorumTextfield.text = postDizisi[indexPath.row].yorum
        cell.PostImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselUrl))
        
        return cell
    }
    
    func hataMesaji(title:String,message:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "HATA", style: .default)
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true)
        
        
        
    }
    
    
}
