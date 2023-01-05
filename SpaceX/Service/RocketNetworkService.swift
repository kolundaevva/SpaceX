//
//  RocketNetworkService.swift
//  SpaceX
//
//  Created by Владислав Колундаев on 23.12.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidState
}

protocol RocketNetworkService {
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void)
    func getLaunches(completion: @escaping (Result<[Launch], Error>) -> Void)
}

final class RocketNetworkServiceImpl: RocketNetworkService {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    private enum API {
        static let rockets = "https://api.spacexdata.com/v4/rockets"
        static let launches = "https://api.spacexdata.com/v4/launches"
    }

    init(
        urlSession: URLSession = .shared,
        jsonDecoder: JSONDecoder = .init(),
        jsonEncoder: JSONEncoder = .init()
    ) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        guard let url = URL(string: API.rockets) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { [jsonDecoder] data, response, error in
            switch (data, error) {
            case let (.some(data), nil):
                do {
                    let rockets = try jsonDecoder.decode([Rocket].self, from: data)
                    completion(.success(rockets))
                } catch {
                    completion(.failure(error))
                }
            case let (.none, .some(error)):
                completion(.failure(error))
            default:
                completion(.failure(NetworkError.invalidState))
            }
        }

        task.resume()
    }

    func getLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        guard let url = URL(string: API.launches) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { [jsonDecoder] data, response, error in
            switch (data, error) {
            case let (.some(data), nil):
                do {
                    let launches = try jsonDecoder.decode([Launch].self, from: data)
                    completion(.success(launches))
                } catch {
                    completion(.failure(error))
                }
            case let (.none, .some(error)):
                completion(.failure(error))
            default:
                completion(.failure(NetworkError.invalidState))
            }
        }

        task.resume()
    }
}
