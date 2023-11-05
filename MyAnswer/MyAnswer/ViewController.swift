//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

//https://stackoverflow.com/questions/77426181/how-to-use-generics-with-json-encoder-in-swift
enum HTTPError: Error {
    case invalidUrl
    case failedResponse
}

enum AddPostModel{
    struct AddPostRequest: Codable {
        let title: String
        let body: String
        let userId: String
        let id: String
    }
    struct AddPostResponse: Codable {
        let title: String
        let body: String
        let userId: String
        let id: String
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addPost(params: AddPostModel.AddPostRequest) async -> Result<AddPostModel.AddPostResponse,Error> {
        return await sendPostRequest(url: "", responseType: AddPostModel.AddPostResponse.self, params: params)
    }
}

func sendPostRequest<T: Codable, U: Codable>(url: String,responseType: T.Type, params: U) async -> Result<T, Error> {
    do{
        let session = URLSession(configuration: .default)
        guard let url = URL(string: url) else{return .failure(HTTPError.invalidUrl) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let jsonData = try JSONEncoder().encode(params)
        request.httpBody = jsonData
        
        let (data,response) = try await session.data(for: request)
        guard let urlResponse = response as? HTTPURLResponse , (200...299).contains(urlResponse.statusCode)
        else{ return .failure(HTTPError.failedResponse)}
        
        
        let jsonResponse = try JSONDecoder().decode(responseType.self, from: data)
        return .success(jsonResponse)
        
    }
    catch{
        return .failure(error)
    }
}
