//
//  MainVC
//  CoreMLAndVisonRealTimeObjectDetction
//
//  Created by Ilija Mihajlovic on 2/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import CoreMedia
import Vision

class MainVC: UIViewController {
    
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var boxesView: DrawBoundingBox!
    @IBOutlet weak var labelsTableView: UITableView!
    
    @IBOutlet weak var inferenceLabel: UILabel!
    @IBOutlet weak var etimeLabel: UILabel!
    @IBOutlet weak var fpsLabel: UILabel!
    
    // MARK - Core ML model
    typealias ClassificationModel = MobileNetV2_SSDLite
    
    // MARK: - Vision Properties
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    
    // MARK: - AV Property
    var videoCapture: VideoCapture!
    let semaphore = DispatchSemaphore(value: 1)
    var lastExecution = Date()
    
    // MARK: - TableView Data
    var predictions: [VNRecognizedObjectObservation] = []
    
    // MARK - Performance Measurement Property
     let measureInstance = Measure()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModel()
        setUpCamera()
        
        measureInstance.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.videoCapture.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoCapture.stop()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resizePreviewLayer()
    }
    
    // MARK: - Setup Core ML
    fileprivate func setUpModel() {
        if let visionModel = try? VNCoreMLModel(for: ClassificationModel().model) {
            self.visionModel = visionModel
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
            request?.imageCropAndScaleOption = .scaleFill
        } else {
            fatalError("Error: could not create model")
            
        }
    }
    
    
    func predictUsingVision(pixelBuffer: CVPixelBuffer) {
        guard let request = request else { fatalError() }
        // vision framework configures the input size of image following our model's input configuration automatically
        self.semaphore.wait()
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    // MARK: - Poseprocessing
   fileprivate func visionRequestDidComplete(request: VNRequest, error: Error?) {
        self.measureInstance.labelingWith(with: "endInference")
        
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
            
            self.predictions = predictions
            DispatchQueue.main.async {
                self.boxesView.predictedObjects = predictions
                self.labelsTableView.reloadData()
                self.measureInstance.recordStop()
            }
        } else {
            
            self.measureInstance.recordStop()
        }
        self.semaphore.signal()
    }
    
    
    // MARK: - SetUp Video
    fileprivate func setUpCamera() {
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        videoCapture.desiredFrameRate = 30
        videoCapture.setUp(sessionPreset: .vga640x480) { success in
            
            if success {
                // add preview view on the layer
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.resizePreviewLayer()
                }
                
                // start video preview when setup is done
                self.videoCapture.start()
            }
        }
    }
    
    
    fileprivate func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
}
