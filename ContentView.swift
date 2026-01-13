//
//  ContentView.swift
//  SquareGame
//
//  Created by COBSCCOMP242P-052 on 2026-01-10.
//
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("GAME MENU")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                
                Text("Difficulty Selection")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                
                VStack(spacing: 20) {
                    
                    DifficultyButton(title: "Easy", color: .green) {
                        print("Easy selected")
                    }
                    
                    DifficultyButton(title: "Medium", color: .orange) {
                        print("Medium selected")
                    }
                    
                    DifficultyButton(title: "Hard", color: .red) {
                        print("Hard selected")
                    }
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    ContentView()
    
}
struct DifficultyButton: View {
    
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(15)
        }
        .padding(.horizontal, 40)
    }
}
