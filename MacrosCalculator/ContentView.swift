//
//  ContentView.swift
//  macrosCalculator
//
//  Created by Stanislav on 10.04.2022.
//

import SwiftUI

enum Field: Int, CaseIterable {
    case age, height, weight, protein, fat
}

struct ContentView: View {
    
    @ObservedObject var macrosViewModel = MacrosViewModel()
    
    @State var age: String = ""
    @State var height: String = ""
    @State var weight: String = ""
    @State var gender = Gender(rawValue: Gender.female.rawValue) ?? .female
    @State var levelActivity = LevelActivity(rawValue: LevelActivity.light.rawValue) ?? .light
    @State var personalGoal = Goals(rawValue: Goals.mildWeightLoss.rawValue) ?? .mildWeightLoss
    @State var showDetailView = false
    @State var protein: String = ""
    @State var fat: String = ""
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    PersonalInformation(age: $age, height: $height, weight: $weight, gender: $gender, focusedField: $focusedField)
                    ActivityLevel(levelActivity: $levelActivity)
                    Goal(personalGoal: $personalGoal)
                    PersonalMacros(protein: $protein, fat: $fat, focusedField: $focusedField)
                    Section(header: Text("")) {
                        EmptyView()
                    }
                    .padding(.bottom, 20)
                }   .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Macros Calculator")
                    .navigationViewStyle(StackNavigationViewStyle())
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button ("Done") {
                                focusedField = nil
                            }
                        }
                    }
                saveButton
            } .sheet(isPresented: $showDetailView) {
                DetailView(macrosViewModel: macrosViewModel)
            }
        }
    }
    
    var saveButton: some View {
        Button(action: {
            saveData()
            showDetailView.toggle()
        }, label: {
            Text("Calculate")
                .bold()
                .frame(width: 250, height: 50, alignment: .center)
                .background(.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
        }) .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)
    }
    
    func saveData() {
        let age = (age as NSString).doubleValue
        let height = (height as NSString).doubleValue
        let weight = (weight as NSString).doubleValue
        
        macrosViewModel.getMacros(personalInfo: PersonalInfoModel(age: age, height: height, weight: weight, gender: gender, levelActivity: levelActivity, personalGoal: personalGoal))
    }
}



struct PersonalInformation: View {
    @Binding var age:  String
    @Binding var height: String
    @Binding var weight: String
    @Binding var gender: Gender
    
    var focusedField: FocusState<Field?>.Binding
    
    var genderText: [String] = ["Male", "Moderate", "High"]
    
    var body: some View {
        Section(header: Text("Personal Information")) {
            HStack {
                Text("Age:")
                TextField("Age", text: $age)
                    .focused(focusedField, equals: .age)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Height (cm):")
                TextField("Height (cm)", text: $height)
                    .focused(focusedField, equals: .height)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Weight (kg):")
                TextField("Weight (kg)", text: $weight)
                    .focused(focusedField, equals: .weight)
                    .keyboardType(.numberPad)
            }
            
            Picker(selection: $gender, label: Text("Gender:")) {
                ForEach(Gender.allCases, id: \.self)  { genderCases in
                    Text(genderCases.rawValue.capitalized)
                }
            }
        } .headerProminence(.increased)
    }
}




struct ActivityLevel: View {
    @Binding var levelActivity: LevelActivity
    
    var body: some View {
        Section(header: Text("Activity level")) {
            Picker(selection: $levelActivity, label: Text("Choose you level")) {
                ForEach(LevelActivity.allCases, id: \.self) { levelActivity in
                    Text(levelActivity.rawValue.capitalized)
                }
            }
        } .headerProminence(.increased)
    }
}

struct Goal: View {
    @Binding var personalGoal: Goals
    var body: some View {
        Section(header: Text("Goal")) {
            Picker(selection: $personalGoal, label: Text("Choose you goal")) {
                ForEach(Goals.allCases, id: \.self) { personalGoal in
                    Text(personalGoal.rawValue.capitalized)
                }
            }
        }.headerProminence(.increased)
    }
}

struct PersonalMacros: View {
    @Binding var protein: String
    @Binding var fat: String
    var focusedField: FocusState<Field?>.Binding
    @State var percentSwitch: Int = 0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Section(header: Text("Personal Macros")) {
            Picker("Favorite Color", selection: $percentSwitch, content: {
                Text("Gram").tag(0)
                Text("Percent").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle()) // <1>
            
            switch percentSwitch {
            case 0:
                HStack {
                    Text("Protein:")
                    TextField("Protein (g)", value: $protein, formatter: formatter)
                        .focused(focusedField, equals: .protein)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Fat:")
                    TextField("Fat (g)", value: $fat, formatter: formatter)
                        .focused(focusedField, equals: .fat)
                        .keyboardType(.decimalPad)
                }
            case 1:
                HStack {
                    Text("Protein:")
                    TextField("Protein (%)", value: $protein, formatter: formatter)
                        .focused(focusedField, equals: .protein)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Fat:")
                    TextField("Fat (%)", value: $fat, formatter: formatter)
                        .focused(focusedField, equals: .fat)
                        .keyboardType(.decimalPad)
                }
            default:
               Text("")
            }
            
        }.headerProminence(.increased)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}




