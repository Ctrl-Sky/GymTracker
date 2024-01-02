import UIKit

struct Sets{
    var reps: [Int]
    var weights: [Int]
    var repsAndWeights: [String]
}
let string1: String = "45:8"
let string2: String = "25-10-5:8"
let string3: String = "\""
let string4: String = "X"

func weightRepToInt(set: Sets) {
    var weight: Int
    var rep: Int
    
    for i in 0...(set.repsAndWeights.count - 1){
        if set.repsAndWeights[i].contains(":"){
            let weightRep = set.repsAndWeights[i].split(separator: ":")
            let weights = weightRep[0].split(separator: "-")
            for j in weights{
                weight = weight + (Int(j) ?? 0)
            }
            rep = Int(weightRep[1]) ?? 0
        }
        set.weights.append(weight)
        set.reps.append(rep)
        weight = 0
        rep = 0
    }
}




