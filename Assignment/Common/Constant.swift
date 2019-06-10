import Foundation
import UIKit

struct API {
    static let baseUrl = "https://mock-api-mobile.dev.lalamove.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Deliveries: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/deliveries"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}

struct Constant {
    
    // MARK: Struct
    
    struct CellIdentifier {
        static let listCell = "ProductListCell"
    }
    
    struct Endpoint {
        static let deliveries = "/deliveries"
    }
    
    // MARK: Enum
    
    enum Dimension: CGFloat {
        case zeroSpacing = 0.0
        case spacing = 15.0
        case trailingspacing = 50.0
        case bottomspacingDetailView = 40
        case trailingspacingDetailView = 10
        case imageHieghtWidth = 70.0
        case deliveryDetailViewHeight = 100.0
        case height = 71.0
    }
    
    struct ImageDimension {
        private init() {}
        static let kCellImageHeight = 100.0
        static let kCellImageWidth = 100.0
    }
    
    enum DataSource {
        case dataBase, server
    }
    
    // MARK: Stored Properties
    static var dataSource = DataSource.dataBase
    static let pagingLimit = 20
    static let fontSize: CGFloat = 16
    static let tableAccessibilityIdentifier = "table--deliveryTableView"
    static let appToastMessageBackgroundColor = UIColor(red: 217/255.0, green: 96/255.0, blue: 86/255, alpha: 1.0)

}

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

struct LocalizationConstant {
    static let listVCTitle = NSLocalizedString("listVCTitle", comment: "")
    static let detailVCTitle =  NSLocalizedString("detailVCTitle", comment: "")
    static let internetError = NSLocalizedString("internetError", comment: "")
    static let otherError = NSLocalizedString("otherError", comment: "")
    static let noDeliveries = NSLocalizedString("noDeliveries", comment: "")
    static let coreDataError = NSLocalizedString("coreDataError", comment: "")
    static let noDataError = NSLocalizedString("noDataError", comment: "")
}

struct Paging {
    var offset: Int
    let limit: Int
}
