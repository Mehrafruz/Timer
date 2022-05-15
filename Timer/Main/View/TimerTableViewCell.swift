//
//  TimerTableViewCell.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//

import UIKit

struct TimerTableViewCellModel {
    let title: String
    let time: Int
    let creationDate = Date()
    var completed = false
    var textCompleted = false
}
class TimerTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let exitButton = UIButton()
    
    var task: TimerTableViewCellModel? {
        didSet {
            titleLabel.text = task?.title
            setState()
            updateTime(with: task?.time ?? 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        exitButton.setBackgroundImage(UIImage(systemName: "xmark.square.fill"), for: UIControl.State.normal)
        exitButton.tintColor = .black
        titleLabel.isHidden = true
        
        [titleLabel, timeLabel].forEach {
            ($0).font = UIFont.systemFont(ofSize: 28, weight: .semibold) }
        
        [titleLabel, timeLabel, exitButton].forEach {
            contentView.addSubview($0) }
        addConstraint()
    }
    
    func addConstraint () {
        [contentView, titleLabel, timeLabel, exitButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            exitButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: UIScreen.main.bounds.width-40),
            exitButton.widthAnchor.constraint(equalToConstant: 25),
            exitButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-150),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.leftAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 30),
            timeLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
            
        ])
    }
    
    func configure(with model: TimerTableViewCellModel) {
        task = model
        titleLabel.text = model.title
        timeLabel.text = String(model.time)
    }
    
    func updateTime(with seconds: Int) {
        guard let task = task else {
            return
        }
        
        if !task.completed {
            let time = -(Date().timeIntervalSince(task.creationDate)-Double(seconds))
            
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            
            var times: [String] = []
            
            if minutes > 0 {
                times.append("\(minutes)m")
            }
            times.append("\(seconds)s")
            
            timeLabel.text = times.joined(separator: " ")
            
            if seconds == 0 && minutes == 0 {
                self.task?.completed = true
            }
        }
    }
    
    private func setState() {
        guard let task = task else {
            return
        }
        
        if task.completed {
            timeLabel.isHidden = true
            titleLabel.isHidden = false
            self.isHighlighted = true
            //через 5 сек зову метод который удаляет ячейку
        } else if task.textCompleted {
            
        }
    }
}
