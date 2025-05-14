//
//  SoundEffectManager.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-14.
//

import Foundation
import AVKit
import AVFAudio

final class SoundEffectManager {
    static let shared = SoundEffectManager()
    
    init() {
        setupAudioSession()
    }
    
    private var player: AVAudioPlayer? = nil
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    func playSoundEffect(_ effect: SoundEffect) throws {
        guard let url = Bundle.main.url(forResource: effect.rawValue, withExtension: "wav") else {
            throw SoundEffectManagerError.couldNotFindFile
        }
        
        do {
            // Ensure audio session is active
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
            self.player?.play()
        } catch {
            print("Playback error: \(error.localizedDescription)")
            throw SoundEffectManagerError.couldNotCreateAudioPlayer
        }
    }
    
    deinit {
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}

enum SoundEffect: String, Identifiable, Codable, CaseIterable {
    case clapping = "Clapping"
    case fireworks = "Fireworks"
    case happyBirthday = "Happy Birthday"
    
    var id: Self { self }
}

enum SoundEffectManagerError: LocalizedError {
    case couldNotFindFile, couldNotCreateAudioPlayer, unknownError
    
    var localizedDescription: String {
        switch self {
        case .couldNotFindFile:
            return "Could not find sound effect file."
        case .couldNotCreateAudioPlayer:
            return "Could not create AVAudioPlayer from the URL."
        case .unknownError:
            return "An unknown error has occured."
        }
    }
}
