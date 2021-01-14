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
        case apiRestriction = "Requete API limitée à 5 par minute"
        case emptyText = "veuillez saisir un ou plusieurs ingredients séparés par une virgule"
        case decodableIssue = "Recette non récupérable"
        case httpResponseError = "Réponse incorrect du serveur"
        case incorrectDataStruct = "la structure n'est pas conforme aux données API"
        case keyboardError = "veuillez saisir des valeurs numériques"
        case noRecipeFound = "aucune recette n'a été trouvée"
        case noFavoriteFound = "aucun favoris n'est enregistré"
        case networkError = "Problème d'acces au site"
        case undefinedError = "erreur non definie"
    }

    ///getting API keys from the ApiKeys.plist file located in 'Supporting Files' folder
    static func getValueForAPIKey(named keyname: String) -> [String:String]? {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)

        let value = plist?.object(forKey: keyname) as? [String:String]
        return value
    }
}
