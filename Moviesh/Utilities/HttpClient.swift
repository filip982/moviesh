import Foundation

enum HttpMethods: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

class HttpClient {
    
    let session: URLSession
    let baseURL: String
    let apiKey: String?
    
    init(
        session: URLSession,
        baseURL: String,
        apiKey: String? = nil
    ) {
        self.session = session
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func get<T: Decodable>(path: String, params: [String: String]? = nil) async throws -> T {
        // Building URL
        guard let baseURL = URL(string: self.baseURL) else { throw HttpError.badURL }
        guard let url = URL(string: path, relativeTo: baseURL) else { throw HttpError.badURL }
                
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw HttpError.badURL
        }
        
        var queryItems = [URLQueryItem]()
        
        if let apiKey = apiKey {
            queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        }
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        guard let finalURL = urlComponents.url else { throw HttpError.badURL }
        // Use the HTTP caching capabilities that are built into the protocol
        let request = URLRequest(url: finalURL, cachePolicy: .useProtocolCachePolicy)
        
        // Fetching data, checking, decoding
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 
                200..<300 ~= httpResponse.statusCode else {
            throw HttpError.badResponse
        }
        do {
            let object = try Utils.jsonDecoder.decode(T.self, from: data)
            return object
        } catch {
            print("🔴 Decoding error: \(error)")
            throw HttpError.errorDecodingData
        }
    }

    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String ) async throws {
        var request = URLRequest(url: url)

        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)

        request.httpBody = try? JSONEncoder().encode(object)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
