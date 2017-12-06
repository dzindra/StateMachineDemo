//
//  ViewController.swift
//  StateMachine
//
//  Created by Jindrich Dolezy on 06/12/2017.
//  Copyright © 2017 Dzindra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var startingTimeLabel: UILabel!
    @IBOutlet weak var highlightedSwitch: UISwitch!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var stateLabel: UILabel!
    
    let stateMachine = StateMachine()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.stateMachine.inputTick()
            self?.updateViews()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    func updateViews() {
        currentTimeLabel.text = "\(stateMachine.currentTime)"
        startingTimeLabel.text = "\(stateMachine.startingTime)"
        highlightedSwitch.isOn = stateMachine.highlighted
        activeSwitch.isOn = stateMachine.active
        stateLabel.text = "Current state: \(stateMachine.state)"
    }

    @IBAction func switchAction(_ sender: Any) {
        stateMachine.inputSwitch()
        updateViews()
    }
    
    @IBAction func runAction(_ sender: Any) {
        stateMachine.inputRun()
        updateViews()
    }
}

