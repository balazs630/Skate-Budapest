//
//  VideoView.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 25..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import AVKit

class VideoView: UIView {
    // MARK: Properties
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    public var isLoop = true
    public var videoContentMode = AVLayerVideoGravity.resizeAspectFill

    // MARK: Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Configure player
extension VideoView {
    public func configure(urlString: String) {
        if let url = URL(string: urlString) {
            configure(videoURL: url)
        } else {
            debugPrint("URL cannot be formed from: \(urlString)")
        }
    }

    public func configure(filename: String, type: String = "mp4") {
        if let path = Bundle.main.path(forResource: filename, ofType: type) {
            configure(videoURL: URL(fileURLWithPath: path))
        } else {
            debugPrint("Resource not found: \(filename).\(type)")
        }
    }

    public func configure(videoURL: URL) {
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        playerLayer?.videoGravity = videoContentMode

        guard let playerLayer = playerLayer else {
            debugPrint("Video is not available to play with url: \(videoURL)")
            return
        }

        layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didPlayToEndTime),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
    }
}

// MARK: AVPlayer notifications
extension VideoView {
    @objc private func didPlayToEndTime() {
        if isLoop {
            player?.pause()
            player?.seek(to: .zero)
            player?.play()
        }
    }
}

// MARK: Playback action
extension VideoView {
    public func play() {
        if player?.timeControlStatus != .playing {
            player?.play()
        }
    }

    public func pause() {
        player?.pause()
    }

    public func stop() {
        player?.pause()
        player?.seek(to: .zero)
    }
}
