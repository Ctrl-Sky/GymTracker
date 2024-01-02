//
//  indButtonView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-24.
//

import SwiftUI

struct indWorkoutView: View {
    @ObservedObject var indW: Workout
    var images: [String] = ["SquatDrawing", "DeadLiftDrawing", "BenchPressDrawing"]
    let randomImage = Int.random(in: 0...2)
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("Custom1"))
            .frame(width: 350, height: 75, alignment: .center)
            .overlay {
                HStack{
                    VStack{
                        Text("\(indW.name)")
                            .frame(maxWidth: 200, alignment: .leading)
                            .bold()
                        Text("\(indW.sets.count) sets created")
                            .frame(maxWidth: 200, alignment: .leading)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Image(images[randomImage])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.trailing)
                    Image(systemName: "chevron.right")
                }
            }
    }
}

#Preview {
    indWorkoutView(indW: Workout.preview())
}
