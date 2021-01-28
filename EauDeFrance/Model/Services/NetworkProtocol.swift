//
//  APIProtocol.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 15/01/2021.
//

import Foundation

protocol NetworkProtocol {
    func getAPIData<T: Decodable>(
          _ endpointApi: URL?,
          _ parameters: [String:String?],
          _ apiStruct: T?.Type,
          completionHandler : @escaping (T?, Utilities.ManageError?) -> Void)
}
