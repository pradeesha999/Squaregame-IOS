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
                Color.blue.ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("Game Prenzy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Difficulty Selection")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(spacing: 20) {
                        NavigationLink {
                            GameView(gridSize: 3)
                        } label: {
                            DifficultyButton(title: "Easy", color: .green)
                        }

                        NavigationLink {
                            GameView(gridSize: 5)
                        } label: {
                            DifficultyButton(title: "Medium", color: .orange)
                        }

                        NavigationLink {
                            GameView(gridSize: 7)
                        } label: {
                            DifficultyButton(title: "Hard", color: .red)
                        }
                    }
                }
            }
        }
    }
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
            .cornerRadius(14)
            .padding(.horizontal, 40)
    }
}

struct GameView: View {

    let gridSize: Int

    @State private var tiles: [Tile] = []
    @State private var selectedIndices: [Int] = []
    @State private var isLocked = false

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: gridSize)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(tiles.indices, id: \.self) { index in
                    TileView(tile: tiles[index])
                        .onTapGesture {
                            tileTapped(at: index)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Memory Game")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupTiles()
        }
    }

    private func setupTiles() {
        let total = gridSize * gridSize
        let pairCount = total / 2

        var colors: [Color] = []
        let availableColors: [Color] = [
            .red, .blue, .green, .orange,
            .purple, .pink, .yellow, .cyan,
            .mint, .indigo
        ]

        for i in 0..<pairCount {
            let color = availableColors[i % availableColors.count]
            colors.append(color)
            colors.append(color)
        }

        if total % 2 == 1 {
            colors.append(.gray)
        }

        colors.shuffle()

        tiles = colors.map { color in
            Tile(
                color: color,
                isFaceUp: color == .gray,
                isMatched: color == .gray
            )
        }
    }

    private func tileTapped(at index: Int) {
        guard !isLocked else { return }
        guard !tiles[index].isFaceUp else { return }
        guard !tiles[index].isMatched else { return }

        tiles[index].isFaceUp = true
        selectedIndices.append(index)

        if selectedIndices.count == 2 {
            checkMatch()
        }
    }

    private func checkMatch() {
        let first = selectedIndices[0]
        let second = selectedIndices[1]

        isLocked = true

        if tiles[first].color == tiles[second].color {
            tiles[first].isMatched = true
            tiles[second].isMatched = true
            resetSelection()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                tiles[first].isFaceUp = false
                tiles[second].isFaceUp = false
                resetSelection()
            }
        }
    }

    private func resetSelection() {
        selectedIndices.removeAll()
        isLocked = false
    }
}

struct Tile {

    let color: Color
    var isFaceUp: Bool
    var isMatched: Bool
}

struct TileView: View {

    let tile: Tile

    var body: some View {
        Rectangle()
            .fill(tile.isFaceUp || tile.isMatched ? tile.color : .gray)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(8)
            .animation(.easeInOut, value: tile.isFaceUp)
    }
}

#Preview {
    ContentView()
}
