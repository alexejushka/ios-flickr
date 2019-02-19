import UIKit

class PreviewViewController: UIViewController {

    var photo: FlickrPhoto?
    @IBOutlet weak var photoFullSize: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = photo?.title
        
        photo?.loadLargeImage() {result in

            switch result {
            case .results(let photo):
                self.photoFullSize.image = photo.largeImage
            case .error(_):
                return
            }
        }
    }
    
}
