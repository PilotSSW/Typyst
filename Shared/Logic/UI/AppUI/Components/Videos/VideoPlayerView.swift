//
//  VideoPlayerView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/8/21.
//
import AVKit
import SwiftUI

struct VideoPlayerView: View {
    private(set) var viewModel: VideoPlayerViewModel

    var body: some View {
        let player = viewModel.getAVPlayer()
        let fileProperties = viewModel.videoType.getVideoFileProperties()

        VideoPlayer(player: player)
            .frame(width: fileProperties?.dimensions.width ?? 620,
                   height: fileProperties?.dimensions.height ?? 480)
            .onAppear() {
                if let fileProperties = fileProperties, fileProperties.shouldAutoPlay {
                    player?.play()
                }
            }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(viewModel: VideoPlayerViewModel())
    }
}
