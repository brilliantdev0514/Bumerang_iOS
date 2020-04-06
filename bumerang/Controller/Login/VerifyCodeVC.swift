//
//  VerifyEmailVC.swift
//  bumerang
//
//  Created by RMS on 2019/9/8.
//  Copyright © 2019 RMS. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyCodeVC: BaseViewController {
    
    var mail = ""
    var countCallApi = 0
    
    @IBOutlet weak var ui_viewMain: UIView!
    @IBOutlet weak var ui_codeTxt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_viewMain.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTaped(sender:))))
    }
    
    @IBAction func onClickVerify(_ sender: Any) {
        
        let codeTxt = ui_codeTxt.text!
        if codeTxt.isEmpty {
            showToast(R_EN.string.ENTER_VERIFY_CODE, duration: 2, position: .center)
            return
        }
        callVerifyCode(codeTxt)
    }
    
    func callVerifyCode(_ verifyCode: String) {
        
        self.showALLoadingViewWithTitle(title: "Requesting now", type: .messageWithIndicator )
        // call api
        UserApiManager.verifyCode(email: mail, verifyCode: verifyCode) { (isSuccess, data) in
            
            self.hideALLoadingView()
            if isSuccess {
                
                if signinVC != nil {
                    self.ui_codeTxt.text = ""
                    let userId = JSON(data!).stringValue
                    signinVC.gotoSetPwdVC(userId)
                } else {
                    print("error")
                }
                
            }
            else {
                if data == nil {
                    if self.countCallApi == 2 {
                        self.countCallApi += 1
                        self.callVerifyCode(verifyCode)
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
        if signinVC != nil {
            ui_codeTxt.text = ""
            ui_codeTxt.endEditing(true)
            signinVC.hideVerifyCodeVC(true)
        } else {
            print("error")
        }
    }

}
