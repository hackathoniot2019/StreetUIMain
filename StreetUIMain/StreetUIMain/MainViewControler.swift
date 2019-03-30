//
//  MainUI.swift
//  StreetUIMain
//
//  Created by Denis Abramov on 30/03/2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        return cell
    }
    
    let slideMenu = SlideOutMenu()

    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()

    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        return button
    }()

    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.alpha = 0
        return textField
    }()
    
    @objc func handleSearch() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.searchButton.frame = CGRect(x: 30.2, y: self.searchButton.frame.origin.y + 0.2, width: 39.8, height: 39.8)
            self.hamburgerButton.frame = CGRect(x: -70, y: self.hamburgerButton.frame.origin.y, width: 40, height: 40)
            let width = self.view.frame.width - 60
            self.whiteView.frame = CGRect(x: 30, y: self.whiteView.frame.origin.y, width: width, height: 40)
            self.whiteView.layer.borderWidth = 0.2
            self.whiteView.layer.borderColor = UIColor.gray.cgColor
            self.searchTableView.frame = CGRect(x: 0, y: 0, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
        }, completion: nil)
    }

    @objc func handleMenu() {
        slideMenu.configureUnderView()
    }

    func configureSearchTableView() {
        view.addSubview(searchTableView)
        searchTableView.anchor(top: view.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height, enableInsets: false)
    }

    func configureHamburgerMenu() {
        view.addSubview(hamburgerButton)
        hamburgerButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, enableInsets: false)

    }

    func configureSearch() {
        view.addSubview(whiteView)
        whiteView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: -30, width: 40, height: 40, enableInsets: false)
        view.addSubview(searchButton)
        searchButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: -30, width: 40, height: 40, enableInsets: false)
}

func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

}

func makeMapView() {
    let mapView = MKMapView()
    mapView.frame = view.frame
    view.addSubview(mapView)
    mapView.delegate = self

    let london = MKPointAnnotation()
    london.title = "London"
    london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
    mapView.addAnnotation(london)
}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchCell.self, forCellReuseIdentifier: "searchCell")
        
        makeMapView()
        
        configureHamburgerMenu()
        configureSearchTableView()
        configureSearch()
        
        view.backgroundColor = UIColor.white
    }
}
