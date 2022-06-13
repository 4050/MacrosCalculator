//
//  DetailView.swift
//  macrosCalculator
//
//  Created by Stanislav on 12.04.2022.
//

import SwiftUI

struct DetailView: View {
    var macrosViewModel: MacrosViewModel?
    
    var body: some View {
        VStack {
            Text("Calories: \(macrosViewModel?.calories ?? 0, specifier: "%.f")")
                .fontWeight(.bold)
                .font(.title)
            Text("Protein: \(macrosViewModel?.protein ?? 0, specifier: "%.f")")
                .fontWeight(.bold)
                .font(.title)
            Text("Carbs: \(macrosViewModel?.carbs ?? 0, specifier: "%.f")")
                .fontWeight(.bold)
                .font(.title)
            Text("Fat: \(macrosViewModel?.fat ?? 0, specifier: "%.f")")
                .fontWeight(.bold)
                .font(.title)
        }
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
