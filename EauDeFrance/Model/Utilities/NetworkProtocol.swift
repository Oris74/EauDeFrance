//
//  APIProtocol.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 15/01/2021.
//

import Foundation

protocol NetworkProtocol {
    init( networkSession: URLSession)
    
    func getAPIData<T: Decodable>(
        _ endpointApi: URL?,
        _ parameters: [[KeyRequest:String]]?,
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void)
}
