//
//  Settings.swift
//  SpaceX
//
//  Created by Владислав Колундаев on 05.01.2023.
//

import Foundation

enum Unit: Codable {
    case meter
    case feet
    case kilogram
    case pound

    var name: String {
        switch self {
        case .meter:
            return "m"
        case .feet:
            return "ft"
        case .kilogram:
            return "kg"
        case .pound:
            return "lb"
        }
    }
}

enum SettingsType: Codable {
    case height
    case diameter
    case weight
    case payload

    var name: String {
        switch self {
        case .height:
            return "Высота"
        case .diameter:
            return "Диаметр"
        case .weight:
            return "Вес"
        case .payload:
            return "Полезная нагрузка"
        }
    }

    var units: [Unit] {
        switch self {
        case .height, .diameter:
            return [.kilogram, .feet]
        case .weight, .payload:
            return [.kilogram, .pound]
        }
    }
}

struct Setting: Codable {
    let type: SettingsType
    let selectedIndex: Int
}
