//
//  EauDeFranceStruct.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

struct TemperatureODF: Decodable {
    let codeStation, libelleStation: String?
    let uriStation: String?
    let longitude, latitude: Double?
    let codeCommune, libelleCommune, codeCoursEau, libelleCoursEau: String?
    let uriCoursEau: String?
    //let codeParametre: String?
    let libelleParametre: String?
        let dateMesureTemp: String?
    let heureMesureTemp: String?
    let resultat: Double?
    let codeUnite: String?
    let symboleUnite: String?
    //let codeQualification: String?
    //let libelleQualification: String?
    init( codeStation: String?, libelleStation: String?, uriStation: String?, longitude: Double?, latitude: Double?, codeCommune: String?, libelleCommune: String?, codeCoursEau: String?, libelleCoursEau: String?, uriCoursEau: String?, codeParametre: String?, libelleParametre: String?, dateMesureTemp: String?, heureMesureTemp: String?, resultat: Double?, codeUnite: String?, symboleUnite: String?, codeQualification: String?, libelleQualification: String?) {

        self.codeStation = codeStation
        self.libelleStation = libelleStation
        self.uriStation = uriStation
        self.longitude = longitude
        self.latitude = latitude
        self.codeCommune = codeCommune
        self.libelleCommune = libelleCommune
        self.codeCoursEau = codeCoursEau
        self.libelleCoursEau = libelleCoursEau
        self.uriCoursEau = uriCoursEau
        self.libelleParametre = libelleParametre
        self.dateMesureTemp = dateMesureTemp
        self.heureMesureTemp = heureMesureTemp
        self.resultat = resultat
        self.codeUnite = codeUnite
        self.symboleUnite = symboleUnite
    }
}
