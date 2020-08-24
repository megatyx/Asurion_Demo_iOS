//
//  MainViewController.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/23/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    //TODO: Add Loader Views!!!!!!

    // MARK: - Init TableView with Nibs
    let tableView: UITableView = {
        var newTableView = UITableView()
        newTableView.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell")
        newTableView.register(UINib(nibName: "PetTableViewCell", bundle: nil), forCellReuseIdentifier: "PetTableViewCell")
        newTableView.register(UINib(nibName: "WorkingHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkingHoursTableViewCell")
        return newTableView
    }()
    
    // MARK: - View Model
    let viewModel: MainVCViewModel = MainVCViewModel()
    
    func bindViewModel() {
        self.viewModel.onConfigUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.onPetsUpdated = {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        self.viewModel.fetchConfig()
        self.viewModel.fetchPets()
    }
    
    // MARK: - Funtions
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func checkHoursAndCall() -> Void {
        guard let config = self.viewModel.config else {return}
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE HHmm"
        let dateStrings = formatter.string(from: Date()).components(separatedBy: " ")
        guard let comparisonDay = OpenDay(shortDay: dateStrings[0]),
            let comparisonTime = Int(dateStrings[1]) else {return}
        var title: String = "Work hours has ended. Please contact us again on the next work day"
        if OpenDay.weekdayIsBetweenTwo(startDay: config.workingTime.startDay, endDay: config.workingTime.endDay, comparisonDay: comparisonDay) {
            if config.workingTime.startTime <= comparisonTime && comparisonTime <= config.workingTime.endTime {
                title = "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
            }
        }
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

//MARK: - UITableView Delegates
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 || indexPath.row == 0 {
            return self.view.frame.height / 9
            //return 75
        }
        return self.view.frame.height / 6
        //return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.viewModel.config != nil else {return 0}
        return 2 + (self.viewModel.pets?.count ?? 0)
    }
    
    // MARK: - Cell For Row At Index Path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appConfig = self.viewModel.config else {return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TwoButtonsTableViewCell", for: indexPath) as? TwoButtonsTableViewCell else {return UITableViewCell()}
            cell.isCallEnabled = appConfig.isCallEnabled
            cell.isChatEnabled = appConfig.isChatEnabled
            cell.callButtonPushed = { [weak self] _ in
                self?.checkHoursAndCall()
            }
            cell.chatButtonPushed = { [weak self] _ in
                self?.checkHoursAndCall()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingHoursTableViewCell", for: indexPath) as? WorkingHoursTableViewCell else {return UITableViewCell()}
            cell.officeHoursLabel.text = "Office Hours: \(appConfig.workingTimeString)"
            return cell
        default:
            guard let pet = self.viewModel.pets?[indexPath.row - 2],
                let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as? PetTableViewCell else { return UITableViewCell() }
            cell.petImageView.loadImageUsingCache(withUrl: pet.imageURL)
            cell.petNameLabel.text = pet.title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 1,
            let pet = self.viewModel.pets?[indexPath.row - 2] else {return}
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: pet.contentURL, configuration: config)
        present(vc, animated: true)
    }
}

