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
    var endereco : String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configurando o gerenciador de localização
        gerenciadorLocalizacao = CLLocationManager()
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.startUpdatingLocation()
        gerenciadorLocalizacao.startMonitoringSignificantLocationChanges()

        // Aqui podemos checar se o usuario liberou permissão de localização.
        if CLLocationManager.locationServicesEnabled()
            {
                switch(CLLocationManager.authorizationStatus())
                {
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Autorizado.")
                    break
                case .notDetermined:
                    print("Não Determinado")
                    break
                case .restricted:
                    print("Restrito.")
                    break
                case .denied:
                    print("Negado.")
                }
            }
        exibeHotelMapa()
    }
    

    func exibeHotelMapa () {
        
        //Define area visual(zoom) da visualização do mapa
        let deltaLatitude : CLLocationDegrees = 0.03
        let deltaLongitude : CLLocationDegrees = 0.03
        let areaVisual : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        
        //Define Localizacao do Hotel no mapa
        if latitude  != nil {
            if longitude != nil {
                let lat = latitude!
                let lon = longitude!
                let localizacao : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
                let regiao : MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisual )
                
                //Preenche parametros para o Marcador(Pin) no mapa.
                let annotation  = MKPointAnnotation()
                annotation.title = nomeHotel
                annotation.subtitle = self.endereco
                annotation.coordinate = localizacao
                
                self.mapView.addAnnotation(annotation)
                
                self.mapView.setRegion(regiao, animated: true)
                    }
                }
    }
    
    

}
