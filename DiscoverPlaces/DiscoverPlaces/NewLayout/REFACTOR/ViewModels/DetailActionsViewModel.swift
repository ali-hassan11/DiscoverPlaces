
import Foundation

struct DetailActionsViewModel: DetailItemViewModel {
    
    let actions: DetailActionsItem
    let placeId: String
    
    init(placeId: String, actions: DetailActionsItem) {
        self.placeId = placeId
        self.actions = actions
    }
    
}
