import Foundation

struct Location: Codable {
    
    var lattitude: Double?
    var longitude: Double?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case lattitude = "lat"
        case longitude = "lng"
        case address = "address"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lattitude = try values.decode(Double.self, forKey: .lattitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        address = try values.decode(String.self, forKey: .address)
    }
    
    init(product: DeliveryProduct) {
        lattitude = product.latitude
        longitude = product.longitude
        address = product.address 
    }
    
    init(lattitude: Double, longitude: Double, address: String) {
        self.lattitude = lattitude
        self.longitude = longitude
        self.address = address
    }
    
}
