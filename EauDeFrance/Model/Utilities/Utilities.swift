//
//  Utilities.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

// MARK: List of errors
class Utilities {
    enum ManageError: String, Error {
        case decodableIssue = "données non décodées"
        case incorrectDataStruct = "La structure n'est pas conforme aux données API"
        case undefinedError = "Erreur non definie"
        case missingCoordinate = "Coordonnee Manquante"
        case missingData = "Données indisponibles"
        case urlError = "Erreur d'URL"
        case cameraIssue = "La caméra n'est pas accessible"
        case incorrectRequete = "Requete Incorrect soumise au serveur"
        case unauthorizedRequete = "Requete soumise non authorisée"
        case notFound = "Aucun resulat retourné"
        case internalServerError = "Erreur interne du serveur"
        case forbiddenRequete = "Requete interdite"
        case httpResponseError = "Erreur HTTP"
        case memoryIssue = "Alerte memoire"
    }
}
