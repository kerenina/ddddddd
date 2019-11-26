//
//  model.swift
//  Georeferencia
//
//  Created by 2020-1 on 11/6/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

struct Informacion : Codable{
    var Titulo: String
    var Longitud: Double
    var Subtitulo: String
    var Latitud: Double
    var Foto: String
    var Icono: String
    
}
let path = Bundle.main.path(forResource: "data", ofType: "json")
let jsonData = NSData(contentsOfFile: path!)
let info = try! JSONDecoder().decode([Informacion].self, from: jsonData! as Data)




