//
//  ViewController.swift
//  GET People
//
//  Created by Safa Falaqi on 21/12/2021.
//

import UIKit

class PeopleViewController: UITableViewController {

    var peopleList: [Result]? = []
    var url = URL(string: "https://swapi.dev/api/people/?format=json")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        loadData()
        tableView.dataSource = self
        
    }
    
    func loadData(){
  
        for i in 1...9{
    
            let task = PeopleModel.getAllPeople(pageIndex: i, completionHandler: {
                    // see: Swift closure expression syntax
                    data, response, error in
                    // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
                    // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
                    do {
                        //optional unwraping
                        guard let myData = data else {return}
                        
                        let decoder = JSONDecoder()
                        
                        let jesonResult = try decoder.decode(People.self, from: myData)
                        
                        self.peopleList?.append(contentsOf: jesonResult.results)
                        
                        DispatchQueue.main.async {
                         self.tableView.reloadData()
                        }
                      
                    } catch {
                        print(error)
                    }
                })
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell",for : indexPath)
        cell.textLabel?.text = peopleList?[indexPath.row].name ?? "No data"
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList?.count ?? 0
    }
}

