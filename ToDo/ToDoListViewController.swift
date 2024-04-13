//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Иван Семенов on 13.04.2024.
//

import UIKit
import SnapKit

class ToDoListViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        return tableView
    }()
    
    var itemArray = ["Поплавать", "Купить мясо", "Скататься на пляж"]

    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
        setupNavigationBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
        
        
    }
    //MARK: - Add New Item
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = .systemBlue
        title = "ToDo"
        
    }
    @objc private func addButton() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить новую задачу?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { alert in
            ///что произойдет когда пользователь нажмет кнопку
            print("Success!")
            self.itemArray.append(textField.text ?? "")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTF in
            alertTF.placeholder = "Введите текст"
            textField = alertTF
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    //MARK: - Add Constraints
    private func addConstraints() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
//MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.titleLabel.text = itemArray[indexPath.row]
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///убираем или показываем галочку
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

