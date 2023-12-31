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
   
    
    @IBAction func keyPressed(_ sender: UIButton) {
        // gather the pressed button's title value
        guard let pressed = sender.titleLabel?.text else {return}
        
        // here we call the playSound function with pressed key
        playSound(fileName: pressed)
        
        // on click we change the opacity of button in 0.2 sec
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 0.5
        }
        
        // here we put an async callback to restore opacity back to normal after 0.2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
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

