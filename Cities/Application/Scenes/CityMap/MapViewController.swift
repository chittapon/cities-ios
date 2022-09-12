//
//  MapViewController.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import MapKit

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var city: CityViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = city.name
        mapView.showAnnotations([city], animated: true)
    }
}
