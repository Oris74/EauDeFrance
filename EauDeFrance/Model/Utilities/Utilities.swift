//
//  Utilities.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

class Utilities {
    enum ManageError: String, Error {
        case apiKeyError = "Clef API non recupéré"
        case emptyText = "veuillez saisir code postal, une  ville, un code departement ou un departement "
        case decodableIssue = "Recette non récupérable"
        case httpResponseError = "Réponse incorrect du serveur"
        case urlError = "URL Api non conforme"
        case incorrectDataStruct = "la structure n'est pas conforme aux données API"
        case keyboardError = "veuillez saisir des valeurs numériques"
        case noStationFound = "aucune station n'a été trouvée"
        case networkError = "Problème d'acces au site"
        case undefinedError = "erreur non definie"
        case missingCoordinate = "coordonnee Manquante"
        case missingData = "Données indisponibles"
        case cameraIssue = "Capture de la photo impossible"
    }

    ///getting API keys from the ApiKeys.plist file located in 'Supporting Files' folder
    static func getValueForAPIKey(named keyname: String) -> [String:String]? {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)

        let value = plist?.object(forKey: keyname) as? [String:String]
        return value
    }
}
