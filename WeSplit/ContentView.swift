//
//  ContentView.swift
//  WeSplit
//
//  Created by Maryna Bolotska on 19/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var theTip = 0.00

     // Computed variable.
     // Did the patron leave a tip? Return TRUE or FALSE
     var leftATip: Bool { theTip > 0.00 }
  
    
    let tipPercentages = [10, 15, 20, 0]
    var wholeAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
        
        
    }
    var totalTip: String {
           let formatter = NumberFormatter()
           formatter.numberStyle = .currency
           return formatter.string(from: NSNumber(value: theTip)) ?? "$0"
       }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                ZStack {
                    
                            // SwiftUI is declarative.
                            // DECLARE what you want the user to see.
                            Rectangle().foregroundColor( leftATip ? .green : .red)  // Declare the color based on the TIP value
                            Text(totalTip).font(.largeTitle).padding(.horizontal)
                        }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            header: {
                Text("How much tip do you want to leave?")
            }
                Section {
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            header: {
                Text("Amount per person")
            }
                Section {
                    
                    Text(wholeAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            header: {
                Text("Whole Amount")
            }
            }
            
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
                
            }
            
            }
        }
    }
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
   

