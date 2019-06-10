import UIKit
import Alamofire

class ConnectivityManager {
    
    class func isConnectedToInternet() -> Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            return reachabilityManager.isReachable
        }
        return false
    }
    
}
