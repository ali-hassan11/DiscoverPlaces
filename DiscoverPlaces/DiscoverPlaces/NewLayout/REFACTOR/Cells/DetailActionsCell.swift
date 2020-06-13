
import UIKit

final class DetailActionsCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var favouriteAction: ((Bool) -> Void)?
    var toDoAction: ((Bool) -> Void)?
    var shareAction: (() -> Void)?
    
    var placeId: String?
    var isFave: Bool?

    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? DetailActionsViewModel else { return }
        
        placeId = viewModel.placeId
        isFave = DefaultsManager.isInList(placeId: viewModel.placeId, listKey: .favourites)
        
        configureButtons(using: viewModel)
        configureActions(using: viewModel)
    }
    
    private func configureButtons(using viewModel: DetailActionsViewModel) {
        guard let isFave = isFave else { return }
        favouriteButton.backgroundColor = isFave ? .systemPink : .quaternarySystemFill
        toDoButton.backgroundColor = .red
        shareButton.backgroundColor = .red
    }
    
    private func configureActions(using viewModel: DetailActionsViewModel) {
        favouriteAction = viewModel.actions.favouriteAction
        toDoAction = viewModel.actions.toDoAction
        shareAction = viewModel.actions.shareAction
    }
    
    @IBAction func didTapFavourite(_ sender: Any) {
        toggleFavourite()
    }
    
    @IBAction func didTapToDo(_ sender: Any) {
        toDoAction?(true)
    }
    
    @IBAction func didTapShare(_ sender: Any) {
        shareAction?()
    }
    
    private func toggleFavourite() {
        guard let placeId = placeId, isFave != nil else { return }
            
        //TODO: Make signature more descriptive
        toggle(button: favouriteButton, currentState: &isFave!, placeId: placeId, key: .favourites)
    }
    
    private func toggle(button: UIButton, currentState: inout Bool, placeId: String, key: ListType) {
        if currentState {
            currentState = false
            button.backgroundColor = .quaternarySystemFill
            DefaultsManager.removeFromList(placeId: placeId, listKey: key)
        } else {
            currentState = true
            button.backgroundColor = .systemPink
            DefaultsManager.addToList(placeId: placeId, listKey: key)
        }
    }
}
