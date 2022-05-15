//
//  TimerViewController.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//  
//

import UIKit

final class TimerViewController: UIViewController {
    private let output: TimerViewOutput
    let queue = OperationQueue()
    private var tableView = UITableView()
    var timer: Timer?
    
    init(output: TimerViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.loadTimers()
        createTimer()
        setup()
        
    }
    
    private func setup() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(TimerTableViewCell.self, forCellReuseIdentifier: "TimerTableViewCell")
        [tableView].forEach{
            view.addSubview($0)
        }
        addConstraint()
    }
    
    func addConstraint() {
        [tableView].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func createTimer() {
      if timer == nil {
        let timer = Timer(timeInterval: 1.0,
          target: self,
          selector: #selector(updateTimer),
          userInfo: nil,
          repeats: true)
        RunLoop.current.add(timer, forMode: .common) // TODO: Для того чтобы когда прокручиваешь таймер не зависал
        timer.tolerance = 0.1
    
          self.timer = timer
      }
    }
    
    @objc func updateTimer() {
        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }
        DispatchQueue.main.async() {
            for indexPath in visibleRowsIndexPaths {
                
                if let cell = self.tableView.cellForRow(at: indexPath) as? TimerTableViewCell {
                    let item = self.output.display(at: indexPath.row)
                    cell.updateTime(with: item.time)
                }
            }
            
        }
    }
}

extension TimerViewController: TimerViewInput {
    func update(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func insert(at index: Int) {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func remove(at index: Int) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.itemCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell", for: indexPath) as? TimerTableViewCell else {
            return .init()
        }
        
        let item = output.display(at: indexPath.row)
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell", for: indexPath) as? TimerTableViewCell else {
        //            return         }
        //        cell.isHighlighted = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            output.didTapRemoveButton(at: indexPath.row)
        }
    }
    
}
