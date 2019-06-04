import Foundation

struct Product: Codable {
    
    var id: Int?
    var imageURL: String?
    var description: String?
    var location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "imageUrl"
        case description = "description"
        case location = "location"
    }
    
    init(id: Int, address: String, detail: String, lattitude: Double, longitude: Double, imageURL: String) {
        self.id = id
        self.imageURL = imageURL
        self.description = detail
        location = Location(lattitude: lattitude, longitude: longitude, address: address)
    }
    
    init(product: DeliveryProduct) {
        id = Int(product.id)
        imageURL = product.imageURL
        description = product.detail 
        location = Location(product: product)
    }
}
