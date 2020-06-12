import UIKit

final class NEWPlaceDetailController: UITableViewController {
    
    
    var viewModel: DetailsViewModel //make let
    
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
        tableView.register(RegularCell.nib(), forCellReuseIdentifier: RegularCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension                
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RegularCell.self), for: indexPath) as? RegularCell else {
                return UITableViewCell()
            }
            cell.configure(using: regularDetailViewModel)
            return cell
        default:
            fatalError()
        }
    }
}
