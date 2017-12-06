//
//  States.swift
//  StateMachine
//
//  Created by Jindrich Dolezy on 06/12/2017.
//  Copyright © 2017 Dzindra. All rights reserved.
//

import Foundation


struct Ready: State {
    func inputSwitch(_ machine: StateMachine) {
        machine.state = machine.setting
    }
    
    func inputRun(_ machine: StateMachine) {
        machine.state = machine.running
    }
    
    func inputTick(_ machine: StateMachine) {
    }
    
    func enterAction(_ machine: StateMachine) {
        machine.currentTime = machine.startingTime
    }
    
    func exitAction(_ machine: StateMachine) {
    }
}


struct Running: State {
    func inputSwitch(_ machine: StateMachine) {
        machine.state = machine.ready
    }
    
    func inputRun(_ machine: StateMachine) {
        machine.state = machine.paused
    }
    
    func inputTick(_ machine: StateMachine) {
        if machine.currentTime <= 0 {
            machine.state = machine.finished
        } else {
            machine.currentTime -= 1
        }
    }
    
    func enterAction(_ machine: StateMachine) {
        machine.active = true
    }
    
    func exitAction(_ machine: StateMachine) {
        machine.active = false
    }
}


struct Paused: State {
    func inputSwitch(_ machine: StateMachine) {
        machine.state = machine.ready
    }
    
    func inputRun(_ machine: StateMachine) {
        machine.state = machine.running
    }
    
    func inputTick(_ machine: StateMachine) {
    }
    
    func enterAction(_ machine: StateMachine) {
        machine.highlighted = true
    }
    
    func exitAction(_ machine: StateMachine) {
        machine.highlighted = false
    }
}


struct Setting: State {
    func inputSwitch(_ machine: StateMachine) {
        machine.state = machine.ready
    }
    
    func inputRun(_ machine: StateMachine) {
        if machine.currentTime < 20 {
            machine.currentTime += 1
        } else {
            machine.currentTime = 0
        }
    }
    
    func inputTick(_ machine: StateMachine) {
    }
    
    func enterAction(_ machine: StateMachine) {
        machine.currentTime = machine.startingTime
    }
    
    func exitAction(_ machine: StateMachine) {
        machine.startingTime = machine.currentTime
    }
}


struct Finished: State {
    func inputSwitch(_ machine: StateMachine) {
        machine.state = machine.ready
    }
    
    func inputRun(_ machine: StateMachine) {
        machine.state = machine.ready
    }
    
    func inputTick(_ machine: StateMachine) {
    }
    
    func enterAction(_ machine: StateMachine) {
        machine.highlighted = true
    }
    
    func exitAction(_ machine: StateMachine) {
        machine.highlighted = false
    }
}

