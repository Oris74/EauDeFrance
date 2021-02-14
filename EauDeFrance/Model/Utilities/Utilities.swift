//
//  Utilities.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

class Utilities {
    enum ManageError: String, Error {
        case emptyText = "veuillez saisir code postal, une  ville, un code departement ou un departement "
        case decodableIssue = "Recette non récupérable"
        case incorrectDataStruct = "la structure n'est pas conforme aux données API"
        case keyboardError = "veuillez saisir des valeurs numériques"
        case undefinedError = "erreur non definie"
        case missingCoordinate = "coordonnee Manquante"
        case missingData = "Données indisponibles"
        case urlError = "erreur d'URL"
        case cameraIssue = "La caméra n'est pas accessible"
        case incorrectRequete = "requete Incorrect soumise au serveur"
        case unauthorizedRequete = "requete soumise non authorisée"
        case notFound = "aucun resulat retourné"
        case internalServerError = "Erreur interne du serveur"
        case forbiddenRequete = "Requete interdite"
        case httpResponseError = "erreur HTTP"
    }

    ///getting API keys from the ApiKeys.plist file located in 'Supporting Files' folder
    static func getValueForAPIKey(named keyname: String) -> [String:String]? {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)

        let value = plist?.object(forKey: keyname) as? [String:String]
        return value
    }
}
