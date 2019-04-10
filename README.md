# CoreML and Vision object detection with a pretrained deep learning SSD model

![platform-ios](https://img.shields.io/badge/platform-ios-Blue.svg)
![swift-version](https://img.shields.io/badge/swift-4.2-Orange.svg)
![lisence](https://img.shields.io/badge/license-MIT-Lightgrey.svg)

 This project shows how to use CoreML and Vision with a pretrained deep learning SSD model. There are many variations of SSD. The one we’re going to use is MobileNetV2 as the backbone this model also has separable convolutions for the SSD layers, also known as SSDLite.
 This app can find the locations of several different types of objects in the image. The detections are described by bounding boxes, and for each bounding box the model also predicts a class.
___

## Side Note
* Currently, I do not have an iPhone, so I'm unable to test the app on a physical device. I apologize in advance for maybe possible bugs.

   Kind regards,

   Ilija 🖖 😄
___

## Requirements
- Physical device! Because the simulator does not have a camera
- Swift 4.2
- Xcode 9.2+
- iOS 11.0+

___
## Auto genereted model helper class
Once the model is imported the compiler generates a model helper class on build path automatically.Then we can access the model through model helper class by creating an instance.

![alt text](https://github.com/IlijaMihajlovic/CoreML-and-Vison-with-an-pretrained-deep-learning-SSD-model/blob/master/CoreML%20And%20Vison%20Real%20Time%20Object%20Detction/Images/auto%20generated%20core%20ml%20class%20.png)
___

## Model Metadata
Here we can see the inputs the model aspects and the outputs it generates, as well as auto genereted model helper class.

![alt text](https://github.com/IlijaMihajlovic/CoreML-and-Vison-with-an-pretrained-deep-learning-SSD-model/blob/master/CoreML%20And%20Vison%20Real%20Time%20Object%20Detction/Images/machine%20learing%20model.png)

___

## Camera Usage Description
Add permission in info.plist for device's camera access

![alt text](https://github.com/IlijaMihajlovic/CoreML-and-Vison-with-an-pretrained-deep-learning-SSD-model/blob/master/CoreML%20And%20Vison%20Real%20Time%20Object%20Detction/Images/camera%20usage%20description.png)

Or you can open the info.plist file as raw XML and add the following code:

```swift
<key>NSCameraUsageDescription</key>
      <string>Camera Needed For Object Detection And Classification</string>

```
___

## Import COCO Dataset Labels

![alt text](https://github.com/IlijaMihajlovic/CoreML-and-Vison-with-an-pretrained-deep-learning-SSD-model/blob/master/CoreML%20And%20Vison%20Real%20Time%20Object%20Detction/Images/coco%20labels%20file.png)

___

## License
```
MIT License

Copyright (c) 2019 Ilija Mihajlovic

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
