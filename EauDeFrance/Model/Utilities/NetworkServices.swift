//
//  NetworkServices.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation
/*
class NetworkService {
    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)
    enum Method: String {
        case get
        case post
    }
    ///build request for API
    private func createRequest(url: URL, method: Method = .get, queryItems: [URLQueryItem]) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }

    ///check URL response and manage errors
    private func checkURLResponse(_ data: Data?,
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
    private func decodeData<T: Decodable>(
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

    private func carryOutData<T: Decodable>(
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

    func request<T: Decodable>(_ url: URL, method: Method = .get, parameters: [String:String?], apiStruct: T?.Type, completion: @escaping ( T?, Utilities.ManageError?) -> Void) {

        let queryItems = parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }

        let request = createRequest(url: url, queryItems: queryItems)

        // prevent two identical tasks
        self.task?.cancel()

        self.task = self.session.dataTask(with: request) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.carryOutData(
                    apiStruct.self,
                    data, response, error,
                    completionHandler: {(apidata, errorCode) in
                        completion(apidata, errorCode)
                    })
            }
        }
        task?.resume()
    }
/*
 func request() {


 init(session: URLSession = URLSession(configuration: .default), service: String) {
 self.session = session

 super.init()
 }
 let parameters = [URLQueryItem(name: "code_departement", value: codeDept)]

 let request = createRequest(url: stationUrl, queryItems: parameters)        // prevent two identical tasks
 task?.cancel()
 self.station = []

 task = session.dataTask(with: request) {[weak self] (data, response, error) in
 DispatchQueue.main.async {
 self?.carryOutData(
 Station?.self,
 data, response, error,
 completionHandler: {(station, errorCode) in
 callback(errorCode, station)
 })
 }
 }
 task?.resume()
 }*/
}*/
