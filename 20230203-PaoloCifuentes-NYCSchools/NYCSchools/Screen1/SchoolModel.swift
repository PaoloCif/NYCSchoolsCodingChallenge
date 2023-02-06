//
//  SchoolModel.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 11/19/21.
//

import Foundation


struct Highschools: Decodable {
    var schools: [School]
    
    enum CodingKeys: String, CodingKey {
        case schools
    }
}

struct School: Decodable {
    var schoolName: String
    var satCriticalReading: String
    var satMath: String
    var satWriting: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case satCriticalReading = "SAT Critical Reading Avg. Score"
        case satMath = "SAT Math Avg. Score"
        case satWriting = "SAT Writing Avg. Score"
    }
}


