//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

//Related to: https://stackoverflow.com/questions/76926122/how-to-handle-two-completion-handlers-in-one-function-swift
class ViewController: UIViewController {
    
    private let apiCaller = APICaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch { data in
            //TODO:
        }
    }
    
    func fetch(completionHandler: @escaping (([String: Any]) -> Void)) {
        apiCaller.fetchUser { data, error in
            let group = DispatchGroup()
            
            group.enter()
            self.apiCaller.fetchSlideOnSaleEditorChoiceNewArrivalData(baseData: data) { _, _ in
                //Do something like decoding data
                print("Fetched slide")
                group.leave()
            }
            
            group.enter()
            self.apiCaller.fetchProducts(baseData: data) { _, _ in
                //Do something like decoding data
                print("Fetched product")
                group.leave()
            }
            
            group.notify(queue: .main) {
                //Group data if needed then completion
                //completionHandler...
                print("Completed")
            }
        }
    }
}

struct OnSaleItem { }
struct SlideItem { }
struct NewArrivalItem { }
struct EditorChoiceItem { }

class APICaller {
    func fetchUser(completionHandler: @escaping ((_ data: [String: Any], _ error: Error?) -> Void)) {
        completionHandler([:], nil)
    }
    
    func fetchSlideOnSaleEditorChoiceNewArrivalData(baseData: [String: Any],
                                                    completionHandler: @escaping ((_ data: [String: Any], _ error: Error?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler([:], nil)
        }
    }
    
    func fetchProducts(baseData: [String: Any],
                       completionHandler: @escaping ((_ data: [String: Any], _ error: Error?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler([:], nil)
        }
    }
}
