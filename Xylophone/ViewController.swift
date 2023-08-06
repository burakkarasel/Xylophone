//
//  ViewController.swift
//  Xylophone
//
//  Created by Burak Karasel on 6.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cTapped(_ sender: UIButton) {
        playSound(fileName: "C")
    }
    
    @IBAction func dTapped(_ sender: UIButton) {
        playSound(fileName: "D")
    }
    
    @IBAction func eTapped(_ sender: UIButton) {
        playSound(fileName: "E")
    }
    
    @IBAction func fTapped(_ sender: UIButton) {
        playSound(fileName: "F")
    }
    
    @IBAction func gTapped(_ sender: UIButton) {
        playSound(fileName: "G")
    }
    
    @IBAction func aTapped(_ sender: UIButton) {
        playSound(fileName: "A")
    }
    
    @IBAction func bTapped(_ sender: UIButton) {
        playSound(fileName: "B")
    }
    
    func playSound(fileName : String) {
        // Build the url for the sound file
        guard let url = Bundle.main.url(forResource: "Sounds/\(fileName)", withExtension: "wav") else {return}
        do {
            // we use the singleton AVAudioSession instance through our app lifesycle
            // here we set the session as playback so we can still play sounds while iOS app is in silence mode
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            // here we activate the AVAudioSession with categories we specified by setting it true
            try AVAudioSession.sharedInstance().setActive(true)
            // set AVAudioPlayer with the url which we built
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            // play the sound
            player?.play()
        }catch let error {
            // check for error
            print(error.localizedDescription)
        }
    }
}

