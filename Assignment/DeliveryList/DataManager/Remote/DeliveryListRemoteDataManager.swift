import Foundation
import Alamofire
import SwiftyJSON

class DeliveryListRemoteDataManager: DeliveryListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol?
    
    func retrieveDeliveryList(_ params: [String: Any]) {
        self.apiGet(serviceName: Endpoints.Deliveries.fetch.url, parameters: params) { (response, error) in
            if let error = error {
                self.remoteRequestHandler?.onError(errorMessage: error.localizedDescription)
            }
            let decoder = JSONDecoder()
            do {
                if let data = try response?.rawData() {
                    let productList = try decoder.decode(ProductList.self, from: data)
                    self.remoteRequestHandler?.onDeliveryRetrieved(productList)
                }
            } catch {
                self.remoteRequestHandler?.onError(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func apiGet(serviceName: String, parameters: [String: Any]?, completionHandler: @escaping (JSON?, NSError?) -> Void) {
        request(serviceName, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let json = JSON(data)
                    completionHandler(json, nil)
                }
            case .failure:
                completionHandler(nil, response.result.error as NSError?)
            }
        }
    }
    
}
