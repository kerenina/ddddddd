//
//  ViewController.swift
//  Georeferencia
//
//  Created by 2020-1 on 10/16/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var contador : Int = 0
class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return datos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datos[component].count
    }
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var distancia: UILabel!
    @IBOutlet weak var eleccion: UIPickerView!
    @IBOutlet weak var mensaje: UILabel!
    /*  @IBAction func agregarAnotacion(_ sender: Any) {
        let anotacion = CoffeeAnotation()
        anotacion.coordinate = CLLocationCoordinate2D(latitude: 19.3275, longitude: -99.1823)
        
        anotacion.title = "iOS Dev Lab"
        anotacion.subtitle = "A nice place to work"
        anotacion.imageURL = "coffee-pin.png"
        mapa.addAnnotation(anotacion)
    }*/
    //Economia, inge, arqui, muca, estadio, trabajo social, conta, anexo, veterinaria, ciencias, metro, zona cultural, universum
    var datos = [
    ["Psicología","Filosofía","Derecho","Economía","Odontología","Medicina","Química","Ingenierìa","Arquitectura","MUCA","Rectoría","Estadio","Trabajo Social","Contaduría","Anexo","Veterinaría", "Ciencias","Politicas","Metro CU", "Zona Cultural","UNIVERSUM","Alberca"],
                  ["Veterinaría","Ingenierìa","Filosofía","Psicología","Derecho","Economía","Odontología","Medicina","Química","Arquitectura","MUCA","Rectoría","Estadio","Trabajo Social","Contaduría","Anexo", "Ciencias","Politicas","Metro CU", "Zona Cultural","UNIVERSUM","Alberca"]
        
    ]
    var inicio: String = " "
    var destino: String = " "
    var LocationManager : CLLocationManager = CLLocationManager()
    var comienzo = [String]()
    var comienzo1 = [Double]()
    var termino = [String]()
    var termino1 = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eleccion.dataSource = self
        eleccion.delegate = self
        inicio = datos [0][0]
        destino = datos [1][0]
        view.backgroundColor = .clear
        LocationManager.delegate = self
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.distanceFilter = kCLDistanceFilterNone
        LocationManager.startUpdatingLocation()
        mapa.delegate = self
        mapa.showsUserLocation = true
        
        /*
         Hacer una comparación con un if entre el valor obtenido en el UIPicker y el arreglo de info
         Dependiendo de en que posicion se encuentre se mandara guardar en una variable a la que se le asignarán los valores
         */
        for contador  in 0..<info.count {
            if inicio == info[contador].Titulo{
                comienzo.append(info[contador].Titulo)
                comienzo.append(info[contador].Subtitulo)
                comienzo.append(info[contador].Foto)
                comienzo.append(info[contador].Icono)
                comienzo1.append(info[contador].Latitud)
                comienzo1.append(info[contador].Longitud)
                
            }
        }
        
        // print(info)
        
        for contador  in 0..<info.count {
            if destino == info[contador ].Titulo{
                termino.append(info[contador ].Titulo)
                termino.append(info[contador ].Subtitulo)
                termino.append(info[contador ].Foto)
                termino.append(info[contador ].Icono)
                termino1.append(info[contador ].Latitud)
                termino1.append(info[contador ].Longitud)
            }
        }
        let inicioLocation = CLLocationCoordinate2D(latitude: comienzo1[0] , longitude: comienzo1[1] )
        let destinoLocation = CLLocationCoordinate2D(latitude: termino1[0] , longitude: termino1[1] )
        
       // kk  print(comienzo)
        // kk print(termino)
        
       //k print(termino[2]) //veterinaria
       //k print(termino[3]) //icono-veterinaria
        var fotoInicio = UIImage(named: comienzo[2])
        var pinInicio = UIImage(named: comienzo[3])
        var fotoDestino = UIImage(named: termino[2])
        var pinDestino = UIImage(named: termino[3])
        // var currentPlacemark: CLPlacemark
        
        print(inicioLocation) //CLLocationCoordinate2D(latitude: 19.33571, longitude: -99.18846)
        print(destinoLocation) //CLLocationCoordinate2D(latitude: 19.3298, longitude: -99.17696)
        
        let inicioPin = Direccion(title: comienzo[0], subtitle: comienzo[1],coordinate: inicioLocation, image: fotoInicio!, pin: pinInicio! )
        let destinoPin = Direccion(title: termino[0], subtitle: termino[1], coordinate: destinoLocation, image: fotoDestino!, pin: pinDestino! )
        mapa.addAnnotations([inicioPin,destinoPin])
        
        let inicioPlaceMark = MKPlacemark(coordinate: inicioLocation)
        let destinoPlaceMark = MKPlacemark(coordinate: destinoLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: inicioPlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinoPlaceMark)
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let directionResponse = response else{
                return
            }
            let ruta = directionResponse.routes.first
            self.mapa.addOverlay(ruta!.polyline)
            let rect = ruta?.polyline.boundingMapRect
            self.mapa.setRegion(MKCoordinateRegion(rect!), animated: true)
            
        }
        
        
        let inicio = CLLocation(latitude: comienzo1[0], longitude: comienzo1[1])
        let destino = CLLocation(latitude: termino1[0], longitude: termino1[1])
        
        let distancia = inicio.distance(from: destino)
        //print(distancia)
        
       let distancia1 = String(format:"Distancia: %0.2f metros", distancia)
        mensaje.text = "\(distancia1)"
        //  let distanciaFormateada = String(format:"Distancia: %0.2f metros", distancia)
        // mensaje.text = "Distancia: \(distancia) metros"
        //print("\(distanciaFormateada)")
        
        
        
        
        

        
    } // fin de  override func viewDidLoad()
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datos [component][row]
    }
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            
            inicio = datos[0 ][row]
        }else{
            destino = datos[1][row]
        }
        
        print("Inicio: \(inicio)")
        print("Destino: \(destino)")
        
    }
    
    
    
    
    
    
    
    
    func mapView(_ mapaView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        let linea = MKPolylineRenderer(overlay: overlay)
        linea.strokeColor = .green
        linea.lineWidth = 6.5
        return linea
        /*if annotation is MKUserLocation{
         return nil
        }
         
        var coffeeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CoffeeAnotationView")
         
        if coffeeAnnotationView == nil{
            coffeeAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeAnotationView")
            coffeeAnnotationView?.canShowCallout = true
        } else {
            coffeeAnnotationView?.annotation = annotation
        }
         
         if let coffeeAnnotation = annotation as? CoffeeAnotation{
         coffeeAnnotationView?.image = UIImage(named: coffeeAnnotation.imageURL)
         }
         
         return coffeeAnnotationView*/
        
        
    } 


    

}
