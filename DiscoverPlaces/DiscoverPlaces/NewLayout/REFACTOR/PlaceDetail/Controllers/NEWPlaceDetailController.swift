import UIKit

final class NEWPlaceDetailController: UIViewController {
  
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let viewModel: DetailsViewModel
    private let coordinator: DetailCoordinatable
    
    private let loadingView: DetailLoadingView
    
    init(coordinator: DetailCoordinatable, viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.loadingView = DetailLoadingView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupTableView()
        setupNavigationBar()
                
        guard Reachability.isConnectedToNetwork() else {
            self.loadingView.didFinishLoading()
            self.showErrorController(error: .init(title: Constants.noInternetConnectionTitle,
                                                  message: Constants.noInternetConnetionMessage))
            return
        }
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchPlaceData { [weak self] error in
            
            if error != nil {
                DispatchQueue.main.async {
                    self?.loadingView.didFinishLoading()
                    self?.showErrorController(error: .init(title: Constants.noResultsTitle,
                                                           message: Constants.genericNoConnectionMessage))
                    return
                }
            }
            
            DispatchQueue.main.async {
                self?.loadingView.didFinishLoading()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showErrorController(error: CustomError) {
        coordinator.pushErrorController(message: error.message)
    }
}

//MARK: Helper Methods
extension NEWPlaceDetailController {
    
    private func addViews() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        view.addSubview(loadingView)
        loadingView.fillSuperview()
    }
    
    private func setupTableView() {
        edgesForExtendedLayout = [.top, .left, .right]

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(RegularCell.nib(), forCellReuseIdentifier: RegularCell.reuseIdentifier)
        tableView.register(MainImageSliderCell.nib(), forCellReuseIdentifier: MainImageSliderCell.reuseIdentifier)
        tableView.register(DetailActionsCell.nib(), forCellReuseIdentifier: DetailActionsCell.reuseIdentifier)
        tableView.register(ReviewSliderCell.nib(), forCellReuseIdentifier: ReviewSliderCell.reuseIdentifier)
        tableView.register(PlaceSliderCell.nib(), forCellReuseIdentifier: PlaceSliderCell.reuseIdentifier)
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

protocol LoadingViewType {
    func didFinishLoading()
}

final class LoadingView: UIView, LoadingViewType {
    
    internal var loadingIndicator = LoadingIndicatorView()
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        addSubview(loadingIndicator)
        loadingIndicator.centerInSuperview()
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didFinishLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.loadingIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
}

final class DetailLoadingView: UIView, LoadingViewType {
    
    var loadingIndicator = LoadingIndicatorView()
    
    init() {
        super.init(frame: .zero)
        
        let topView = UIView()
        topView.constrainHeight(constant: 430)
        topView.backgroundColor = .secondarySystemBackground
        topView.addSubview(loadingIndicator)
        loadingIndicator.centerInSuperview()
        
        let bottomView = UIView()
        bottomView.backgroundColor = .systemBackground
        
        let stackView = VerticalStackView(arrangedSubviews: [topView, bottomView])
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didFinishLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.loadingIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
}

