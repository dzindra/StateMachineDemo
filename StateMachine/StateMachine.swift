//
//  StateMachine.swift
//  StateMachine
//
//  Created by Jindrich Dolezy on 06/12/2017.
//  Copyright © 2017 Dzindra. All rights reserved.
//

import Foundation


protocol State {
    func inputSwitch(_ machine: StateMachine)
    
    func inputRun(_ machine: StateMachine)
    
    func inputTick(_ machine: StateMachine)
    
    func enterAction(_ machine: StateMachine)
    
    func exitAction(_ machine: StateMachine)
}


class StateMachine {
    let ready = Ready()
    let running = Running()
    let paused = Paused()
    let setting = Setting()
    let finished = Finished()
    
    init() {
        state = ready
        state.enterAction(self)
    }
    
    var state: State {
        didSet {
            oldValue.exitAction(self)
            state.enterAction(self)
        }
    }
    
    var currentTime: Int = 0
    var startingTime: Int = 10
    var highlighted: Bool = false
    var active: Bool = false
    
    func inputTick() {
        state.inputTick(self)
    }
    
    func inputRun() {
        state.inputRun(self)
    }
    
    func inputSwitch() {
        state.inputSwitch(self)
    }
    
}


extension StateMachine: CustomStringConvertible {
    var description: String {
        return "state=\(state), time=\(currentTime), startingTime=\(startingTime), highlighted=\(highlighted), active=\(active)"
    }
}
