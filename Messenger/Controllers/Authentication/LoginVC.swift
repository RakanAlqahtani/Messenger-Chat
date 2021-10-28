//
//  LoginVC.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func singupAction(_ sender: UIButton) {
        
        let register = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        self.navigationController?.pushViewController(register, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
