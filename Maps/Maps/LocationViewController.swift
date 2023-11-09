
import UIKit

protocol LocationViewProtocol: AnyObject {
    func reloadData()
    func setLocations(location: [LocationModel])
}

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LocationViewProtocol {
    var presenter: LocationPresenter!
    var location: [LocationModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LocationPresenter()
        presenter.view = self
        presenter.interactor = LocationInteractor()
        let router = LocationRouter()
        router.viewController = self
        presenter.router = router
        presenter?.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return location.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.locations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectLocation(at: indexPath.row)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setLocations(location: [LocationModel]) {
        self.location = location
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapView",
           let mapViewController = segue.destination as? MapViewController,
           let location = sender as? LocationModel {
            mapViewController.location = location
        }
    }
    
}
