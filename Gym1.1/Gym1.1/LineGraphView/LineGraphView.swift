//
//  LineGraphView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-29.
//

import SwiftUI
import Charts

struct LineGraphView: View {
    @Environment(\.managedObjectContext) private var moc
    private var fetchRequest : FetchRequest<Sets>
    private var sets : FetchedResults<Sets> {
        fetchRequest.wrappedValue
    }
    private var name: String
    private var setView: Bool
    
    init(workout: Workout, setView: Bool = false) {
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Sets.dateOfCreation, ascending: false)], predicate: NSPredicate(format: "relationship == %@", workout), animation: .default)
        self.name = workout.name
        self.setView = setView
    }
    

    var body: some View {
        let datas = stringArrToDoubleArr()
        let max = datas.max() ?? 0
        let min = datas.min() ?? 0
        let diff = max - min == 0 ? 5 : max - min
        let minimum = diff >= 0 ? min-diff : 0
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("Custom1"))
            .frame(width: 350, height: 420, alignment: .center)
            .overlay {
                VStack{
                    Spacer()
                    Text("\(name)")
                        .font(.subheadline)
                    Spacer()
                    Chart{
                        ForEach(0..<datas.count, id: \.self){ i in
                            LineMark(x: .value("Set", i), y: .value("Weight", datas[i]))
                        }
                        .symbol(Circle())
                    }
                    .chartXScale (domain: 0...datas.count)
                    .chartYScale(domain: minimum...max+diff)
                    .chartXAxisLabel("Sets", alignment: .center, spacing: 20)
                    .chartYAxisLabel("Weights")
                    .chartYAxis {
                        AxisMarks(position: .leading, values: .automatic(desiredCount: 8))
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 10))
                    }
                    .aspectRatio(1, contentMode: . fit)
                    .padding()
                    .foregroundStyle(setView ? Color("Custom6") : Color("Custom4"))
                    Spacer()
                }
            }
    }
    
    func stringArrToDoubleArr() -> [Double]{
        var doubleWeight: [Double] = []
        for set in sets{
            for weight in set.weights.reversed(){
                doubleWeight.append(Double(weight) ?? 0)
            }
        }
        return doubleWeight.reversed()
    }
}


#Preview {
    LineGraphView(workout: Workout.preview()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
}
