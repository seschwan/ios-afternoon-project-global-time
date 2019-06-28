//
//  TableVC.swift
//  GlobalTime
//
//  Created by Seschwan on 6/27/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

protocol TimeZoneDelegate {
    func didChooseTimeZone(_ timezone: String)
}

class GlobalTimesTableVC: UIViewController {
    
    @IBOutlet weak var globalTimeTableView: UITableView!
    
    // MARK: - Variables
    var timeZoneArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        timeZoneArray.append(TimeZone.current.identifier)
        globalTimeTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToTimeZoneVC" {
            guard let timeZoneTVC = segue.destination as? TimeZoneTableVC else { return }
            timeZoneTVC.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}

extension GlobalTimesTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ClockTableViewCell else { return UITableViewCell() }
        
        let timeZone = timeZoneArray[indexPath.row]
        cell.clockView.timezone = TimeZone.init(identifier: timeZone)
        cell.timeZoneLbl.text = String(timeZone.split(separator: "/").last!)
        
        return cell
    }
    
    
    
}

extension GlobalTimesTableVC: TimeZoneDelegate {
    func didChooseTimeZone(_ timezone: String) {
        dismiss(animated: true) {
            self.timeZoneArray.append(timezone)
            self.globalTimeTableView.reloadData()
        }
    }
    
    
}
