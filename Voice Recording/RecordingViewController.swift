//
//  RecordingViewController.swift
//  Voice Recording
//
//  Created by Apple on 16/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var recordobutton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    func setupRecorder(){
        do {
            // Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            
            // create URL for audio file
            
            let basepath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basepath,"audio.mp3"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            
            // audio recorder settings
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = kAudioFileMP3Type as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            // audio recoder file saving loaction
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings:settings )
            audioRecorder?.prepareToRecord()
            
        }catch _ as NSError{
            
        }
    }
    @IBAction func recordbutton(_ sender: Any) {
        if audioRecorder!.isRecording{
            // Stop the Recording
            audioRecorder?.stop()
            //Change the Button to Record
            recordobutton.setTitle("Record", for: .normal)
        }else{
            // Start the Recording
            audioRecorder?.record()
            
            //Change the Button to Start
            recordobutton.setTitle("Stop", for: .normal)
            
        }
    }
    
    @IBAction func playbutton(_ sender: Any) {
    }
    
    @IBAction func savebutton(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
