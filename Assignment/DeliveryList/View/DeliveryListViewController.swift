import UIKit
import SDWebImage
import Toast_Swift

struct ActivityIndicator {
    static var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
}

class DeliveryListViewController: UIViewController {
    var listTableView = UITableView()
    var presenter: DeliveryListPresenterProtocol?
    var deliveryList: [Product]?
    let refreshControl = UIRefreshControl()
    let bottomactivityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addRefreshControl()
        presenter?.fetchDeliveryList()
    }
    
    // MARK: UI Update
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = LocalizationConstant.listVCTitle
        view.backgroundColor = .white
        view.addSubview(listTableView)
        listTableView.backgroundColor = .white
        listTableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifier.listCell)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .singleLine
        listTableView.separatorInset = .zero
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.setTopConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setLeadingConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setTrailingConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.setBottomConstraint(secondView: view, constant: Constant.Dimension.zeroSpacing.rawValue)
        listTableView.accessibilityIdentifier = Constant.tableAccessibilityIdentifier
        listTableView.tableFooterView = UIView()
    }
    
    func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        listTableView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        self.presenter?.pullToRefresh()
    }
}

extension DeliveryListViewController: DeliveryListViewProtocol {
    
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageColor = UIColor.white
            style.backgroundColor = Constant.appToastMessageBackgroundColor
            self.view.makeToast(errorMessage, duration: 2.0, position: .top, style: style)
        }
    }
    
    func showNoDataLabel() {
        let noDataLabel: UILabel = UILabel(frame: self.listTableView.bounds)
        noDataLabel.text = LocalizationConstant.noDeliveries
        noDataLabel.textAlignment = .center
        noDataLabel.sizeToFit()
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.listTableView.backgroundView = noDataLabel
        }
        listTableView.reloadData()
    }
    
    func showProducts(with delivery: [Product]) {
        self.refreshControl.endRefreshing()
        listTableView.backgroundView = nil
        deliveryList = delivery
        listTableView.reloadData()
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.activityIndicator.color = UIColor.gray
            if !self.view.subviews.contains(ActivityIndicator.activityIndicator) {
                self.view.addSubview(ActivityIndicator.activityIndicator)
                ActivityIndicator.activityIndicator.center = self.view.center
            }
            ActivityIndicator.activityIndicator.startAnimating()
        }
    }
    
    func showBottomLoading() {
        DispatchQueue.main.async {
            self.bottomactivityIndicator.startAnimating()
            self.bottomactivityIndicator.frame = CGRect(x: 0, y: 0, width: self.listTableView.bounds.width, height: Constant.Dimension.height.rawValue)
            self.listTableView.tableFooterView = self.bottomactivityIndicator
            self.listTableView.tableFooterView?.isHidden = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.activityIndicator.stopAnimating()
            ActivityIndicator.activityIndicator.removeFromSuperview()
            self.refreshControl.endRefreshing()
            self.bottomactivityIndicator.stopAnimating()
            self.listTableView.tableFooterView = UIView()
        }
    }
}

extension DeliveryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listCell) as! DeliveryTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        let product = deliveryList?[indexPath.row]
        let imgURL = URL(string: product?.imageURL ?? "")
        cell.productImageView.sd_setImage(with: imgURL, placeholderImage: nil, options: [], progress: nil, completed: nil)
        cell.descLabel.text = "\(product?.description ?? "") at \(product?.location?.address ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if let list = deliveryList {
                list.isEmpty ? nil : presenter?.fetchDeliveryList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = self.deliveryList else {return}
        _ = presenter?.showDeliveryDetail(delivery: list[indexPath.row])
    }
}
