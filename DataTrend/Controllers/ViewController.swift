//
//  ViewController.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 21/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataList: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    let refreshController = UIRefreshControl()
    
    var resultData: [DisplayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Quarter - Volume Of Mobile Data(Petabytes)
        initializeView()
    }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            //Fetch data on load
            fetchData()
        }
    }

    extension ViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return resultData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell: DataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DataTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: resultData[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Year\tVolume Of Mobile Data(PB)"
        }
    }

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    private extension ViewController {
        
        // MARK: - User Methods
        
        func initializeView() {
            //Set table view properties
            dataList.estimatedRowHeight = 100.0
            dataList.rowHeight = UITableView.automaticDimension
            dataList.tableFooterView = UIView(frame: .zero)
            dataList.refreshControl = refreshController
            refreshController.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        }
        
        @objc private func refreshData(_ sender: Any) {
            fetchData(isPull: true)
        }
        
        func fetchData(isPull: Bool? = false) {
            guard let reachability = Reachability(), reachability.isReachable else {
                refreshController.endRefreshing()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [] in
                    Utility.showNetworkError()
                }
                return
            }
            if !isPull! {
                loader.startAnimating()
            }
            //Get data from API
            DataViewModel().fetchDataWithLimit(limit: 100, completion: { [weak self] (result: [ResultModel], error: String?) in
                guard let self = self else { return }
                self.reloadResults(data: result)
            })
        }
        
        func convertData(data: [ResultModel]) -> [DisplayModel] {
            var yearArray = [String]()
            for obj in data {
                yearArray.append(String(obj.quarter.prefix(4)))
            }
            yearArray = Array(Set(yearArray)).sorted()
            
            var groupArray: [DisplayModel] = []
            for year in yearArray {
                let yearObj = data.filter{$0.quarter.contains(year)}
                let vol = yearObj.reduce(0) {$0 + (Double($1.volume) ?? 0)}
                let resultObj = DisplayModel(year: year, volume: "\(vol)")
                groupArray.append(resultObj)
            }
            return groupArray
        }
        
        func reloadResults(data: [ResultModel]) {
            resultData = convertData(data: data)
            if resultData.count == 0 {
                Utility.showErrorAlert(with: "No data available at the moment, please try again after sometime.")
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.refreshController.endRefreshing()
                self.loader.stopAnimating()
                self.dataList.reloadData()
            }
        }
    }
