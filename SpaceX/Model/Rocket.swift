//
//  Rocket.swift
//  SpaceX
//
//  Created by Владислав Колундаев on 23.12.2022.
//

import Foundation

// MARK: - RocketElement
struct Rocket: Decodable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    let wikipedia: String
    let rocketDescription, id: String
}

extension Rocket {
    // MARK: - Diameter
    struct Diameter: Codable {
        let meters, feet: Double?
    }

    // MARK: - Engines
    struct Engines: Codable {
        let isp: ISP
        let thrustSeaLevel, thrustVacuum: Thrust
        let number: Int
        let type, version: String
        let layout: String?
        let engineLossMax: Int?
        let propellant1, propellant2: String
        let thrustToWeight: Double
    }

    // MARK: - ISP
    struct ISP: Codable {
        let seaLevel, vacuum: Int
    }

    // MARK: - Thrust
    struct Thrust: Codable {
        let kN, lbf: Int
    }

    // MARK: - FirstStage
    struct FirstStage: Codable {
        let thrustSeaLevel, thrustVacuum: Thrust
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    // MARK: - LandingLegs
    struct LandingLegs: Codable {
        let number: Int
        let material: String?
    }

    // MARK: - Mass
    struct Mass: Codable {
        let kg, lb: Int
    }

    // MARK: - PayloadWeight
    struct PayloadWeight: Codable {
        let id, name: String
        let kg, lb: Int
    }

    // MARK: - SecondStage
    struct SecondStage: Codable {
        let thrust: Thrust
        let payloads: Payloads
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    // MARK: - Payloads
    struct Payloads: Codable {
        let compositeFairing: CompositeFairing
        let option1: String
    }

    // MARK: - CompositeFairing
    struct CompositeFairing: Codable {
        let height, diameter: Diameter
    }
}
