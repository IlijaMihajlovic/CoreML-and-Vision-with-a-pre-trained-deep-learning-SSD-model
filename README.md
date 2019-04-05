# CoreML and Vison object detection with an pretrained deep learning SSD model

![platform-ios](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![swift-version](https://img.shields.io/badge/swift-4.2-red.svg)
![lisence](https://img.shields.io/badge/license-MIT-black.svg)

 This project shows how to use CoreML and Vison with an pretrained deep learning SSD model. There are many variations of SSD. The one we’re going to use is MobileNet V2 as the backbone this model also has separable convolutions for the SSD layers, also known as SSDLite.
 This app can find the locations of several different types of objects in the image. The detections are described by bounding boxes, and for each bounding box the model also predicts a class.
 
 
 

## One Last Note
* Currently, I do not have an iPhone, so I'm unable to test the app on a physical device. I apologize in advance for maybe possible bugs.

   Kind regards,

   Ilija 🖖 😄
___

## Requirements
- Physical device! Because the simulator does not have a camera
- Swift 4.2
- Xcode 9.2+
- iOS 11.0+

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
