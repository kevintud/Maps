

import Foundation
protocol LocationInteractorProtocol: AnyObject {
    func fetchLocations() -> [LocationModel]
}

class LocationInteractor: LocationInteractorProtocol {
    func fetchLocations() -> [LocationModel] {
        return [
            LocationModel(name: "Tagaytay", latitude: 14.1172832, longitude: 120.8865308),
            LocationModel(name: "Baguio", latitude: 16.3994238, longitude: 120.4411206),
            LocationModel(name: "Metro Manila", latitude: 14.5964947, longitude: 120.9383599)
        ]
    }
}
