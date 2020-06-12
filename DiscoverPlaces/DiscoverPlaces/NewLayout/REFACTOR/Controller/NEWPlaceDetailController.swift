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
        
        setupNavigationBar()
        setupTableView()
        
        guard Reachability.isConnectedToNetwork() else {
            return
        }
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

//MARK: Setup Methods
extension NEWPlaceDetailController {
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(RegularCell.nib(), forCellReuseIdentifier: RegularCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.dataSource = viewModel
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hideBackButtonText()
        navigationController?.navigationBar.makeTransparent()
    }
}
