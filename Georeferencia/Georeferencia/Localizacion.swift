//
//  Localizacion.swift
//  Georeferencia
//
//  Created by 2020-1 on 11/13/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation
import MapKit

class Direccion: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var pin: UIImage?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, image: UIImage, pin: UIImage){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = image
        self.pin = pin
    }
    
    
}
