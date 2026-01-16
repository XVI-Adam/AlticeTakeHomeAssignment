import Foundation

struct APIConfig {
    let tmdbBaseURL: String
    let tmdbAPIKey: String
    
    static let shared: APIConfig = {
        do {
            return try APIConfig(
                tmdbBaseURL: "https://api.themoviedb.org/3",
                tmdbAPIKey: try loadAPIKey()
            )
        } catch {
            print("⚠️ APIConfig Error: \(error.localizedDescription)")
            return APIConfig(
                tmdbBaseURL: "https://api.themoviedb.org/3",
                tmdbAPIKey: ""
            )
        }
    }()
    
    private static func loadAPIKey() throws -> String {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            throw APIConfigError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
                throw APIConfigError.invalidSecretsFormat
            }
            
            guard let apiKey = plist["TMDB_API_KEY"] as? String, !apiKey.isEmpty else {
                throw APIConfigError.missingAPIKey
            }
            
            return apiKey
        } catch let error as APIConfigError {
            throw error
        } catch {
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }
    }
}
