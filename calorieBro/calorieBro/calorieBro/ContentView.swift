//
//  ContentView.swift
//  calorieBro
//
//  Created by Tarush Sinha on 6/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LandingPage()
        }
    }
}

struct LandingPage: View {
    var body: some View {
        VStack {
            Image(systemName: "scalemass")
                .imageScale(.large)
                .foregroundStyle(.tint)
//            Text("Hello, world!")
            Text("Welcome to CalorieBro!")
                .font(.title)
                .fontWeight(.bold)
            NavigationLink(destination: CalorieBroMainView()){
                Text("Get Swole")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct CalorieBroMainView: View {
    @State private var heightText: String = ""
    @State private var weightText: String = ""
    @State private var ageText: String = ""
    @State private var result: String = ""
    @State private var selectedGender: String = "Other" //default selection - resolving compile time error with Picker
    @State private var showAlert = false
    @State private var resultFlag = false
    @State private var alertMsg: String = ""
    
    let genderOptions = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Details!")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            TextField("Enter Your Age", text: $ageText)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            TextField("Height in Inches", text: $heightText)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            TextField("Weight in Pounds", text: $weightText)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            Text("Select Gender")
                .font(.headline)
            
            Picker("Gender", selection: $selectedGender) {
                ForEach(genderOptions, id: \.self) {gender in
                    Text(gender)
                }
            }
            .pickerStyle(.segmented)
            
            
            Button("Calculate") {
                if ageText.isEmpty {
                    alertMsg = "Please enter valid values."
                    showAlert = true
                }
                else if weightText.isEmpty {
                    alertMsg = "Please enter valid values."
                    showAlert = true
                }
                else if heightText.isEmpty {
                    alertMsg = "Please enter valid values."
                    showAlert = true
                }
                else {
                    if selectedGender == "Other" {
                        result = "Not supported yet as the Mifflin-St Jeor Equation wasn't originally designed with nonbinary individuals in mind, nor is there a validated equation tailored at this time"
                    }
                    else {
                        result = "You entered your age as \(ageText), height as \(heightText) inches and weight as \(weightText) pounds. If this is correct, click the button below to proceed!"
                        resultFlag = true
                    }
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMsg),
                    dismissButton: .default(Text("OK"))
                )
            }
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text(result)
                .padding()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            if resultFlag {
                Group {
                    if let ageVal = Int(ageText),
                    let heightVal: Double = Double(heightText),
                    let weightVal: Double = Double(weightText) {
                        
                        let genderEnum = Gender(rawValue: selectedGender) ?? .other
                        
                        NavigationLink(destination:
                                ResultView(
                                    age: ageVal,
                                    height: heightVal,
                                    weight: weightVal,
                                    gender: genderEnum
                                )
                            ) {
                                Text("View Recommended Intake")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Data Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ResultView: View {
    let age: Int
    let height: Double // inches
    let weight: Double // pounds
    let gender: Gender
    
    var bmr: Double {
        CalorieService.calculateBMR(age: age, height: height, weight: weight, gender: gender)
    }
    var tdee: Double {
        CalorieService.adjustForActivity(bmr: bmr, activityLevel: .sedentary)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your estimated BMR is \(Int(bmr)) kcal/day")
            Text("Estimated daily calories (TDEE): \(Int(tdee)) kcal/day")
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
