//
//  RecoveryEmailVC.swift
//  bumerang
//
//  Created by RMS on 2019/9/8.
//  Copyright © 2019 RMS. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecoveryEmailVC: BaseViewController {

    @IBOutlet weak var ui_mainView: UIView!
    @IBOutlet weak var ui_emailTxt: CustomTextField!
    var countCallApi = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTaped(sender:))))
        
        ui_mainView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        
        let mailTxt = ui_emailTxt.text!
        if mailTxt.isEmpty {
            showToast(R_EN.string.ENTER_MAIL_PHONE, duration: 2, position: .center)
            return
        }
        gotoForgotApi(mailTxt)
    }
    
    func gotoForgotApi(_ mail : String){
        
        self.showALLoadingViewWithTitle(title: "Requesting now", type: .messageWithIndicator )
        
        // call api
        UserApiManager.fogotPWD(email: mail){ (isSuccess, data) in
            
            self.hideALLoadingView()
            if isSuccess {
                
                if signinVC != nil {
                    self.ui_emailTxt.text = ""
                    signinVC.gotoVerifyCodeVC(mail)
                } else {
                    print("error")
                }
            } else {
                if data == nil {
                    if self.countCallApi == 2 {
                        self.countCallApi += 1
                        self.gotoForgotApi(mail)
                    } else {
                        self.showToast(R_EN.string.CONNECT_FAIL)
                    }
                } else {
                    self.showToast(JSON(data!).stringValue)
                }
            }
        }
    }
    
    @IBAction func onTapedClose(_ sender: Any) {
        hideMe()
    }
    @objc func handleTaped(sender: UITapGestureRecognizer){
        hideMe()
    }
    
    func hideMe() {
        
        self.ui_emailTxt.endEditing(true)
        ui_emailTxt.endEditing(true)
        
        if signinVC != nil {
            ui_emailTxt.text = ""
            signinVC.hideRecoveryEmailVC(true)
        } else {
            print("error")
        }
    }
}
