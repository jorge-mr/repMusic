//
//  ViewController.swift
//  repMusic
//
//  Created by Jorge MR on 03/01/18.
//  Copyright © 2018 jorge_a_mtz_r. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volSlider: UISlider!
    var reproductor = AVAudioPlayer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rutaAudio = Bundle.main.path(forResource: "Dreams", ofType: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOf: URL(fileURLWithPath: rutaAudio!))
            timeSlider.maximumValue = Float(reproductor.duration)
        } catch {
            print("ocurrio un error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playMusic(_ sender: UIButton) {
        if reproductor.isPlaying {
            print("ya estaba sonando")
        }else{
            reproductor.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(actualizaTiempo), userInfo: nil, repeats: true)
            print("play")
        }
    }
    
    @IBAction func pauseMusic(_ sender: UIButton) {
        if reproductor.isPlaying {
            reproductor.pause()
            timer.invalidate()
            print("pause")
        }else{
            print("ya estaba en pausa")
        }
    }
    
    @IBAction func stopMusic(_ sender: UIButton) {
            reproductor.stop()
            reproductor.currentTime=0
            timer.invalidate()
            timeSlider.value = 0.0
            print("stop")
    }
    
    @IBAction func changedTimeSlider(_ sender: UISlider) {
        reproductor.currentTime = TimeInterval(timeSlider.value)

    }
    
    @IBAction func changedVolumeSlider(_ sender: UISlider) {
        reproductor.volume = volSlider.value

    }
    
    @objc func actualizaTiempo(){
        timeSlider.value = Float(reproductor.currentTime)
    }
    
}

