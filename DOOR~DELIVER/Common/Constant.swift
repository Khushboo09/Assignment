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
    static let fontSize: CGFloat = 14
    static let tableAccessibilityIdentifier = "table--deliveryTableView"

}

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

struct LocalizationConstant {
    static let listVCTitle = NSLocalizedString("listVCTitle", comment: "")
    static let detailVCTitle =  NSLocalizedString("detailVCTitle", comment: "")
    static let interneterror = NSLocalizedString(ErrorMessege.internetError.rawValue, comment: "")
    static let othererror = NSLocalizedString(ErrorMessege.other.rawValue, comment: "")
    static let nodeliveries = NSLocalizedString("No deliveries.Retry by pulling upwards.", comment: "")
    static let coredataerror = NSLocalizedString(ErrorMessege.coreDataError.rawValue, comment: "")
}

struct Paging {
    var offset: Int
    let limit: Int
}