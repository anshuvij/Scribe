//
//  ViewController.swift
//  Scribe
//
//  Created by Anshu Vij on 01/06/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var transcriptionTextView: UITextView!
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    var audioPlayer : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySpinner.isHidden = true
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    func requestSpeechAuth()
    {
        SFSpeechRecognizer.requestAuthorization(
            {
                authstatus in
                if authstatus == SFSpeechRecognizerAuthorizationStatus.authorized
                {
                    if let path = Bundle.main.url(forResource: "test", withExtension: "m4a")
                    {
                        do {
                            let sound = try AVAudioPlayer(contentsOf: path)
                            self.audioPlayer = sound
                            self.audioPlayer.delegate = self
                            sound.play()
                        } catch
                        {
                            print("Error")
                        }
                        
                        let recognizer = SFSpeechRecognizer()
                        let request = SFSpeechURLRecognitionRequest(url: path)
                        recognizer?.recognitionTask(with: request)
                        {
                            (result, error) in
                            if let error = error
                            {
                                print("there was an error : \(error)")
                            }
                            else
                            {
                                self.transcriptionTextView.text = result?.bestTranscription.formattedString 
                            }
                        }
                    }
                }
        })
    }
    

    @IBAction func playButtonPressed(_ sender: Any) {
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
}

