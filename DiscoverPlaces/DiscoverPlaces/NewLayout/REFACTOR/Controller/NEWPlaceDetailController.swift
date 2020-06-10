import UIKit

final class NEWPlaceDetailController: UITableViewController {
    
    
    let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
//        RegisterCells()
//        Estimated/Dynamic row height
        
    }
    
    
}

extension NEWPlaceDetailController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.itemForRow(at: indexPath)
        
        switch item.type {
        case .regular(let regularDetailViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.attributedText = regularDetailViewModel.title
            cell.backgroundColor = regularDetailViewModel.backgroundColor
            return cell
        default:
            fatalError()
        }
    }
    
}

extension NEWPlaceDetailController {
    
    
    
}
