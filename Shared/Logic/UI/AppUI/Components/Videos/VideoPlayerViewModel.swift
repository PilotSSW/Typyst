//
//  VideoPlayerViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/8/21.
//

import AVFoundation
import AVKit
import Foundation
import struct SwiftUI.CGSize

class VideoPlayerViewModel: Loggable {
    enum VideoType {
        case accessibility

        func getVideoFileProperties() -> VideoFile? {
            switch self {
                case .accessibility: return VideoFile(url: "Media/AddMacOSAccessibility",
                                                  fileType: "mov",
                                                  dimensions: CGSize(width: 667, height: 590),
                                                  shouldLoop: true,
                                                  shouldAutoPlay: true)
            }
        }
    }
    var videoType: VideoType = .accessibility

    private var playerLooper: AVPlayerLooper? = nil

    func getAVPlayer() -> AVPlayer? {
        if let fileProperties = videoType.getVideoFileProperties(),
           let videoUrl = Bundle.main.url(forResource: fileProperties.url,
                                          withExtension: fileProperties.fileType) {
            let item = AVPlayerItem(url: videoUrl)
            var player: AVPlayer

            if fileProperties.shouldLoop {
                player = AVQueuePlayer(playerItem: item)
                playerLooper = AVPlayerLooper(player: player as! AVQueuePlayer,
                                              templateItem: item)
            }
            else {
                player = AVPlayer(playerItem: item)
            }

            player.isMuted = true
            player.actionAtItemEnd = .none

            return player
        }
        else {
            let _ = logEvent(.warning, "Accessibility video file not found!")
        }

        return nil
    }
}

struct VideoFile {
    let url: String
    let fileType: String
    let dimensions: CGSize
    let shouldLoop: Bool
    let shouldAutoPlay: Bool
}
