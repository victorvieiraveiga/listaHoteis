//
//  MapaController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 17/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit
import MapKit

class MapaController: UIViewController, CLLocationManagerDelegate {

    var latitude : CLLocationDegrees?
    var longitude :  CLLocationDegrees?
    var gerenciadorLocalizacao = CLLocationManager()
    var nomeHotel : String?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        gerenciadorLocalizacao = CLLocationManager()
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.startUpdatingLocation()
        gerenciadorLocalizacao.startMonitoringSignificantLocationChanges()

        // Here you can check whether you have allowed the permission or not.
        if CLLocationManager.locationServicesEnabled()
            {
                switch(CLLocationManager.authorizationStatus())
                {
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Authorize.")
                    break
                case .notDetermined:
                    print("Not determined.")
                    break
                case .restricted:
                    print("Restricted.")
                    break
                case .denied:
                    print("Denied.")
                }
            }
        exibeHotelMapa()
    }
    

    func exibeHotelMapa () {
        
        
        let deltaLatitude : CLLocationDegrees = 0.03
        let deltaLongitude : CLLocationDegrees = 0.03
        
        let areaVisual : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        
        
        if latitude  != nil {
           
            if longitude != nil {
                let lat = latitude!
                let lon = longitude!
                let localizacao : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
                let regiao : MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisual )


        let annotation  = MKPointAnnotation()
        annotation.title = nomeHotel
        //annotation.subtitle = "Endereco"
        annotation.coordinate = localizacao
        
        self.mapView.addAnnotation(annotation)
        
        self.mapView.setRegion(regiao, animated: true)
                    }
                }
    }
    
    

}
