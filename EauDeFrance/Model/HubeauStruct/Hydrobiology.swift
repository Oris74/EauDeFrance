//
//  Hydrobiology.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

struct Hydrobiology {
    let codeStationHydrobio, libelleStationHydrobio: String?
    let uriStationHydrobio: NSNull?
    let coordonneeX, coordonneeY: Int?
    let codeProjection, codeCoursEau, libelleCoursEau: String?
    let uriCoursEau: NSNull?
    let codeMasseEau: String?
    let libelleMasseEau: String?
    let uriMasseEau: NSNull?
    let codeSousBassin, libelleSousBassin, codeBassin, libelleBassin: String?
    let codeCommune, libelleCommune, codeDepartement, libelleDepartement: String?
    let codeRegion, libelleRegion: String?
    let codesReseaux, libellesReseaux: [String]?
    let codesSupports: [String]?
    let libellesSupports: [LibellesSupport]?
    let codesAppelTaxons, libellesAppelTaxons: [String]?
    let codesIndices, libellesIndices: [String]?
    let latitude, longitude: Double?
    let geometry: Geometry?
    let datePremierPrelevement, dateDernierPrelevement: String?
}


enum LibellesSupport {
    case diatoméesBenthiques
    case macroinvertébrésAquatiques
    case poissons
}
