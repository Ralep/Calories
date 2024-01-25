//
//  ContentView.swift
//  Calories
//
//  Created by Harald Kurz on 25.01.24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var entryList: EntryList = EntryList()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if entryList.totalCalories > 0 {
                    HStack {
                        Text("Total Calories: ")
                        Text(String(entryList.totalCalories))
                    }
                }
                
                List {
                    ForEach(entryList.entries) { entry in
                        HStack {
                            Text(entry.calories)
                            Text(entry.food)
                            
                            Spacer()
                            
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    entryList.deleteEntry(entry: entry)
                                }
                        }
                    }
                }
            }
            .navigationTitle("Calorie Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        entryList.showAddEntryView.toggle()
                    }, label: {
                        Text("Add Entry")
                    })
                }
            }
            .sheet(isPresented: $entryList.showAddEntryView, content: {
                AddCalorieView(entryList: entryList)
            })
        }
    }
}

struct Entry: Identifiable, Equatable {
    var id = UUID()
    var calories: String
    var food: String
}

class EntryList: ObservableObject {
    @Published var entries: [Entry] = []
    @Published var showAddEntryView = false
    @Published var totalCalories = 0
    
    func addEntry(calories: String, food: String?) {
        entries.append(Entry(calories: calories, food: food ?? "no food specified"))
    }
    
    func deleteEntry(entry: Entry) {
        if let index = entries.firstIndex(of: entry) {
            entries.remove(at: index)
        }
        
        totalCalories = totalCalories - Int(entry.calories)!
    }
}

#Preview {
    ContentView()
}
