//
//  testIndSetView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-26.
//

import SwiftUI

struct IndSetView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var indSet: Sets
    var numOfSets: Int
    @State private var showingAlert: Bool = false
    @State private var errorAlert: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .frame(width: 350, height: CGFloat(Int(numOfSets)*49) + 28, alignment: .center)
            .overlay {
                HStack{
                    VStack{
                        HStack{
                            Text("Set   Weight   Rep")
                                .offset(CGSize(width: -9, height: 0))
                        }
                        .bold()
                        ForEach(0..<Int(numOfSets), id: \.self){ i in
                            if i < indSet.weights.count && i < indSet.reps.count {
                                HStack{
                                    Text("\(i+1)")
                                        .padding(.trailing)
                                        .padding(.vertical, 1)
                                    TextField("...", text: Binding(
                                        get: { indSet.weights[i] },
                                        set: { newValue in
                                            indSet.weights[i] = newValue
                                        }
                                    ))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Custom2"), style: StrokeStyle(lineWidth: 1.0)))
                                    .onSubmit{
                                        do{ try moc.save() } catch{
                                            indSet.weights[i] = ""
                                            errorAlert.toggle()
                                        }
                                    }
                                    .frame(maxWidth: 50)
                                    .keyboardType(.numbersAndPunctuation)
                                    TextField("...", text: Binding(
                                        get: { indSet.reps[i] },
                                        set: { newValue in
                                            indSet.reps[i] = newValue
                                        }
                                    ))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Custom2"), style: StrokeStyle(lineWidth: 1.0)))
                                    .onSubmit{
                                        do{ try moc.save() } catch{
                                            indSet.reps[i] = ""
                                            errorAlert.toggle()
                                        }
                                    }
                                    .keyboardType(.numbersAndPunctuation)
                                    .frame(maxWidth: 50)
                                }
                            }
                        }
                    }
                    .frame(width: 165)
                    .padding(.leading)
                    Spacer()
                    VStack(){
                        HStack{
                            Image(systemName: indSet.addWeight ? "dumbbell.fill" : "dumbbell")
                                .onTapGesture {
                                    indSet.addWeight.toggle()
                                }
                                .foregroundStyle(indSet.addWeight ? .green : .red)
                                .scaleEffect(1.25)
                        }
                        .padding(.top)
                        VStack{
                            Text("Notes:")
                            TextField("...", text: $indSet.notes, axis: .vertical)
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Custom2"), style: StrokeStyle(lineWidth: 1.0)))
                                .lineLimit(2, reservesSpace: true)
                                .onSubmit{
                                    do{ try moc.save() } catch{
                                        indSet.notes = ""
                                        errorAlert.toggle()
                                    }
                                }
                        }
                        .padding(.top)
                    }
                    .padding(.trailing)
                    Spacer()
                }
            }
            .multilineTextAlignment(.center)
            .autocorrectionDisabled()
            .alert("Could not save data", isPresented: $errorAlert) {
                Button("Ok", role: .cancel){}
            } message: {
                Text("There was a problem saving your data but it is not your fault. If you restart the app, you can try again. Please contact me on my github (Ctrl-Sky) to notify me of this issue.")
            }
    }
}

#Preview {
    IndSetView(indSet: Sets.preview(), numOfSets: 3).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
