//
//  ContentView.swift
//  helloWorld
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
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var result: String = ""
    @State private var selectedGender: String = "Male" //default selection - compile time error with Picker
    
    let genderOptions = ["Male", "Female", "Other"]

    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Details!")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            TextField("Height in cm", text: $height)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            TextField("Weight in kg", text: $weight)
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
            
            //default calculation for males = 10 * Weight(kg) +
            //6.25 * height(cm) - 5*Age + 5
            Button("Calculate") {
                result = String(format: "%.2f", (Double(weight)!) * (Double(height)!))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text(result)
                .padding()
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Data Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    ContentView()
//}
