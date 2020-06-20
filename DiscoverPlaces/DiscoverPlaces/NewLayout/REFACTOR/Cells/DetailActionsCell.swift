
import UIKit

final class DetailActionsCell: UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var shareAction: (() -> Void)?
    
    var placeId: String?
    var isFave: Bool?
    var isToDo: Bool?

    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? DetailActionsViewModel else { return }
        
        selectionStyle = .none
        placeId = viewModel.placeId
        
        shareAction = viewModel.shareAction
        
        isFave = DefaultsManager.isInList(placeId: viewModel.placeId, listKey: .favourites)
        isToDo = DefaultsManager.isInList(placeId: viewModel.placeId, listKey: .toDo)
        
        configureButtons(using: viewModel)
    }
    
    private func configureButtons(using viewModel: DetailActionsViewModel) {
        guard let isFave = isFave, let isToDo = isToDo else { return }
        
        //Attribited
        favouriteButton.setTitle(" Favourite", for: .normal)
        let favouriteIcon = UIImage(systemName: isFave ? Icon.heartFilled.name : Icon.heartOutline.name)
        favouriteButton.setImage(favouriteIcon, for: .normal)
        favouriteButton.tintColor = viewModel.actionButtonTint
        favouriteButton.backgroundColor = viewModel.actionButtonBackgroundColor
        favouriteButton.roundCorners()
        
        let toDoIcon = UIImage(systemName: isToDo ? Icon.toDoFilled.name : Icon.toDoOutline.name)
        toDoButton.setTitle(" To-Do", for: .normal)
        toDoButton.setImage(toDoIcon, for: .normal)
        toDoButton.tintColor = viewModel.actionButtonTint
        toDoButton.backgroundColor = viewModel.actionButtonBackgroundColor
        toDoButton.roundCorners()
        
        let shareIcon = UIImage(systemName: Icon.share.name)
        shareButton.setTitle(" Share", for: .normal)
        shareButton.setImage(shareIcon, for: .normal)
        shareButton.tintColor = viewModel.actionButtonTint
        shareButton.backgroundColor = viewModel.actionButtonBackgroundColor
        shareButton.roundCorners()
    }
    

    @IBAction func didTapFavourite(_ sender: Any) {
        guard let placeId = placeId, isFave != nil else { return }
        toggle(button: favouriteButton, currentState: &isFave!, placeId: placeId, key: .favourites)
    }
    
    @IBAction func didTapToDo(_ sender: Any) {
        guard let placeId = placeId, isToDo != nil else { return }
        toggle(button: toDoButton, currentState: &isToDo!, placeId: placeId, key: .toDo)
    }
    
    @IBAction func didTapShare(_ sender: Any) {
        shareAction?()
    }
    
    //TODO: Make signature more descriptive
    private func toggle(button: UIButton, currentState: inout Bool, placeId: String, key: ListType) {
        
        let selectedIcon = UIImage(systemName: key == .favourites ? Icon.heartFilled.name : Icon.toDoFilled.name)
        let deselectedIcon = UIImage(systemName: key == .favourites ? Icon.heartOutline.name : Icon.toDoOutline.name)
        
        if currentState {
            currentState = false
            button.setImage(deselectedIcon, for: .normal)
            DefaultsManager.removeFromList(placeId: placeId, listKey: key)
        } else {
            currentState = true
            button.setImage(selectedIcon, for: .normal)
            DefaultsManager.addToList(placeId: placeId, listKey: key)
        }
    }
}
