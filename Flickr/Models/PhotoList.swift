import Foundation
import ObjectMapper

struct PhotoList : Decodable {
    var page: Int?
    var pages: Int?
    var photo: [Photo]?
}
