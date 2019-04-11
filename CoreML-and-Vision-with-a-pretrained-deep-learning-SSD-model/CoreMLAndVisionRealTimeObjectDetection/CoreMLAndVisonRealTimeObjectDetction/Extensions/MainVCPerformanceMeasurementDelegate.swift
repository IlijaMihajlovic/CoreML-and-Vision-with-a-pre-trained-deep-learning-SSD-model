//
//  File.swift
//  CoreMLAndVisonRealTimeObjectDetction
//
//  Created by Ilija Mihajlovic on 4/6/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation

//Performance Measurement Delegate
extension MainVC: MeasureDelegate {
    func updateMeasure(inferenceTime: Double, executionTime: Double, fps: Int) {
        //print(inference, executionTime, fps)
        DispatchQueue.main.async {
            self.inferenceLabel.text = "inference: \(Int(inferenceTime*1000.0)) mm"
            self.etimeLabel.text = "execution: \(Int(executionTime*1000.0)) mm"
            self.fpsLabel.text = "fps: \(fps)"
        }
    }
}
