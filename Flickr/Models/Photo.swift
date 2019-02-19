import Foundation
import UIKit

struct Photo : Decodable {
    public var id: String?
    public var url_o: String?    
    let photoID: String?
    let farm: Int?
    let server: String?
    let secret: String?
    let title: String?
}
