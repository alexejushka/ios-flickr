import Foundation
import UIKit

class PhotoWithImage {
    
    let photo: Photo
    var uiImage: UIImage?
    
    init(photo: Photo, uiImage: UIImage) {
        self.photo = photo
        //self.uiImage = uiImage
        
//        do {
//            let url = flickrImageURL()
//            let data = try Data(contentsOf: url!)
//            self.uiImage = UIImage(data: data)
//        }
//        catch {
//            print(error)
//        }
        
//        guard
//            let url = flickrImageURL(),
//            let imageData = try? Data(contentsOf: url as URL)
////            else {
////                return nil
//        //}
//
//        if let image = UIImage(data: imageData) {
//            flickrPhoto.thumbnail = image
//            return flickrPhoto
//        } else {
//            return nil
//        }
    }
    
    func flickrImageURL(_ size: String = "m") -> URL? {
//        if let url = URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(size).jpg") {
//            return url
//        }
        return nil
    }
    
}
