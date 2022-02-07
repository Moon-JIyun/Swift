//
//  ViewController.swift
//  TodoList
//
//  Created by jiyun moon on 2021/11/13.
//

//userdefaults - 앱 실행 중, 기본 저장소에 접근하여 데이터를 저장, 불러오기

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    var doneButton: UIBarButtonItem?
    
    //배열의 동적 선언
    var tasks = [Task]() {
        didSet{
            self.saveTasks()
        }
    } // tasks 라는 변수에 Task타입의 배열을 초기화, {} tasks property 에 property observer 작성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        //selector : objective c에서 사용되던 것 , 동적 호출 등의 목적으로 사용 , swift에서 구조체로 넘어옴.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTasks()
        
    }
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }
    
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        guard !self.tasks.isEmpty else { return }
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: "할 일을 입력해주세요", preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "할 일을 입력해주세요"})
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveTasks() {
        let data = self.tasks.map {
            [
                "title" : $0.title,
                "done" : $0.done
            ]
        } // tasks 배열에 있는 요소들을 dictionary 형태로 mapping
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data,forKey: "tasks")
    }
    func loadTasks() {
        let useDefaults = UserDefaults.standard
        guard let data = useDefaults.object(forKey: "tasks") as? [[String: Any]] else { return } // 불러올 때 object 사용, Any type으로 불러오기 때문에, type casting 필요
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else {return nil}
            guard let done = $0["done"] as? Bool else {return nil}
            return Task(title: title, done: done)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    // dequeReusableCell : 재사용 가능한 tableview cell 반환, -> 백개, 천개 이상의 cell 이 있을 때, 셀을 모두 만들어서 메모리에 할당하는 것이 아니라, 기존 셀을 재사용함으로써 메모리 누수 방지.
    // ex)view 에 5개의 cell 만 보인다면, 5개의 셀을 재사용하여, 스클롤 하면서 새로운 데이터를 기존 셀에 보여주고, 기존 데이터는 deque로

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
