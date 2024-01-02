//
//  indButtonView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-24.
//

import SwiftUI

struct indMuscleGroupView: View {
    @ObservedObject var indMG: MuscleGroup
    var images: [String] = ["SquatDrawing", "DeadLiftDrawing", "BenchPressDrawing"]
    let randomImage = Int.random(in: 0...2)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("Custom1"))
            .frame(width: 350, height: 75, alignment: .center)
            .overlay {
                HStack{
                    VStack(spacing: 4){
                        Text("\(indMG.name)")
                            .frame(maxWidth: 200, alignment: .leading)
                            .bold()
                        Text("\(indMG.workouts.count) workouts")
                            .frame(maxWidth: 200, alignment: .leading)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(indMG.dateCreated ?? Date.now, style: .date)
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
    indMuscleGroupView(indMG: MuscleGroup.preview())
}
