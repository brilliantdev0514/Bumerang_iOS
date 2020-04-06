

import Foundation
import Firebase

class FirebaseAPI {
    
    static let ref = Database.database().reference()
    
    static let CONV_REFERENCE = "bumerang-a7a29"

    // MARK: - send Chat
    static func sendMessage(_ chat:[String:String], _ chatRoomId: String, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        
        ref.child(CONV_REFERENCE).child("Chat").child(chatRoomId).setValue(chat) { (error, dataRef) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, "Sent a message successfully.")
            }
        }
    }
    
    static func parseChat(_ snapshot: NSDictionary) -> ChatRoomModel {
        
        let chat = ChatRoomModel()
        
//        let chat = ChatRoomModel(senderId: snapshot["userid"] as! Int , receiverId: 1, strDate: getLocalTimeString(fromDate: Date()), strMsg: snapshot["msgContent"] as! String, userImageUrl: "")
        
        return chat
    }
    
    // MARK: - Set/remove observer for chat
    static func setNewChatObserver(_ chatRoomId: String, _ handle: @escaping (_ newChat: ChatRoomModel) -> ()) -> UInt {
        
        return ref.child(CONV_REFERENCE).child("Chat").child(chatRoomId).queryLimited(toLast: 1).observe(.childAdded) { (snapshot, error) in
            let childref = snapshot.value as? NSDictionary
            if let childRef = childref {
                let message = parseChat(childRef)
                handle(message)
            } else {
            }
        }
    }
    
    static func removeChatObserver(_ handle : UInt, roomId: String) {
        ref.child(CONV_REFERENCE).child("Chat").child(roomId).removeObserver(withHandle: handle)
    }

 
}
