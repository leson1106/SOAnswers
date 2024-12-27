//
//  ContentView.swift
//  MyAnswer
//
//  Created by Sonny on 27/12/24.
//

import SwiftUI

//https://stackoverflow.com/questions/79311114/how-to-destroy-timer-when-navigate-to-other-screen
struct Snowflake: Identifiable {
    var id = UUID()
    var x: Double
    var y: Double
    var scale: Double
    var speed: Double
}

struct SnowFallAnimationView: View{
    @State private var snowflakes: [Snowflake] = []
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    .black,
                    .black
                ]), startPoint: .top, endPoint: UnitPoint.bottom
            )
            //.ignore safe area
            
            if #available(iOS 15.0, *) {
                Canvas { context, size in
                    
                    for snowflake in snowflakes {
                        context.draw(Text("❄️").font(.system(size: 10 * snowflake.scale)), at: CGPoint(x: snowflake.x * size.width, y: snowflake.y * size.height))
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .onAppear {
            startSnowFall()
        }
        .onDisappear {
            stopSnowFall()
        }
    }
    
    func stopSnowFall() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
        snowflakes.removeAll()
    }
    
    func startSnowFall() {
        guard timer == nil else { return }
        
        for _ in 0..<50 {
            snowflakes.append(
                Snowflake(
                    x: Double.random(in: 0...1),
                    y: Double.random(in: -0.2...0),
                    scale: Double.random(in: 0.5...1.5),
                    speed: Double.random(in: 0.001...0.003)
                )
            )
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true, block:     {
            _ in
            for i in snowflakes.indices {
                snowflakes[i].y += snowflakes[i].speed
                if snowflakes[i].y >= 1.2 {
                    snowflakes[i].y = -0.2
                    snowflakes[i].x = Double.random(in: 0...1)
                }
            }
        })
    }
}

#Preview {
    SnowFallAnimationView()
}
