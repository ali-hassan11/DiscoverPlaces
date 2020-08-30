
import UIKit

struct DetailActionsViewModel: DetailItemViewModelType {
    
    let isFave: Bool
    let isTodo: Bool
    let placeId: String
    
    let cellIconTint: UIColor
    let actionButtonBackgroundColor: UIColor
    let actionButtonTint: UIColor
    let shareAction: (() -> Void)?
    
    init(actions: DetailActionsItem, placeId: String, theming: PlaceDetailTheming) {
        self.placeId = placeId
        
        self.isFave = actions.isFave
        self.isTodo = actions.isToDo
        
        self.cellIconTint = theming.cellIconTint
        self.actionButtonBackgroundColor = theming.actionButtonBackground
        self.actionButtonTint = theming.actionButtonTint
        self.shareAction = actions.shareAction
    }
    
}
