//
//  WorkoutViewController.swift
//  MyAnswer
//
//  Created by Son Le on 28/11/2023.
//


//https://stackoverflow.com/questions/77562541/import-packages-depending-from-os-version

#if canImport(WorkoutKit)
import WorkoutKit
#else
import Foundation
#endif

extension ViewController {
    func doStuff() {
        #if canImport(WorkoutKit)
        var model = SingleGoalWorkout(activity: .basketball)
        #else
        var model = NSObject()
        #endif
    }
}
