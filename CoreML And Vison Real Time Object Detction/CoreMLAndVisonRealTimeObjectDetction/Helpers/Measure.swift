//
//  Measure.swift
//  CoreMLAndVisonRealTimeObjectDetction
//
//  Created by Ilija Mihajlovic on 2/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

protocol MeasureDelegate {
    func updateMeasure(inferenceTime: Double, executionTime: Double, fps: Int)
}
// Performance Measurement
class Measure {
    
    var delegate: MeasureDelegate?
    
    var index: Int = -1
    var measurements: [Dictionary<String, Double>]
    
    init() {
        let measurement = ["start": CACurrentMediaTime(),"end": CACurrentMediaTime()]
        measurements = Array<Dictionary<String, Double>>(repeating: measurement, count: 30)
    }
    
    func recordStart() {
        index += 1
        index %= 30
        measurements[index] = [:]
        
        labeling(for: index, with: "start")
    }
    
    func recordStop() {
        labeling(for: index, with: "end")
        
        let beforeMeasurement = getBeforeMeasurment(for: index)
        let currentMeasurement = measurements[index]
        if let startTime = currentMeasurement["start"],
            let endInferenceTime = currentMeasurement["endInference"],
            let endTime = currentMeasurement["end"],
            let beforeStartTime = beforeMeasurement["start"] {
            delegate?.updateMeasure(inferenceTime: endInferenceTime - startTime,executionTime: endTime - startTime, fps: Int(1/(startTime - beforeStartTime)))
        }
        
    }
    
    func labelingWith(with msg: String? = "") {
        labeling(for: index, with: msg)
    }
    
    private func labeling(for index: Int, with msg: String? = "") {
        if let message = msg {
            measurements[index][message] = CACurrentMediaTime()
        }
    }
    
    private func getBeforeMeasurment(for index: Int) -> Dictionary<String, Double> {
        return measurements[(index + 30 - 1) % 30]
    }
    
}



