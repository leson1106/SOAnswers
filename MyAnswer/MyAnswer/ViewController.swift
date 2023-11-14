//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genericFormdataCall()
    }
    
    func genericFormdataCall() {
        let urlStr = URL(string: "https://prg-name/dev/api/student/edit-profile")!
        let parameters: [String: Any] = [
            "dob": "2005-07-24",
            "name": "Student",
            "gender": "M",
            "school_location": "TestLocation",
            "school_name": "K V",
            "grade": "12th grade",
            "student_bio": "I am a student",
            "profile_pic": nil
        ] as! [String : Any]
        
        DispatchQueue.global().async {
//            APINetworkManagerMultipart.sharedInstance.serviceCallWithMultipartFormData(url: urlStr,
//                                                                                       headers: nil,
//                                                                                       parameters: parameters,
//                                                                                       response: String.self) { result in
//                print(result)
//            }
            
            APINetworkManagerMultipart.sharedInstance.serviceCallWithMultipartFormData(url: urlStr, headers: nil, parameters: parameters) { (result: Result<String, Error>) in
                switch result {
                case .success(let response):
                    // Handle the successful response
                    //                    self.formdataResponse = response
                    print("Response: \(response)")
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func sortVowels(_ s: String) -> String {
        var s = s.map { String($0) }
        var vowelsArray = [String]()
        let vowels: [String] = ["a", "e", "i", "o", "u"]
        for c in s where vowels.contains(c.lowercased()) {
            vowelsArray.append(c)
        }
        
        vowelsArray.sort()
        var currIndex = 0
        for i in 0..<s.count {
            if vowels.contains(s[i].lowercased()) {
                s[i] = vowelsArray[currIndex]
                currIndex += 1
            }
        }
        return s.joined()
    }
}

class APINetworkManagerMultipart: NSObject {
    static let sharedInstance = APINetworkManagerMultipart()
    
    fileprivate override init() {
        super.init()
    }
    func serviceCallWithMultipartFormData<T: Codable>(
        url: URL,
        headers: [String: String]?,
        parameters: [String: Any],
        response: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let token = "Bearer mytoken"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        for (key, value) in parameters {
            if let stringValue = value as? String {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(stringValue)\r\n".data(using: .utf8)!)
            }
            else if let data = value as? Data {
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"file\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data
        
        if let customHeaders = headers {
            for (key, value) in customHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
