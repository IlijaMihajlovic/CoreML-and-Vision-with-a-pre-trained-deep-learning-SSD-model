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
    private let measureInstance = Measure()
    
    
    
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
    func visionRequestDidComplete(request: VNRequest, error: Error?) {
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
    
    
    fileprivate  func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
}



//MARK: - Extensions

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


//TableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") else {
            return UITableViewCell()
        }
        
        let rectString = predictions[indexPath.row].boundingBox.toString(digit: 2)
        let confidence = predictions[indexPath.row].labels.first?.confidence ?? -1
        let confidenceString = String(format: "%.3f", confidence/*Math.sigmoid(confidence)*/)
        
        cell.textLabel?.text = predictions[indexPath.row].label ?? "N/A"
        cell.detailTextLabel?.text = "\(rectString), \(confidenceString)"
        return cell
    }
}
