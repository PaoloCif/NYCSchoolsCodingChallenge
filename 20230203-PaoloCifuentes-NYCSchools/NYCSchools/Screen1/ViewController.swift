//
//  ViewController.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 02/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var schoolsTableView: UITableView! {
        didSet {
            self.schoolsTableView.tableFooterView = UIView()
            self.schoolsTableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetch()
    }
    var schoolsDataSource: Highschools? {
        didSet {
            DispatchQueue.main.async {
                self.schoolsTableView.reloadData()
            }
        }
    }
    var currentIndex = 0
    
    // fetching the data from the URL
    func fetch() {
        guard let url = URL(string: "https://data.cityofnewyork.uc/resource/f9bf-2cp4.json") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let unwrappedData = data else {
                return
            }
            switch response.statusCode {
            case 200...299:
                do {
                    self.schoolsDataSource = try JSONDecoder().decode(Highschools.self, from: unwrappedData)
                } catch {
                    print(error.localizedDescription)
                }
            default:
                break
            }

        }.resume()
    }

}

//extension of the tableviewcontroller so that we can fill the data source.
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolsDataSource?.schools.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
        
        if reusableCell == nil {
            cell = reusableCell ?? UITableViewCell()
        } else {
            cell = UITableViewCell(style: .value2, reuseIdentifier: "defaultCell")
        }
        cell.textLabel?.text = String(schoolsDataSource?.schools[indexPath.row].schoolName ?? "")
        cell.textLabel?.textColor = .white
        
        return cell
    }
}

//extension for whne a row is selected we segue into the next view.
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentIndex = indexPath.row
        let sb = storyboard?.instantiateViewController(withIdentifier: "DisplayInfoViewController") as! DisplayInfoViewController
        sb.school = schoolsDataSource?.schools[indexPath.row]
        self.navigationController?.pushViewController(sb, animated: true)
    }
}


