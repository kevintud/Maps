import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var location: LocationModel!
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set up map view
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
        // Set up marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = location.name
        marker.map = mapView
    }
    
    // Location manager delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        fetchLoc()
    }
    
    // Fetch location from Google Maps API
    func fetchLoc() {
        guard let currentLocation = currentLocation else { return }
        let origin = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        let destination = "\(location.latitude),\(location.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=AIzaSyD3OFyan7RVBHQqPrls9i-79unOp9yptT4"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    let routes = json["routes"] as! [[String: Any]]
                    DispatchQueue.main.async {
                        for route in routes {
                            let overview_polyline = route["overview_polyline"] as! [String: Any]
                            let points = overview_polyline["points"] as! String
                            let path = GMSPath(fromEncodedPath: points)
                            let polyline = GMSPolyline(path: path)
                            polyline.map = self.mapView
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
