//
//  AddCalorieView.swift
//  Calories
//
//  Created by Harald Kurz on 25.01.24.
//

import SwiftUI

struct AddCalorieView: View {
    
    @ObservedObject var entryList: EntryList
    @State var calories: String = ""
    @State var food: String = ""
    @State var caloriePlaceholder: String = "Calories"
    
    var body: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 350, height: 80)
                    .foregroundColor(.white)
                    .overlay(
                        TextField(caloriePlaceholder, text: $calories)
                            .padding()
                    )
                
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 350, height: 80)
                    .foregroundColor(.white)
                    .overlay(
                        TextField("Food", text: $food)
                            .padding()
                    )
                
                Button(action: {
                    guard let calorieNumber = Int(calories) else {
                        calories = ""
                        caloriePlaceholder = "Calories must not be empty and a number"
                        return
                    }
                    
                    entryList.addEntry(calories: calories, food: food)
                    entryList.showAddEntryView = false
                    entryList.totalCalories = entryList.totalCalories + calorieNumber
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 300, height: 50)
                        .foregroundColor(.blue)
                        .overlay(
                            Text("Add Calories")
                                .foregroundColor(.white)
                                .font(.title2)
                        )
                })
                
                Spacer()
                
            }
            .navigationTitle("Add Calories *mompf*")
        }
    }
}

