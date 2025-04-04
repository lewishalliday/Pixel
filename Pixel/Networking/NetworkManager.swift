//
//  NetworkManager.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Foundation

protocol NetworkAbstraction {
    var baseUrl: String { get  }
    func fetchData<T: Decodable>(endpoint: String, queryItems: [String: String]) async throws -> T
}

struct NetworkManager: NetworkAbstraction {
    var baseUrl: String = "https://api.stackexchange.com/2.2/"

    func fetchData<T: Decodable>(endpoint: String, queryItems: [String: String] = [:]) async throws -> T {
        guard var urlComponents = URLComponents(string: baseUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}
