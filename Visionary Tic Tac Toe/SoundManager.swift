//
//  SoundManager.swift
//  Visionary Tic Tac Toe
//
//  Created by Tilak Shakya on 14/02/24.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    func playSound(named name: String, ofType type: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
    
}
