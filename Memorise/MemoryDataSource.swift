//
//  MemoryDataSource.swift
//  Memorise
//
//  Created by Shubhamay Das on 11/03/22.
//

import UIKit

class MemoryDataSource: NSObject , UITableViewDataSource {
    var items = [MemoryItem]()
    
    override init() {
        guard let url = Bundle.main.url(forResource: "MemoryItems", withExtension: ".json") else {
            fatalError("Can't find json")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't Load json")
        }
        let decoder = JSONDecoder()
        
        guard let savedItem = try? decoder.decode([MemoryItem].self, from: data) else {
            fatalError("Failed to decode json")
        }
        items = savedItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.text
        
        return cell
    }
    
    func item(at index: Int) -> MemoryItem {
            return items[index]
    }
}
