//
//  ContentView.swift
//  Recipe book
//
//  Created by Yee chuen Teoh on 3/11/24.
//
//  Fetch Exercise requires that project should be compile with latest Xcode
//  but I only have a 2014 Macbook Air at IOS 11.7.10(Most updated for my Mac), hence my most updated xcode is 13.2.1 (13C100)
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Main Content view (Dessert view)
struct ContentView: View {
    @State private var desserts = [Meal]()

    var body: some View {
        NavigationView{
            List{
                ForEach(desserts, id: \.idMeal) { meal in
                    NavigationLink(
                        destination: MealDetailView(
                            mealId: meal.idMeal,
                            mealName: meal.strMeal
                        ),
                        label: {Text(meal.strMeal)}
                    )
                }
            }
            .navigationTitle("Dessert Recipe Book")
            .onAppear {
                fetchMeals()
            }
        }
    }

    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                    DispatchQueue.main.async {
                        desserts = response.meals
                    }
                    return
                }
            }
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

// Recipe View
struct MealDetailView: View {
    let mealId: String
    let mealName: String
    
    @State private var meals = [MealDetail]()

    var body: some View {
        List(meals, id: \.idMeal) { meal in
            URLImage(url: meal.strMealThumb)
                .frame(height: 200)
                .scaledToFit()
            HStack {
                Text("Meal ID:")
                    .font(.title3)
                    .bold()
                Spacer()
                Text("\(meal.idMeal)")
            }
            HStack {
                Text("Category:")
                    .font(.title3)
                    .bold()
                Spacer()
                Text("\(meal.strCategory)")
            }
            VStack(alignment: .leading){
                Text("Ingredients:")
                    .font(.title3)
                    .bold()
                Text("\n\(meal.ingredients)")
            }
            VStack(alignment: .leading){
                Text("Instructions:")
                    .font(.title3)
                    .bold()
                Text("\n\(meal.instructions)")
            }
        }
        .navigationTitle("\(mealName)")
        .onAppear {
            fetchMealDetail()
        }
    }
    
    func fetchMealDetail() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                    DispatchQueue.main.async {
                        meals = response.meals
                    }
                    return
                }
            }
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

// Helper view to load image from URL
struct URLImage: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Image(systemName: "photo")
                    .symbolRenderingMode(.hierarchical)
            @unknown default:
                EmptyView()
            }
        }
    }
}


