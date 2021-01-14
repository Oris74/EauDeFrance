//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation

struct Station: Decodable {
    let codeStation, libelleStation: String?
    let uriStation: String?
    let localisation: String?
    let coordonneeX, coordonneeY: Int?
    //let codeTypeProjection: Int?
    let longitude, latitude: Double?
    let codeCommune, libelleCommune, codeDepartement, libelleDepartement: String?
    let codeRegion, libelleRegion, codeTronconHydro, codeCoursEau: String?
    let libelleCoursEau: String?
    let uriCoursEau: String?
    let codeMasseEau: String?
    let libelleMasseEau: String?
    let uriMasseEau: String?
   // let codeSousBassin, libelleSousBassin, codeBassin, libelleBassin: String?
    //let uriBassin: String?
    let pointKm: String?
    let altitude: Int?
    let dateMajInfos: String?
    //let geometry: Geometry?

    init(codeStation:String?, libelleStation: String?, uriStation: String?, localisation: String?, coordonneeX: Int?, coordonneeY: Int?, longitude: Double?, latitude: Double?, codeCommune: String?, libelleCommune: String?, codeDepartement: String?, libelleDepartement: String?, codeRegion: String?, libelleRegion: String?, codeTronconHydro: String?, codeCoursEau: String?, libelleCoursEau: String?, uriCoursEau: String?, codeMasseEau: String?, libelleMasseEau: String?, uriMasseEau: String?, pointKm: String?, altitude: Int?,    dateMajInfos: String?) {
        self.codeStation = codeStation
        self.libelleStation = libelleStation
        self.uriStation = uriStation
        self.localisation = localisation
        self.coordonneeX = coordonneeX
        self.coordonneeY = coordonneeY
        self.longitude = longitude
        self.latitude = latitude
        self.codeCommune = codeCommune
        self.libelleCommune = libelleCommune
        self.codeDepartement = codeDepartement
        self.libelleDepartement = libelleDepartement
        self.codeRegion = codeRegion
        self.libelleRegion = libelleRegion
        self.codeTronconHydro = codeTronconHydro
        self.codeCoursEau = codeCoursEau
        self.libelleCoursEau = libelleCoursEau
        self.uriCoursEau = uriCoursEau
        self.codeMasseEau = codeMasseEau
        self.libelleMasseEau = libelleMasseEau
        self.uriMasseEau = uriMasseEau
        self.pointKm = pointKm
        self.altitude = altitude
        self.dateMajInfos = dateMajInfos
    }
}
