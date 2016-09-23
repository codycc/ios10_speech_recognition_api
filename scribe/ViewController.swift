//
//  ViewController.swift
//  scribe
//
//  Created by Cody Condon on 2016-09-23.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                //path to the audio file
                if let path = Bundle.main.url(forResource: "bothering", withExtension: "mp3") {
                    // start playing the music
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("there was an error \(error)")
                        }else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
            }
        }
    }

    @IBAction func playBtnPressed(_ sender: AnyObject) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
        
    }
   


}

