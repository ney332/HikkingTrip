//
//  Api.swift
//  telaApi
//
//  Created by Lorran Silva on 31/10/25.
//

import Foundation

class TrailService {
    private let baseURL = "https://api-trilhas-five.vercel.app" 

    func fetchTrails(completion: @escaping ([Trail]) -> Void) {
        guard let url = URL(string: "\(baseURL)/trails") else {
            print("URL inválida")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let trails = try JSONDecoder().decode([Trail].self, from: data)
                    DispatchQueue.main.async {
                        completion(trails)
                    }
                } catch {
                    print("Erro ao decodificar JSON:", error)
                }
            } else if let error = error {
                print("Erro na requisição:", error.localizedDescription)
            }
        }.resume()
    }
}
