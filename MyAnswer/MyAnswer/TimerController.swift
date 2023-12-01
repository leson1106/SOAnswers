//
//  TimerController.swift
//  MyAnswer
//
//  Created by Son Le on 01/12/2023.
//

import UIKit
import Combine

//https://stackoverflow.com/questions/77583391/timer-with-dispatchsourcetimer
class Timer: NSObject, ObservableObject {
    @Published var counterTime: Int = 0
    var timer: DispatchSourceTimer?

    func startTimer() {
        guard timer == nil else { return }
        let queue = DispatchQueue(label: "com.app.watchkitapp", qos: .userInteractive)
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: queue) // <--- Xcode point out the error at this line
        timer?.schedule(deadline: .now(), repeating: 1)
        timer?.setEventHandler {
            DispatchQueue.main.async {
                self.counterTime += 1
            }
        }
        timer?.resume()
    }

    func stopTimer() {
//        timer?.suspend()
        timer?.cancel()
        timer = nil
    }

    func resetTimer() {
        timer?.cancel()
        self.counterTime = 0
    }
}

class TimerController: UIViewController {
    let timer = Timer()

    var anyCancelable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.blue, for: .normal)
        view.addSubview(startButton)
        startButton.center = view.center

        let stopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.red, for: .normal)
        view.addSubview(stopButton)
        stopButton.center = view.center
        stopButton.frame.origin.y = view.center.y + 50

        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .orange
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.addSubview(label)
        label.center = view.center
        label.frame.origin.y = view.center.y - 50

        timer.$counterTime
            .sink { val in
                label.text = val.formatted()
            }
            .store(in: &anyCancelable)
    }

    @objc func start() {
        timer.startTimer()
    }

    @objc func stop() {
        timer.stopTimer()
    }
}
