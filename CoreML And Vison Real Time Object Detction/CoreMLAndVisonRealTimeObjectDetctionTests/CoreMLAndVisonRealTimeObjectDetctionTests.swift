//
//  CoreMLAndVisonRealTimeObjectDetctionTests.swift
//  CoreMLAndVisonRealTimeObjectDetction
//
//  Created by Ilija Mihajlovic on 2/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import XCTest
import Vision

class CoreMLAndVisonRealTimeObjectDetctionTests: XCTestCase {

    // MARK: - Vision Properties
    var vnRequest: VNCoreMLRequest?
    var vnModel: VNCoreMLModel?
    
    var ssdRequest: VNCoreMLRequest?
    var ssdModel: VNCoreMLModel?
    
    let image = UIImage(named: "multicolor background")
    var pixelBuffer: CVPixelBuffer?
    
    override func setUp() {
        ssdModel = try? VNCoreMLModel(for: MobileNetV2_SSDLite().model)
        if let visionModel = ssdModel {
            ssdRequest = VNCoreMLRequest(model: visionModel, completionHandler: nil)
        }
        ssdRequest?.imageCropAndScaleOption = .scaleFill
        
        // image configuration
        pixelBuffer = image?.pixelBufferFromImage()
    }
    
  

    func testPerformanceSSDMobileNetV1Model() {
        guard let pixelBuffer = pixelBuffer,
            let request = ssdRequest else {
                fatalError()
        }
        self.measure {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
            try? handler.perform([request])
        }
    }

}
