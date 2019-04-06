//
//  File.swift
//  CoreMLAndVisonRealTimeObjectDetction
//
//  Created by Ilija Mihajlovic on 4/6/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import CoreMedia

//VideoCaptureDelegate
extension MainVC: VideoCaptureDelegate {
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        // the captured image from camera is contained on pixelBuffer
        if let pixelBuffer = pixelBuffer {
            
            self.measureInstance.recordStart()
            
            self.predictUsingVision(pixelBuffer: pixelBuffer)
        }
    }
}
