import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    case missingAPIKey
    case invalidSecretsFormat
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "The file containing the API configuration was not found."
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from the API configuration file. Underlying error: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode the API configuration. Underlying error: \(error.localizedDescription)"
        case .missingAPIKey:
            return "TMDB_API_KEY not found in Secrets.plist"
        case .invalidSecretsFormat:
            return "Secrets.plist format is invalid"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "The URL session returned an invalid response. Underlying error: \(error.localizedDescription)"
        case .missingConfig:
            return "The network request was missing the required API configuration."
        }
    }
}
