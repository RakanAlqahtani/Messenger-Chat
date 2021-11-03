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
        
        //           do {
        //               try FirebaseAuth.Auth.auth().signOut()
        //           }
        //           catch {
        //           }
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
            //               guard let strongSelf = self else {
            //                   return
            //               }
            
            
            //               let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            //
            //               let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            //
            //               self.navigationController?.pushViewController(vc, animated: true)
            //
            //               vc.tabBarController?.tabBar.isHidden = true\\
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        }
        
        //               let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        //                         self.navigationController?.popViewController(animated: true)
    }
    
}


