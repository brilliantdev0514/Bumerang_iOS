
import Foundation
import UIKit
import SDWebImage

class ChatListCell: UICollectionViewCell {
    
    @IBOutlet weak var ui_avartarImg: UIImageView!
    @IBOutlet weak var ui_userLbl: UILabel!
    @IBOutlet weak var ui_contentLbl: UILabel!
    @IBOutlet weak var ui_timeLbl: UILabel!
    @IBOutlet weak var ui_unreadLbl: UILabel!
    
    var entity : ChatListModel! {
        didSet{
            if entity.imgName.starts(with: "http") {
                ui_avartarImg.sd_setImage(with: URL(string: entity.imgName))
            }
            ui_avartarImg.cornerRadius = ui_avartarImg.bounds.height / 2
            ui_userLbl.text = entity.username
            ui_contentLbl.text = entity.contentStr
            ui_timeLbl.text = entity.reqDate
            ui_timeLbl.isHidden = true;
            ui_contentLbl.isHidden = true;
            if entity.unreadNum > 0 {
                
                ui_unreadLbl.text = "\(entity.unreadNum)"
            } else {
                ui_unreadLbl.isHidden = true
            }
            
            
        }
    }
    @IBAction func popUpActionCell(longPressGesture : UILongPressGestureRecognizer)
        {
            // Delete selected Cell
            let point = longPressGesture.location(in: self.collectionView)
            let indexPath = self.collectionView?.indexPathForItem(at: point)
    //        let cell = self.collectionView?.cellForItem(at: indexPath!)
            if indexPath != nil
            {
                let alertActionCell = UIAlertController(title: "Action Recipe Cell", message: "Choose an action for the selected recipe", preferredStyle: .actionSheet)

                // Configure Remove Item Action
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                    RecipeDataManager.shared.recipes.remove(at: indexPath!.row)
                    print("Cell Removed")
                    self.collectionView!.reloadData()
                })

                // Configure Cancel Action Sheet
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { acion in
                    print("Cancel actionsheet")
                })

                alertActionCell.addAction(deleteAction)
                alertActionCell.addAction(cancelAction)
                self.present(alertActionCell, animated: true, completion: nil)

            }
        }
}
