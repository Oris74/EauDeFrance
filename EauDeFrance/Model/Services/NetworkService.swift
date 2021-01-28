
//
//  APIService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 15/01/2021.
//

import Foundation

class NetworkService: NetworkProtocol {
    static let shared = NetworkService()

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    enum Method: String {
        case get = "GET"
        case post = "POST"
    }

    ///check URL response and manage errors
    private func checkURLResponse(_ data: Data?,
                                  _ response: URLResponse?,
                                  _ error: Error?,
                                  completionURLResponse: @escaping (Utilities.ManageError?) -> Void) {

        guard data != nil, error == nil else {
            completionURLResponse(.networkError)
            return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completionURLResponse(.httpResponseError)
            return
        }
        completionURLResponse(nil)
        return
    }

    ///generic data importation management

    private func manageResponse<T: Decodable>(
        _ type: T?.Type,
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        completionResponse: @escaping (T?, Utilities.ManageError?) -> Void) {
        checkURLResponse(data, response, error, completionURLResponse: {[weak self] errorCode in

            if errorCode == nil {
                self?.decodeJSON(type: type.self,
                                 data: data,
                                 completionJSON: {(type, errorCode) in
                                    completionResponse(type, errorCode)
                                 })
            } else {
                #if DEBUG
                print("URL Response-> error: \(String(describing: errorCode))")
                #endif
                completionResponse(nil, errorCode)
            }
        })
    }

    ///generic data decodable function  with error management
    private func decodeJSON<T: Decodable>(
        type: T?.Type,
        data: Data?,
        completionJSON: @escaping (T?, Utilities.ManageError?) -> Void) {
        #if DEBUG
        if let data = data {
            do {
                let decodedData =  try JSONDecoder().decode(type.self, from: data)
                return completionJSON(decodedData, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        #else
        if let data = data {
            do {
                let decodedData =  try JSONDecoder().decode(type.self, from: data)
                return completionJSON(decodedData, nil)
            } catch {
                return completionJSON(nil, Utilities.ManageError.decodableIssue)
            }
        }
        #endif
        return completionJSON(nil, Utilities.ManageError.incorrectDataStruct)
    }
    ///build request for API
    private func createRequest(url: URL, method: Method = .get, queryItems: [URLQueryItem]) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }

    func getAPIData<T: Decodable>(
        _ endpointApi: URL?,
        _ parameters: [String:String?],
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void) {

        guard let depackedEndpointApi = endpointApi else {
            return completionHandler(nil, Utilities.ManageError.urlError)
        }
        
        let queryItems = parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }

        let request = createRequest(url: depackedEndpointApi, queryItems: queryItems)

        // prevent two identical tasks
        task?.cancel()

        task = session.dataTask(with: request, completionHandler: {[weak self] (data, response, error) in
            do {
                if let error = error {
                    throw error
                }
                guard let responseData = data else {
                    throw Utilities.ManageError.httpResponseError
                }

                #if debug
                print("data task-> data:\(responseData), response \(String(describing: response)), error: \(String(describing: error))")
                #endif
                DispatchQueue.main.async {
                    self?.manageResponse(
                        apiStruct.self,
                        responseData, response, error,
                        completionResponse: {(apidata, errorCode) in
                            completionHandler(apidata, errorCode)
                        })
                }
            }catch let blockError {
                completionHandler(nil, Utilities.ManageError.httpResponseError)
                #if DEBUG
                print("\n errorout:\(blockError)")
                #endif
            }
        })
        task?.resume()
    }
}
