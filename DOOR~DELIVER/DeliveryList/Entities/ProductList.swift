import Foundation

struct ProductList: Codable {
    let productList: [Product]
    
    init(from decoder: Decoder) throws {
        var productList = [Product]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let product = try? container.decode(Product.self) {
                productList.append(product)
            } else {
            }
        }
        self.productList = productList
    }
}
