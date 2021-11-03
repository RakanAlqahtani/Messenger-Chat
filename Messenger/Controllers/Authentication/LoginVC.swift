//
//  LoginVC.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
class LoginVC : UIViewController , LoginButtonDelegate  {
    

        
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn() {
                   // Show the ViewController with the logged in user
               }else{
                   // Show the Home ViewController
               }
        
//
//        if let token = AccessToken.current, !token.isExpired {
//
//            let token = token.tokenString
//            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email , name"] , tokenString: token, version: nil, httpMethod: .get)
//
//            request.start(completionHandler : {connection , result , error in
//                print("\(result)")
//
//            })
//        } else {
//
////
////            let log = FBLoginButton()
//
//        let  facebookLogin = FBLoginButton()
//            facebookLoginButton = facebookLogin
//            facebookLoginButton.delegate = self
//
//        }
//
        // Do any additional setup after loading the view.
    }
    
    
        @IBAction func facebookLogin(_ sender: UIButton) {
    
            self.loginButtonClicked()
            
            
//
//            if let token = AccessToken.current, !token.isExpired {
//
//                loginButton(<#FBLoginButton#>, didCompleteWith: <#LoginManagerLoginResult?#>, error: <#Error?#>)
//            } else {
//
//
//                let loginButton = FBLoginButton()
//
//                loginButton.center = view.center
//                loginButton.delegate = self
//                loginButton.permissions = ["public_profile", "email"]
//                view.addSubview(loginButton)
    
            }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
            let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
            graphRequest.start { _, result, error in
                if error == nil {
                    let data: [String: AnyObject] = result as! [String: AnyObject]
                    
                    // Facebook Id
                    if let facebookId = data["id"] as? String {
                        print("Facebook Id: \(facebookId)")
                    } else {
                        print("Facebook Id: Not exists")
                    }
                    
                    // Facebook First Name
                    if let facebookFirstName = data["first_name"] as? String {
                        print("Facebook First Name: \(facebookFirstName)")
                    } else {
                        print("Facebook First Name: Not exists")
                    }
                    
                    // Facebook Middle Name
                    if let facebookMiddleName = data["middle_name"] as? String {
                        print("Facebook Middle Name: \(facebookMiddleName)")
                    } else {
                        print("Facebook Middle Name: Not exists")
                    }
                    
                    // Facebook Last Name
                    if let facebookLastName = data["last_name"] as? String {
                        print("Facebook Last Name: \(facebookLastName)")
                    } else {
                        print("Facebook Last Name: Not exists")
                    }
                    
                    // Facebook Name
                    if let facebookName = data["name"] as? String {
                        print("Facebook Name: \(facebookName)")
                    } else {
                        print("Facebook Name: Not exists")
                    }
                    
                    // Facebook Profile Pic URL
                    let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                    print("Facebook Profile Pic URL: \(facebookProfilePicURL)")
                    
                    // Facebook Email
                    if let facebookEmail = data["email"] as? String {
                        print("Facebook Email: \(facebookEmail)")
                    } else {
                        print("Facebook Email: Not exists")
                    }
                    
                    print("Facebook Access Token: \(token?.tokenString ?? "")")
                } else {
                    print("Error: Trying to get user's info")
                }
            }
        }
    
    func isLoggedIn() -> Bool {
            let accessToken = AccessToken.current
            let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
            return isLoggedIn
        }
    
    func loginButtonClicked() {
            let loginManager = LoginManager()
            loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
                if error != nil {
                    print("ERROR: Trying to get login results")
                } else if result?.isCancelled != nil {
                    print("The token is \(result?.token?.tokenString ?? "")")
                    if result?.token?.tokenString != nil {
                        print("Logged in")
                        self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                    } else {
                        print("Cancelled")
                    }
                }
            })
        }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {return}
        
        guard let password = passwordTextField.text else {return}
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            //            guard let strongSelf = self else {
            //                return
            //            }
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(email)")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            
            
        })
        
       
    }
    
    
    @IBAction func singupAction(_ sender: UIButton) {
        
        let register = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    
     
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email , name"] , tokenString: token, version: nil, httpMethod: .get)
        
        request.start(completionHandler : {connection , result , error in
            print("\(result)")
            
        })
        
    }
    
}

//extension LoginVC : LoginButtonDelegate {
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
//
//
//
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email , name"] , tokenString: token, version: nil, httpMethod: .get)
//
//        request.start(completionHandler : {connection , result , error in
//            print("\(result)")
//
//        })
//
//    }
//}
