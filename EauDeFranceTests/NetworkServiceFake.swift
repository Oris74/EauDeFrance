//
//  APIServiceFake.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 13/03/2021.
//

import Foundation
@testable import EauDeFrance

class NetworkServiceFake: NetworkService {

    private var json =  Data()

    init(json: Data ) {
        self.json = json
    }
    
    required init(networkSession: URLSession = URLSession(configuration: .default)) {
        fatalError("init(networkSession:) has not been implemented")
    }
    
    override func getAPIData<T: Decodable>(
        _ endpointApi: URL?,
        _ parameters: [[KeyRequest:String]]?,
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void) {

        decodeJSON(type: apiStruct.self,
                   data: json,
                   completionJSON: {(result, errorCode) in
                    completionHandler(result, errorCode)
                   })
    }
}
