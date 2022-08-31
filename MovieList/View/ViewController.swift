//
//  ViewController.swift
//  MovieList
//
//  Created by никита богатырев on 31.08.2022.
//

import UIKit

class ViewController: UIViewController{
    
    var viewModel = ViewModel()
    
    private var filmNameField:UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "Title"
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        field.layer.borderWidth = 2
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var filmYearField:UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "Year"
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        field.layer.borderWidth = 2
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .link
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
            viewModel.alertHandler = {[weak self] alertMessage in
                self?.present(alertMessage, animated: true, completion: nil)
            }
        
        
        NSLayoutConstraint.activate([
            filmNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            filmNameField.heightAnchor.constraint(equalTo: filmNameField.widthAnchor, multiplier: 0.12),
            filmNameField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            filmYearField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmYearField.widthAnchor.constraint(equalTo: filmNameField.widthAnchor),
            filmYearField.heightAnchor.constraint(equalTo: filmNameField.heightAnchor),
            filmYearField.topAnchor.constraint(equalTo: filmNameField.bottomAnchor, constant: 10),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor, multiplier: 0.5),
            addButton.topAnchor.constraint(equalTo: filmYearField.bottomAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        addButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func setUpView(){
        setUpTableView()
        view.backgroundColor = .white
        view.addSubview(filmNameField)
        view.addSubview(filmYearField)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func didTapButton(){
       
        if let name = filmNameField.text,
           let year = Int(filmYearField.text ?? "0"){
            viewModel.addFilmToTableView(name: name, year: year)
        }else {
            let alert = UIAlertController(title: "Whoops", message: "Please enter all info", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        cell.configure(model: viewModel.films[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            // delete film
            tableView.beginUpdates()
            viewModel.films.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }
}
