import Foundation
import Alamofire

class Network {
    
    struct Constants {
        static let baseUrl = "https://api.flickr.com/services/rest/"
    }
    
    func searchImages(search: String) {
        let apiKey = "cceece829f07c59816bf44a53c649404"
        let extras = "url_o"
        let format = "json"
        //perpage
        let noJsonCallback = 1
        let searchText = search
        
        let baserUrl = Constants.baseUrl;
        let destinationUrl =
            baserUrl + "?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchText)&extras=\(extras)&format=\(format)&nojsoncallback=\(noJsonCallback)"
        
        guard let searchRequest = URL(string: destinationUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let photosWrapper = try JSONDecoder().decode(PhotoListWrapper.self, from: data)
                print(photosWrapper.photos)
            } catch let jsonErr {
                print("Error serializ json ", jsonErr)
            }
            }.resume()
    }
    
    
}
