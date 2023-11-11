//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

enum TaskType: String {
    case `async`
    case `sync`
    case mix
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = ViewModel()
        print(Thread.current)
        
        let syncTask = Task { //sync 1 by 1, threads in action seems like queue.async
            print("Thread input sync \(Thread.current)")
            try await viewModel.addStaff(type: .sync)
            try await viewModel.addStaff(type: .sync)
            try await viewModel.addStaff(type: .sync)
            
            print("DONE SYNC BLOCK")
        }
        
        let asynTask = Task { //async
            print("Thread input async \(Thread.current)")
            async let a = viewModel.addStaff(type: .async)
            async let b = viewModel.addStaff(type: .async)
            async let c = viewModel.addStaff(type: .async)
            
            //Without `await` none of these async let will be executed, it will be suspended at "Adding staff"
            let tasks = try await [a,b,c]
            for each in tasks {
                print("Iterating async tasks")
            }
            print("DONE ASYNC BLOCK")
        }
        
        let mixTask = Task { //mix
            print("Thread input mix \(Thread.current)")
            try await viewModel.addStaff(type: .mix)
            async let b = viewModel.addStaff(type: .mix)
            async let c = viewModel.addStaff(type: .mix)
            
            //Without `await` none of these async let will be executed, it will be suspended at "Adding staff"
            let actions = try await b
            
            print("DONE MIXED BLOCK")
        }
        
        print("Hello world!")
    }
}

struct Staff {
    var id: Int
    var name: String
}

class ViewModel {
    var coreStaffs: [Staff] = []
    var normalStaffs: [Staff] = []
    
    func addStaff(type: TaskType) async throws {
        let id = Int.random(in: 0...10_000)
        print("Adding staff \(type.rawValue) \(Date()) \(id)")
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        let isCoreStaff = await checkIfIsCoreStaff(id, type: type)
        if isCoreStaff {
            coreStaffs.append(Staff(id: id, name: "Staff \(id)"))
        } else {
            normalStaffs.append(Staff(id: id, name: "Staff \(id)"))
        }
        print("Adding staff done \(type.rawValue) \(Date()) \(id)")
        print("Adding Thread \(type.rawValue): \(Thread.current)")
        print("====================")
    }
    
    private func checkIfIsCoreStaff(_ id: Int, type: TaskType) async -> Bool {
        print("Checking staff \(type.rawValue) \(Date()) \(id)")
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        print("Checking done \(type.rawValue) \(Date()) \(id)")
        print("Checking Thread \(type.rawValue): \(Thread.current)")
        return Bool.random()
    }
}
