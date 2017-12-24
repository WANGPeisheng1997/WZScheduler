//
//  LoginViewController.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/24.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit
//import SnapKit

var account = Account()

class LoginViewController: UIViewController {
    
    var clockImage: UIImageView!
    var appLabel: UILabel!
    var lineImage: UIImageView!
    var usernameGroundView: UIView!
    var usernameField: UITextField!
    var passwordGroundView: UIView!
    var passwordField: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var width, height: CGFloat!
    
    func initialize() {
        
        width = view.frame.width
        height = view.frame.height
        
        clockImage = UIImageView()
        clockImage.image = #imageLiteral(resourceName: "LoginView_Clock")
        clockImage.contentMode = .scaleAspectFit
        
        appLabel = UILabel()
        //appLabel.font = UIFont(name: "Quenda", size: height * 0.06)
        appLabel.font = UIFont.systemFont(ofSize: height * 0.048)
        appLabel.text = "WZ日程管理助手"
        appLabel.textAlignment = .center
        appLabel.textColor = .white
        
        lineImage = UIImageView()
        lineImage.image = #imageLiteral(resourceName: "LoginView_Line")
        
        usernameGroundView = UIView()
        let tmp0 = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.078))
        tmp0.image = #imageLiteral(resourceName: "LoginView_Box")
        usernameGroundView.addSubview(tmp0)
        let tmp1 = UIImageView(frame: CGRect(x: height * 0.03, y: height * 0.015, width: height * 0.0495, height: height * 0.0495))
        tmp1.image = #imageLiteral(resourceName: "LoginView_User")
        usernameGroundView.addSubview(tmp1)
        
        usernameField = UITextField()
        usernameField.delegate = self
        usernameField.returnKeyType = .done
        usernameField.placeholder = "用户名"
        usernameField.font = UIFont.systemFont(ofSize: height * 0.03)
        usernameGroundView.addSubview(usernameField)
        
        passwordGroundView = UIView()
        let tmp2 = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.078))
        tmp2.image = #imageLiteral(resourceName: "LoginView_Box")
        passwordGroundView.addSubview(tmp2)
        let tmp3 = UIImageView(frame: CGRect(x: height * 0.0345, y: height * 0.0165, width: height * 0.039, height: height * 0.039))
        tmp3.image = #imageLiteral(resourceName: "LoginView_Password")
        passwordGroundView.addSubview(tmp3)
        
        passwordField = UITextField()
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "密码"
        passwordField.font = UIFont.systemFont(ofSize: height * 0.03)
        passwordGroundView.addSubview(passwordField)
        
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.039)
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
        let buttonImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Login").cgImage!, scale: 2000 / height, orientation: .up)
        loginButton.backgroundColor = UIColor(patternImage: buttonImage)
        loginButton.setTitleColor(.white, for: .normal)
        
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.027)
        //registerButton.addTarget(self, action: #selector(LoginViewController.jumpToRegister), for: .touchUpInside)
        registerButton.setTitleColor(ColorTable.textBlue, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        self.title = "登录"
        
        self.view.addSubview(clockImage)
        self.view.addSubview(appLabel)
        self.view.addSubview(lineImage)
        self.view.addSubview(usernameGroundView)
        self.view.addSubview(passwordGroundView)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        let bgImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Background").cgImage!, scale: 960 / height, orientation: .up)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        clockImage.frame = CGRect(x: width / 2 - height * 0.075, y: height * 0.227, width: height * 0.15, height: height * 0.15)
        appLabel.frame = CGRect(x: width / 2 - height * 0.31125, y: height * 0.4015, width: height * 0.6225, height: height * 0.054)
        lineImage.frame = CGRect(x: width / 2 - height * 0.23625, y: height * 0.4875, width: height * 0.4725, height: height * 0.0045)
        usernameGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.5175, width: height * 0.4875, height: height * 0.078)
        usernameField.frame = CGRect(x: height * 0.1, y: height * 0.0255, width: height * 0.40425, height: height * 0.0315)
        passwordGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.597, width: height * 0.4875, height: height * 0.078)
        passwordField.frame = CGRect(x: height * 0.1, y: height * 0.0255, width: height * 0.39975, height: height * 0.0315)
        loginButton.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.6975, width: height * 0.4875, height: height * 0.0735)
        registerButton.frame = CGRect(x: width / 2 - height * 0.0285, y: height * 0.795, width: height * 0.057, height: height * 0.0285)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Touch event
    func login(){
        
        let url = URL(string: "http://115.159.59.44:5000/login")!
        var request = URLRequest(url: url)
        let params:NSMutableDictionary = NSMutableDictionary()
        params["kind"] = "login"
        params["username"] = "WPS"
        params["password"] = "IamWPS"
        /*
        params["username"] = usernameField.text!
        params["password"] = passwordField.text!
 */
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonData:NSData? = nil
        do {
            jsonData  = try JSONSerialization.data(withJSONObject: params, options:JSONSerialization.WritingOptions.prettyPrinted) as NSData?
        } catch {
            
        }
        request.httpBody = jsonData as Data?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = response, let data = data {
                //print(response)
                var json:NSDictionary? = nil
                do {
                    json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.init(rawValue:0)) as? NSDictionary
                } catch {
                    
                }
                
                account.username = json?["username"]! as! String?
                account.db_id = json?["db_id"]! as! NSNumber?
//                let email = json["email"]!
//                let signature = json["signature"]!
//                let avatar = json["avatar"]!
//                let background = json["background"]!
                print("\(account.username!) has successfully loged in")
                //这里json保存了帐户id username email等各项属性的dictionary，等profile要用全局变量就在这里添加
                
                self.jumpToHomepage()
                
            } else {
                print(error!)
            }
        }
        
        task.resume()
    }
    
    func jumpToHomepage() {
        let avc = SchedulerController()
        self.present(avc, animated: true, completion: nil)
        //self.navigationController?.pushViewController(avc, animated: false)
    }
    /*
    func jumpToRegister() {
        let avc = RegisterViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
 */
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
