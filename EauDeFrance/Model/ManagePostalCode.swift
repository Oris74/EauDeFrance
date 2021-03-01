//
//  PostalCode.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 27/02/2021.
//

import Foundation

class ManagePostalCode {
    static var shared = ManagePostalCode()
    
    var databaseFrance = [PostalCode]()

    private var postalCodeJSON: Data? {
        let bundle = Bundle(for: ManagePostalCode.self)
        let url = bundle.url(forResource: "PostalCode", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    func importPostalCode(completion: @escaping (Utilities.ManageError?) -> Void) {
        let networkService = NetworkService()
        networkService.decodeJSON(type: [PostalCode]?.self, data: self.postalCodeJSON, completionJSON: {[weak self] (dataDecoded, error) in
            guard let postalCode = dataDecoded else { return }
            self?.databaseFrance = postalCode
            completion(error)
        })
    }

    func getPostalCode(withInsee code: String) -> String? {
        for township in databaseFrance {
            if township.inseeCode == code {
                return township.postalCode
            }
        }
        return nil
    }
}
