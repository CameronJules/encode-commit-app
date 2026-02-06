//
//  NetworkService.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

// MARK: - HTTP Method

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - Network Service

struct NetworkService {

    // MARK: - Generic Request

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        let (data, _) = try await performRequest(endpoint: endpoint, method: method, body: body, headers: headers)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }

    // MARK: - No Content Request (204)

    func requestNoContent(
        endpoint: String,
        method: HTTPMethod = .post,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) async throws {
        let (_, _) = try await performRequest(endpoint: endpoint, method: method, body: body, headers: headers)
    }

    // MARK: - Private

    private func performRequest(
        endpoint: String,
        method: HTTPMethod,
        body: (any Encodable)?,
        headers: [String: String]?
    ) async throws -> (Data, HTTPURLResponse) {
        let urlString = "\(APIConfig.baseURL)\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.networkError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw APIError.httpError(statusCode: httpResponse.statusCode, message: message)
        }

        return (data, httpResponse)
    }
}
