//
//  Network.swift
//  APIMemeGenerator
//
//  Created by Josicleison on 01/10/22.
//

import Foundation

class NetWork {
    
    private struct API {
        
        static let url = "http://apimeme.com"
    }
    
    private func task(from url: URL,
                      _ escape: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url, completionHandler: escape).resume()
    }
    
    func requestMeme(top: String? = "Top",
                     bottom: String? = "Bottom",
                     meme: String? = "And-everybody-loses-their-minds",
                     _ escape: @escaping (Data) -> ()) {
        
        let url = URL(string: "\(API.url)/meme?meme=\(meme ?? "")&top=\(top ?? "")&bottom=\(bottom ?? "")")
        
        guard let url = url else {return}
        task(from: url) {data, response, error in
            
            DispatchQueue.main.async {
                
                if let error = error {print(error); return}
                if let response = response {print(response)}
                if let data = data {escape(data)}
            }
        }
    }
}
