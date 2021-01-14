//
//  NetworkServices.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

class NetworkServices {
    ///build request for API
    func createRequest(url: URL, methode: String = "GET", queryItems: [URLQueryItem]) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = methode
        return request
    }

    ///check URL response and manage errors
    func checkURLResponse(_ data: Data?,
                          _ response: URLResponse?,
                          _ error: Error?,
                          completionHandler: @escaping (Utilities.ManageError?) -> Void) {

        guard data != nil, error == nil else {
            completionHandler(.networkError)
            return
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completionHandler(.httpResponseError)
            return
        }
        completionHandler(nil)
        return
    }

    ///generic data decodable function  with error management
    func decodeData<T: Decodable>(
        type: T?.Type,
        data: Data?,
        completionHandler: @escaping (T?, Utilities.ManageError?) -> Void) {

        guard let decodedData = try? JSONDecoder().decode(type.self, from: data!)
            else {
                completionHandler(nil, .incorrectDataStruct)
                return
        }
        return completionHandler(decodedData, nil)
    }

    ///generic data importation management
    func carryOutData<T: Decodable>(
        _ type: T?.Type,
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        completionHandler: @escaping (T?, Utilities.ManageError?) -> Void) {
        checkURLResponse(data, response, error, completionHandler: {[weak self] errorCode in
            if errorCode == nil {
                self?.decodeData(type: type.self,
                                 data: data,
                                 completionHandler: {(type, errorCode) in
                                    completionHandler(type, errorCode)
                })
            } else {
                completionHandler(nil, errorCode)
            }
        })
    }
}
