//
//  InterfaceController.swift
//  LottieTutorialWatchOS WatchKit Extension
//
//  Created by Evandro Harrison Hoffmann on 11/08/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import WatchKit
import Foundation
import SDWebImageLottieCoder

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var imageView: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadAnimation(url: URL(string: "https://assets8.lottiefiles.com/packages/lf20_Zz37yH.json")!)
    }
    
    // MARK: - Animation
    
    private var coder: SDImageLottieCoder?
    private var animationTimer: Timer?
    private var currentFrame: UInt = 0
    private var playing: Bool = false
    private var speed: Double = 1.0
    
    /// Loads animation data
    /// - Parameter url: url of animation JSON
    private func loadAnimation(url: URL) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.setupAnimation(with: data)
            }
        }
        dataTask.resume()
    }
    
    /// Decodify animation with given data
    /// - Parameter data: data of animation
    private func setupAnimation(with data: Data) {
        coder = SDImageLottieCoder(animatedImageData: data, options: [SDImageCoderOption.decodeLottieResourcePath: Bundle.main.resourcePath!])
        
        // resets to first frame
        currentFrame = 0
        setImage(frame: currentFrame)
        
        play()
    }
    
    /// Set current animation
    /// - Parameter frame: Set image for given frame
    private func setImage(frame: UInt) {
        guard let coder = coder else { return }
        imageView.setImage(coder.animatedImageFrame(at: frame))
    }
    
    /// Replace current frame with next one
    private func nextFrame() {
        guard let coder = coder else { return }

        currentFrame += 1
        // make sure that current frame is within frame count
        // if reaches the end, we set it back to 0 so it loops
        if currentFrame >= coder.animatedImageFrameCount {
            currentFrame = 0
        }
        
        setImage(frame: currentFrame)
    }
    
    /// Start playing animation
    private func play() {
        playing = true

        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.05/speed, repeats: true, block: { (timer) in
            guard self.playing else {
                timer.invalidate()
                return
            }
            self.nextFrame()
        })
    }
    
    /// Pauses animation
    private func pause() {
        playing = false
        animationTimer?.invalidate()
    }
}
