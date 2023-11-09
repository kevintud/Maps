
import UIKit

protocol LocationPresenterProtocol: AnyObject {
    var numberOfLocations: Int { get }
    func viewDidLoad()
    func location(at index: Int) -> LocationModel
    func didSelectLocation(at index: Int)
}

class LocationPresenter: LocationPresenterProtocol {
    
    weak var view: LocationViewProtocol?
    var router: LocationRouterProtocol!
    var interactor: LocationInteractorProtocol!
    var locations: [LocationModel] = []
    
    var numberOfLocations: Int {
        return locations.count
    }
    
    
    func viewDidLoad() {
        locations = interactor.fetchLocations()
        print(locations)
        view?.setLocations(location: locations)
        view?.reloadData()
    }
    
    func location(at index: Int) -> LocationModel {
        return locations[index]
    }
    
    func didSelectLocation(at index: Int) {
        let location = locations[index]
        router.navigateToMap(with: location)
    }

}
