//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = ViewModel()
        print(Thread.current)
        
//        let syncTask = Task { //sync 1 by 1, threads in action seems like queue.async
//            print(Thread.current)
//            try await viewModel.addStaff()
//            try await viewModel.addStaff()
//            try await viewModel.addStaff()
//        }
        
        let asynTask = Task { //async
            print(Thread.current)
            async let a = viewModel.addStaff()
            async let b = viewModel.addStaff()
            async let c = viewModel.addStaff()

            //Without `await` none of these async let will be executed, it will be suspended at "Adding staff"
            let actions = try await a
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
    
    func addStaff() async throws {
        let id = Int.random(in: 0...10_000)
        print("Adding staff \(Date()) \(id)")
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        let isCoreStaff = await checkIfIsCoreStaff(id)
        if isCoreStaff {
            coreStaffs.append(Staff(id: id, name: "Staff \(id)"))
        } else {
            normalStaffs.append(Staff(id: id, name: "Staff \(id)"))
        }
        print("Adding staff done \(Date()) \(id)")
        print(Thread.current)
        print("====================")
    }
    
    private func checkIfIsCoreStaff(_ id: Int) async -> Bool {
        print("Checking staff \(Date()) \(id)")
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        print("Checking done \(Date()) \(id)")
        print(Thread.current)
        return Bool.random()
    }
}

//let viewModel = ViewModel()
//let syncTask = Task { //sync 1 by 1
//    try await viewModel.addStaff()
//    try await viewModel.addStaff()
//    try await viewModel.addStaff()
//}
//
//let asynTask = Task { //async
//    async let a = viewModel.addStaff()
//    async let b = viewModel.addStaff()
//    async let c = viewModel.addStaff()
//
//    //Without `await` none of these async let will be executed, it will be suspended at "Adding staff"
//    let actions = try await a
//}
