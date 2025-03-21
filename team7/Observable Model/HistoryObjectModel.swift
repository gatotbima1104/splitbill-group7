//
//  HIstoryObjectModel.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import Foundation

class HistoryObjectModel: ObservableObject {
    
    @Published var historyObjects: [HistoryModel] = [
        HistoryModel(name: "Top 100", people: [
            PersonModel(name: "Isa", bills: [
                BillModel(name: "Es Teh", price: 5000),
                BillModel(name: "Nasi Goreng", price: 10000)
            ]),
            PersonModel(name: "Yudha", bills: [
                BillModel(name: "Es Jeruk", price: 5000),
                BillModel(name: "Nasi Ayam", price: 20000)
            ]),
            PersonModel(name: "Pram", bills: [
                BillModel(name: "Es Teh", price: 5000),
                BillModel(name: "Nasi Ayam", price: 20000)
            ])
        ], bills: [
            BillModel(name: "Es Teh", price: 5000),
            BillModel(name: "Es Jeruk", price: 5000),
            BillModel(name: "Nasi Goreng", price: 10000),
            BillModel(name: "Nasi Ayam", price: 20000)
        ]),

        HistoryModel(name: "Weekend Hangout", people: [
            PersonModel(name: "Aldi", bills: [
                BillModel(name: "Kopi Hitam", price: 15000),
                BillModel(name: "Roti Bakar", price: 12000)
            ]),
            PersonModel(name: "Dimas", bills: [
                BillModel(name: "Milkshake", price: 20000),
                BillModel(name: "Burger", price: 35000)
            ]),
            PersonModel(name: "Siti", bills: [
                BillModel(name: "Green Tea", price: 18000),
                BillModel(name: "French Fries", price: 25000)
            ])
        ], bills: [
            BillModel(name: "Kopi Hitam", price: 15000),
            BillModel(name: "Roti Bakar", price: 12000),
            BillModel(name: "Milkshake", price: 20000),
            BillModel(name: "Burger", price: 35000),
            BillModel(name: "Green Tea", price: 18000),
            BillModel(name: "French Fries", price: 25000)
        ]),

        HistoryModel(name: "Office Lunch", people: [
            PersonModel(name: "Budi", bills: [
                BillModel(name: "Soto Ayam", price: 25000),
                BillModel(name: "Teh Manis", price: 5000)
            ]),
            PersonModel(name: "Rina", bills: [
                BillModel(name: "Nasi Padang", price: 40000),
                BillModel(name: "Es Campur", price: 15000)
            ]),
            PersonModel(name: "Doni", bills: [
                BillModel(name: "Bakso", price: 30000),
                BillModel(name: "Jus Alpukat", price: 20000)
            ]),
            PersonModel(name: "Citra", bills: [
                BillModel(name: "Gado-Gado", price: 25000),
                BillModel(name: "Es Teh", price: 5000)
            ])
        ], bills: [
            BillModel(name: "Soto Ayam", price: 25000),
            BillModel(name: "Teh Manis", price: 5000),
            BillModel(name: "Nasi Padang", price: 40000),
            BillModel(name: "Es Campur", price: 15000),
            BillModel(name: "Bakso", price: 30000),
            BillModel(name: "Jus Alpukat", price: 20000),
            BillModel(name: "Gado-Gado", price: 25000),
            BillModel(name: "Es Teh", price: 5000)
        ]),

        HistoryModel(name: "Birthday Party", people: [
            PersonModel(name: "Fajar", bills: [
                BillModel(name: "Pizza", price: 75000),
                BillModel(name: "Soft Drink", price: 15000)
            ]),
            PersonModel(name: "Hana", bills: [
                BillModel(name: "Pasta", price: 60000),
                BillModel(name: "Orange Juice", price: 20000)
            ]),
            PersonModel(name: "Ari", bills: [
                BillModel(name: "Steak", price: 90000),
                BillModel(name: "Lemon Tea", price: 18000)
            ]),
            PersonModel(name: "Nadia", bills: [
                BillModel(name: "Sushi", price: 75000),
                BillModel(name: "Matcha Latte", price: 25000)
            ]),
            PersonModel(name: "Danu", bills: [
                BillModel(name: "Fried Chicken", price: 45000),
                BillModel(name: "Iced Coffee", price: 22000)
            ])
        ], bills: [
            BillModel(name: "Pizza", price: 75000),
            BillModel(name: "Soft Drink", price: 15000),
            BillModel(name: "Pasta", price: 60000),
            BillModel(name: "Orange Juice", price: 20000),
            BillModel(name: "Steak", price: 90000),
            BillModel(name: "Lemon Tea", price: 18000),
            BillModel(name: "Sushi", price: 75000),
            BillModel(name: "Matcha Latte", price: 25000),
            BillModel(name: "Fried Chicken", price: 45000),
            BillModel(name: "Iced Coffee", price: 22000)
        ])
    ]
}

