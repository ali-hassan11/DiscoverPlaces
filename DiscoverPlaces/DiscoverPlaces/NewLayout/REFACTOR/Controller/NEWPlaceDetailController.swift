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
        edgesForExtendedLayout = [.top, .left, .right]

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(RegularCell.nib(), forCellReuseIdentifier: RegularCell.reuseIdentifier)
        tableView.register(MainImageSliderCell.nib(), forCellReuseIdentifier: MainImageSliderCell.reuseIdentifier)
        tableView.register(DetailActionsCell.nib(), forCellReuseIdentifier: DetailActionsCell.reuseIdentifier)
        tableView.register(SectionSliderCell.nib(), forCellReuseIdentifier: SectionSliderCell.reuseIdentifier)
        tableView.register(GoogleCell.nib(), forCellReuseIdentifier: GoogleCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
    
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hideBackButtonText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = true
    }
}
