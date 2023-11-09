

import UIKit
import GoogleMaps

protocol LocationRouterProtocol: AnyObject {
    func navigateToMap(with location: LocationModel)
}

class LocationRouter: LocationRouterProtocol {
    weak var viewController: LocationViewController?
    
    func navigateToMap(with location: LocationModel) {
        viewController?.performSegue(withIdentifier: "showMapView", sender: location)
    }
  
}
