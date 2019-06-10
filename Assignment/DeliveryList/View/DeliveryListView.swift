import UIKit
import SDWebImage
import NotificationBannerSwift

class DeliveryListView: UIViewController {
    
    var listTableView = UITableView()
    var presenter: DeliveryListPresenterProtocol?
    var deliveryList: [Product] = []
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchDeliveryList()
        setup()
        addRefreshControl()
        
    }
    
    // MARK: UI Update
    
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = Constant.ViewControllerTitle.listVCTitle
        view.backgroundColor = .white
        listTableView.frame = view.bounds
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
        listTableView.accessibilityIdentifier = "table--deliveryTableView"
        listTableView.tableFooterView = UIView()
        
    }
    
    func addRefreshControl() {
        
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        listTableView.addSubview(refreshControl)
    }
    
    @objc func refreshList() {
        DispatchQueue.main.async {
            self.presenter?.refreshList()}}
    
}

extension DeliveryListView: DeliveryListViewProtocol {
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            let banner = StatusBarNotificationBanner(title: errorMessage, style: .danger)

            banner.show(bannerPosition: .bottom)}}
    func showLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.activityIndicator.color = UIColor.gray
            if !self.view.subviews.contains(ActivityIndicator.activityIndicator) {
                self.view.addSubview(ActivityIndicator.activityIndicator)
                ActivityIndicator.activityIndicator.center = self.view.center
            }
            ActivityIndicator.activityIndicator.startAnimating()}}
    
    func hideLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.activityIndicator.stopAnimating()
            ActivityIndicator.activityIndicator.removeFromSuperview()}}
    func showBottomLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: self.listTableView.bounds.width, height: Constant.Dimension.height.rawValue)
            self.listTableView.tableFooterView = self.activityIndicator
            self.listTableView.tableFooterView?.isHidden = false
        }
    }
    
    func refreshData(products: [Product]) {
        DispatchQueue.main.async {
            print(self.deliveryList.append(contentsOf: products))
            self.deliveryList = products
            print(self.deliveryList)
            
            print("refreshdata")
            self.listTableView.reloadData()
                                  }
        }
    
    func hideTopLoading() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    func hideBottomLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.listTableView.tableFooterView = UIView()
        }
        
    }
    
    func showProducts(with delivery: [Product]) {
        
        print(deliveryList.append(contentsOf: delivery))
        deliveryList = delivery
        print(deliveryList)
        
        print(deliveryList.count)
        print("show products")
        listTableView.reloadData()
    }
}

extension DeliveryListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listCell) as! DeliveryTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        let product = deliveryList[indexPath.row]
        let imgURL = URL(string: product.imageURL ?? "")
        cell.productImageView.sd_setImage(with: imgURL, placeholderImage: nil, options: [], progress: nil, completed: nil)
        cell.descLabel.text = product.description! + " at " + (product.location?.address)!
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
            presenter?.fetchDeliveryList()}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deliveryList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.showDeliveryDetail(delivery: deliveryList[indexPath.row])
        
    }
    
}

struct ActivityIndicator {
    static var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
}
