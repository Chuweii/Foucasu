//
//  FocusViewModelSpec.swift
//  FoucasuTests
//
//  Created by Wei Chu on 2024/6/24.
//

import Quick
import Nimble
@testable import Foucasu

class FocusViewModelSpec: QuickSpec {
    override class func spec() {
        var viewModel: FocusViewModel!
        
        beforeEach {
            viewModel = FocusViewModel()
        }
        
        describe("Activity Button") {
            context("click activity button, and the timer hasn't started") {
                beforeEach {
                    viewModel.didClickActivityButton()
                }
                
                it("should show SetTimeView") {
                    expect(viewModel.isTimerViewVisible).to(beTrue())
                }
                
                context("when user tap the out of SetTimeView") {
                    beforeEach {
                        viewModel.didClickEmptySpace()
                    }
                    
                    it("should close the SetTimeView") {
                        expect(viewModel.isTimerViewVisible).to(beFalse())
                    }
                }
                
                context("when user setup the time and click save button") {
                    beforeEach {
                        viewModel.seconds = 3
                        viewModel.didClickSaveButton()
                    }
                    it("timer will start counting down") {
                        expect(viewModel.isStarted).to(beTrue())
                    }
                    
                    context("when time's up, and user click close button") {
                        beforeEach {
                            viewModel.didClickStopButton()
                        }
                        
                        it("screen should close SetTimeView") {
                            expect(viewModel.isTimerViewVisible).to(beFalse())
                        }
                    }
                    
                    context("when time's up, and user click start new button") {
                        beforeEach {
                            viewModel.didClickStartNewButton()
                        }
                        
                        it("screen should show SetTimeView") {
                            expect(viewModel.isTimerViewVisible).to(beTrue())
                        }
                    }
                }
            }
            
            context("click activity button, and the timer has started") {
                beforeEach {
                    viewModel.isStarted = true
                    viewModel.didClickActivityButton()
                }
                
                it("should stop timer and reset") {
                    expect(viewModel.isStarted).to(beFalse())
                    expect(viewModel.timerStringValue).to(equal("00:00"))
                }
            }
        }
    }
}

