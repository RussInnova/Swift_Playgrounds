import MapKit
import UIKit
import XCPlayground

class ViewController: UIViewController, MKMapViewDelegate {

    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        self.view.backgroundColor = UIColor.yellowColor()
        self.mapView = MKMapView(frame: self.view.frame )
        mapView.delegate = self
        
        let delta = 0.2
        var region = MKCoordinateRegion()
        region.center.latitude = 39.56
        region.center.longitude = -75.71
        region.span.latitudeDelta = delta
        region.span.longitudeDelta = delta
        
        mapView.setRegion( region, animated: true )
        view.addSubview(mapView)
        createPolygon()
    }

func createPolygon(){
    let locations = [
        CLLocation(latitude: 39.54, longitude: -75.75),
        CLLocation(latitude: 39.58, longitude: -75.75),
        CLLocation(latitude: 39.58, longitude: -75.68),
        CLLocation(latitude: 39.54, longitude: -75.68)
        ]
        return addPolygonToMap(locations)
}

func addPolygonToMap(locations:[CLLocation!]) {
    var coordinates = locations.map { (location: CLLocation!) -> CLLocationCoordinate2D in
        return location.coordinate
    }
    let polygon = MKPolygon(coordinates: &coordinates, count: locations.count)
    mapView.addOverlay(polygon)
}

func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = UIColor.redColor()
        polygonView.lineWidth = 3.0
        return polygonView
    }
    return MKOverlayRenderer(overlay: overlay)
    }
}
var ctrl = ViewController()

// ctrl.viewDidLoad() //Not needed
//XCPShowView("Playground VC", ctrl.view)

XCPlaygroundPage.currentPage.liveView = ctrl.view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

