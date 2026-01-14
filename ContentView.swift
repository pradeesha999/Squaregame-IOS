//
//  ContentView.swift
//  SquareGame
//
//  Created by COBSCCOMP242P-052 on 2026-01-10.
//
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    
                    Text("Game Prenzy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                    Text("Difficulty Selection")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    
                    VStack(spacing: 20) {
                        
                        NavigationLink(destination: GameView()) {
                            DifficultyButton(title: "Easy", color: .green)
                        }
                        
                        NavigationLink(destination: GameView()) {
                            DifficultyButton(title: "Medium", color: .orange)
                        }
                        
                        NavigationLink(destination: GameView()) {
                            DifficultyButton(title: "Hard", color: .red)
                        }
                    }
                    .padding(.top, 0)
                }
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
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(15)
            .padding(.horizontal, 40)
    }
}


struct GameView: View {
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("GAME SCREEN")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Game will start here")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
    }
}
