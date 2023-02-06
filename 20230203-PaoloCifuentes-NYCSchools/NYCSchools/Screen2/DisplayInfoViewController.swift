//
//  DisplayInfoViewController.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 02/04/23.
//

import UIKit

class DisplayInfoViewController: UIViewController {
    
    @IBOutlet private weak var schoolName: UILabel!
    @IBOutlet private weak var criticalScore: UILabel!
    @IBOutlet private weak var mathScore: UILabel!
    @IBOutlet private weak var writingScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let school = school else { return }
        schoolName.text = school.schoolName
        criticalScore.text = "SAT Critical Thinking Avg Score: \(school.satCriticalReading)"
        mathScore.text = "SAT Math Avg Score: \(school.satMath)"
        
    }
    var school: School?
    
    
}
