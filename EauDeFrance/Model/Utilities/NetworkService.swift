
//
//  NetworkService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 15/01/2021.
//

import Foundation

// MARK: Manage Network connection 
class NetworkService: NetworkProtocol {

    enum Method: String {
        case get = "GET"
        case post = "POST"
    }

    static let shared = NetworkService()

    private var task: URLSessionDataTask?

    private var session: URLSession

    required init(networkSession: URLSession = URLSession(configuration: .default)) {
        self.session = networkSession
    }

    ///check URL response and manage errors
    private func checkURLResponse(response: URLResponse?,
                                  completionURLResponse: @escaping (Utilities.ManageError?) -> Void) {

        if let  response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200,206:
                completionURLResponse(nil)
            case 400:
                completionURLResponse(.incorrectRequete)
            case 401:
                completionURLResponse(.unauthorizedRequete)
            case 403:
                completionURLResponse(.forbiddenRequete)
            case 404:
                completionURLResponse(.notFound)
            case 500:
                completionURLResponse(.internalServerError)
            default:
                completionURLResponse(.undefinedError)
            }
            return
        }
    }

    ///generic data decodable function  with error management
    func decodeJSON<T: Decodable>(
        type: T?.Type,
        data: Data?,
        completionJSON: @escaping (T?, Utilities.ManageError?) -> Void) {
        #if DEBUG && ERROR
        if let data = data {
            do {
                let decodedData =  try JSONDecoder().decode(type.self, from: data)
                return completionJSON(decodedData, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("\nKey '\(key)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("\nValue '\(value)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("\nType '\(type)' mismatch:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch {
                print("\nerror: ", error)
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

    ///generic data importation management
    private func manageResponse<T: Decodable>(
        _ type: T?.Type,
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        completionResponse: @escaping (T?, Utilities.ManageError?) -> Void) {
        checkURLResponse(response: response, completionURLResponse: {[weak self] errorCode in

            if errorCode == nil {
                self?.decodeJSON(type: type.self,
                                 data: data,
                                 completionJSON: {(result, errorCode) in
                                    completionResponse(result, errorCode)
                                 })
            } else {
                #if DEBUG && ERROR
                print("URL Response-> error: \(String(describing: errorCode))")
                #endif
                completionResponse(nil, errorCode)
            }
        })
    }

    func getAPIData<T: Decodable>(
        _ endpointApi: URL?,
        _ parameters: [[KeyRequest:String]]?,
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void) {

        guard let depackedEndpointApi = endpointApi else {
            return completionHandler(nil, Utilities.ManageError.urlError)
        }

        if let parameters = parameters {
            let queryItems = parameters.flatMap {$0.map {
                URLQueryItem(name: ($0.0).rawValue, value: $0.1)}
            }

            let request = createRequest(url: depackedEndpointApi, queryItems: queryItems)

            // prevent two identical tasks
            task?.cancel()
            task = session.dataTask(with: request, completionHandler: {[weak self] (data, response, error) in
                do {
                    if let error = error {
                        throw error
                    }
                    #if DEBUG && ERROR
                    print("\(request)")
                    print("data task-> data:\(String(describing: data)) \n response \(String(describing: response)) \n error: \(String(describing: error))")
                    #endif
                    guard let responseData = data else {  throw Utilities.ManageError.httpResponseError  }

                    DispatchQueue.main.async {
                        self?.manageResponse(
                            apiStruct,
                            responseData, response, error,
                            completionResponse: {(apidata, errorCode) in
                                completionHandler(apidata, errorCode)
                            })
                    }
                }catch let blockError {
                    if blockError.localizedDescription == "cancelled" {
                        return
                    }
                    #if DEBUG && ERROR
                    print("erreur Out: \(blockError)")
                    #endif
                    completionHandler(nil, Utilities.ManageError.httpResponseError)
                }
            })
            task?.resume()
        }
    }
}
