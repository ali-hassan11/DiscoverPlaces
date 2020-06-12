import UIKit

final class NEWPlaceDetailController: UITableViewController {
    
    
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Details"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(RegularCell.nib(), forCellReuseIdentifier: RegularCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = viewModel
        
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchPlaceData { [weak self] error in
            
            if let error = error {
                print("delegate.showErrorAlert \(error)")
            }
            
            self?.tableView.reloadData()
        }
    }
}
