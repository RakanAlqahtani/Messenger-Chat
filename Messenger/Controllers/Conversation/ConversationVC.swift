//
//  ConversationVC.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import UIKit
import FirebaseAuth
class ConversationVC: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()

           do {
               try FirebaseAuth.Auth.auth().signOut()
           }
           catch {
           }
        DatabaseManger.shared.test() // call test!

       }
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
     
           validateAuth()
       }
    
    @IBAction func singOutAction(_ sender: Any) {
        
            do {
            try FirebaseAuth.Auth.auth().signOut()
                validateAuth()
        }
        catch {
        }
    
    }
 
    
       
       private func validateAuth(){
           // current user is set automatically when you log a user in
           if FirebaseAuth.Auth.auth().currentUser == nil {
               // present login view controller
               let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
               self.navigationController?.pushViewController(vc, animated: true)
           }
       }

}
