//
//  ChatVC.swift
//  bumerang
//
//  Created by RMS on 2019/9/12.
//  Copyright © 2019 RMS. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import FirebaseAuth
import Firebase
import FirebaseDatabase
class ChatListVC: BaseViewController {

    let databaseChats = Constants.refs.databaseRoot.child("Bumerang_chat")
    var chatlistData = [ChatListModel]()
    
    @IBOutlet weak var ui_searchBar: UISearchBar!
    @IBOutlet weak var ui_chatdata_coll: UICollectionView!
    @IBOutlet weak var outerview: UIView!
    @IBOutlet weak var autoview: UIView!
    @IBOutlet weak var nomessageimage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.bringSubviewToFront(outerview)
       
        loadListdata()
        
        
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func loadListdata() {
//        for i in 0 ..< 0 {
//            
//            let one = ChatListModel(senderId: Defaults[.userId], receiverId: i, imgName: "avatar_1", username: "user \(i)", contentStr: "hey, what are you doing now?", reqDate: "1hr ago", unreadNum: i)
//            chatlistData.append(one)
//        }
//        
//        ui_chatdata_coll.reloadData()
        let chatList = Database.database().reference().child("message")
        
        let uid = Auth.auth().currentUser!.uid
        let receiveUserId: String = ""
        let room_id = "\(uid)_\(receiveUserId)"


        chatList.observe(.value, with: { (snapshot) in
                  // Get user value
                    if !snapshot.exists() {
                        // handle data not found
                        return
                    }
                    
            let chatList = snapshot.children.allObjects as! [DataSnapshot]
            for data in chatList{                
                
                print(data)
                for data2 in data.children.allObjects as! [DataSnapshot] {
                    
                    
                    if let data2 = data2.value as? [String: AnyObject] {
                                            
                            var bIsSame = false
                            for chatRoomModel in self.chatlistData {
                                
                                if data2["name"] as? String != nil && chatRoomModel.username ==  data2["name"] as? String {
                                    
                                    bIsSame = true;
                                    break
                                }
                            }
                            
                            if (!bIsSame) {
                                
                                let objFirt = ChatListModel.parseMessageData(ary: NSArray(object: data2)).object(at: 0)
                                if data2["name"]as? String != (ShareData.user_info.first_name + " " + ShareData.user_info.last_name)
                                {self.chatlistData.append(objFirt as! ChatListModel)}
                            }
                        
                    }
                }
                
            }
            
            //let chatData = snapshot.value as! [String: String]
        //          Users user = Users.init(dict: value)
            self.ui_chatdata_coll.reloadData()
            
            if self.chatlistData.count == 0 {
                
                self.view.bringSubviewToFront(self.outerview)
               
                
            }else{
             
                
                self.autoview.bringSubviewToFront(self.autoview)
                self.outerview.isHidden = true
                //self.outerview.removeFromSuperview()
                
            }
            
                  // ...
                  })
    }
    
    @IBAction func onClickPluse(_ sender: Any) {
        self.gotoNavigationScreen("CatagorySelectVC", direction: .fromLeft)
    }
    
    @IBAction func onClickChart(_ sender: Any) {
                
        self.gotoTabVC("MainpageAfterNav")
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        
        
        
    }
    
    @IBAction func onClickRend(_ sender: Any) {
        //self.gotoTabVC("RentHistoryNav")

        let toSearch = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        //toSearch.delegate = self
        self.modalPresentationStyle = .fullScreen
        self.present(toSearch, animated: true, completion: nil)
    }
    
    @IBAction func onClickMyProfile(_ sender: Any) {
        
        self.gotoMyInfoVC(oneProduct: nil)
        
    }
}

extension ChatListVC : UISearchBarDelegate {
    
    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true;
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
    }
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
}

extension ChatListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatRoomVC") as! ChatRoomVC
        toVC.receiveUserId = chatlistData[indexPath.row].senderId
        
        self.navigationController?.pushViewController(toVC, animated: true)
        
    }
    
}

extension ChatListVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chatlistData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        
        
        
        cell.entity = chatlistData[indexPath.row]
        
        
        
        return cell
    }
}

extension ChatListVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = collectionView.frame.size.width
        let h : CGFloat = 100
        return CGSize(width: w, height: h)
    }
}
