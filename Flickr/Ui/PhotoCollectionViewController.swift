import UIKit

class PhotoCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var selectedPhoto: FlickrPhoto?
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    private let activityLoadIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityLoadIndicator()
    }
    
    func initActivityLoadIndicator() {
        activityLoadIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityLoadIndicator.color = UIColor.black
        self.view.addSubview(activityLoadIndicator)
    }
    
    func saveSuggest(word: String) {
        if var savedSuggest: String = UserDefaults.standard.string(forKey: "suggest") {
            print("savedURL \(savedSuggest)")
            savedSuggest += word
            
            UserDefaults.standard.set(savedSuggest, forKey: "suggest")
        }
    }
    
    func segueToPreview(photo: FlickrPhoto) {
        selectedPhoto = photo
        self.performSegue(withIdentifier: "toPreview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPreview" {
            let destination = segue.destination as! PreviewViewController
            destination.photo = selectedPhoto
        }
    }
    
    func photoForIndex(_ indexPath: IndexPath) -> FlickrPhoto {
        return searches[0].searchResults[indexPath.row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activityLoadIndicator.startAnimating()
        
        flickr.searchFlickr(for: textField.text!) { searchResults in
            self.activityLoadIndicator.stopAnimating()

            switch searchResults {
            case .error(let error) :
                print("Error Searching: \(error)")
            case .results(let results):
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                
                self.searches.removeAll()
                self.searches.insert(results, at: 0)

                self.collectionView?.reloadData()
            }
        }
        
        saveSuggest(word: textField.text!)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //FILL COLLECTION VIEW
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(searches.count == 0) {
            return 0
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[0].searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath) as! PhotoCell
        let flickrPhoto = photoForIndex(indexPath)
        cell.smallImage.image = flickrPhoto.thumbnail
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhotoFromList = photoForIndex(indexPath)
        segueToPreview(photo: selectedPhotoFromList)
        
        print("User tapped on item \(indexPath.row) \(String(describing: selectedPhotoFromList.flickrImageURL()))")
    }
    
    //FLOW LAYOUT STUFF
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
