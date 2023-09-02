//
//  MusicPlayerViewController.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 31.08.2023.
//

import UIKit
import MediaPlayer

class MusicPlayerViewController: UIViewController {
    
    private lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "backgroundColor")
        imageView.image = UIImage(systemName: "music.note.house.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var plaingButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(playingAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = UIColor(named: "buttonColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextSongButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "buttonColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var previousSongButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(previousSong), for: .touchUpInside)
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "buttonColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var songSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(rewindSong), for: .allEvents)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var songNameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private var player: AVPlayer!
    private let otput: MusicPlayerViewOutput
    
    init(uotput: MusicPlayerViewOutput) {
        self.otput = uotput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otput.requestTrack()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    
    @objc func playingAction() {
        if  player.timeControlStatus == .paused {
            player.play()
            plaingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            player.pause()
            plaingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func rewindSong() {
        player.seek(to: CMTime(seconds: Double(songSlider.value), preferredTimescale: 1000))
    }
    
    @objc func nextSong() {
        self.previousSongButton.tintColor = UIColor(named: "buttonColor")
        self.otput.requestNextSong()
        player.play()
    }
    
    @objc func previousSong() {
        self.nextSongButton.tintColor = UIColor(named: "buttonColor")
        self.otput.requestpreviousSong()
        player.play()
    }
    
    private func playMusic(song: String) {
        guard let song = Bundle.main.path(forResource: song, ofType: "mp3") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: song))
        
        guard let durationSong = player.currentItem?.asset.duration.seconds else { return }
        songSlider.maximumValue = Float(durationSong)
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { [weak self] (time) in
            self?.songSlider.value = Float(time.seconds)
            if self?.songSlider.value ==  self?.songSlider.maximumValue {
                self?.nextSong()
            }
        }
    }
    
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        setupSongImageView()
        setupPlaingButton()
        setupNexSongButton()
        setupPreviousSongButton()
        setupSongSlider()
        setupSongNameLable()
    }
    
    private func setupSongImageView() {
        self.view.addSubview(songImageView)
        songImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        songImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        songImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.5).isActive = true
        songImageView.heightAnchor.constraint(equalTo: songImageView.widthAnchor).isActive = true
    }
    
    private func setupPlaingButton() {
        self.view.addSubview(plaingButton)
        plaingButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        plaingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        plaingButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        plaingButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        plaingButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        plaingButton.imageView?.topAnchor.constraint(equalTo: plaingButton.topAnchor).isActive = true
        plaingButton.imageView?.bottomAnchor.constraint(equalTo: plaingButton.bottomAnchor).isActive = true
        plaingButton.imageView?.leadingAnchor.constraint(equalTo: plaingButton.leadingAnchor).isActive = true
        plaingButton.imageView?.trailingAnchor.constraint(equalTo: plaingButton.trailingAnchor).isActive = true
    }
    
    private func setupNexSongButton() {
        self.view.addSubview(nextSongButton)
        nextSongButton.leadingAnchor.constraint(equalTo: plaingButton.trailingAnchor, constant: 24).isActive = true
        nextSongButton.centerYAnchor.constraint(equalTo: plaingButton.centerYAnchor).isActive = true
        nextSongButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextSongButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nextSongButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        nextSongButton.imageView?.topAnchor.constraint(equalTo: nextSongButton.topAnchor).isActive = true
        nextSongButton.imageView?.bottomAnchor.constraint(equalTo: nextSongButton.bottomAnchor).isActive = true
        nextSongButton.imageView?.leadingAnchor.constraint(equalTo: nextSongButton.leadingAnchor).isActive = true
        nextSongButton.imageView?.trailingAnchor.constraint(equalTo: nextSongButton.trailingAnchor).isActive = true
    }
    
    private func setupPreviousSongButton() {
        self.view.addSubview(previousSongButton)
        previousSongButton.trailingAnchor.constraint(equalTo: plaingButton.leadingAnchor, constant: -24).isActive = true
        previousSongButton.centerYAnchor.constraint(equalTo: plaingButton.centerYAnchor).isActive = true
        previousSongButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        previousSongButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        previousSongButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        previousSongButton.imageView?.topAnchor.constraint(equalTo: previousSongButton.topAnchor).isActive = true
        previousSongButton.imageView?.bottomAnchor.constraint(equalTo: previousSongButton.bottomAnchor).isActive = true
        previousSongButton.imageView?.leadingAnchor.constraint(equalTo: previousSongButton.leadingAnchor).isActive = true
        previousSongButton.imageView?.trailingAnchor.constraint(equalTo: previousSongButton.trailingAnchor).isActive = true
    }
    
    private func setupSongSlider() {
        self.view.addSubview(songSlider)
        songSlider.bottomAnchor.constraint(equalTo: plaingButton.topAnchor, constant: -32).isActive = true
        songSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        songSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupSongNameLable() {
        self.view.addSubview(songNameLable)
        songNameLable.bottomAnchor.constraint(equalTo: songSlider.topAnchor, constant: -16).isActive = true
        songNameLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
    }
}

extension MusicPlayerViewController: MusicPlayerViewInput {
    
    func getTrack(location: LocationTrack?, track: Track) {
        guard let song = track.song else {return}
        playMusic(song: song)
        songNameLable.text = track.name
        
        guard let coverUrl = track.coverUrl else {return}
        otput.requestImage(cover: coverUrl)
        
        if location == .first {
            self.previousSongButton.tintColor = .gray
        } else if location == .last {
            self.nextSongButton.tintColor = .gray
        } else {
            self.previousSongButton.tintColor = UIColor(named: "buttonColor")
            self.nextSongButton.tintColor = UIColor(named: "buttonColor")
        }
    }
    
    func getImageData(data: Data?) {
        guard let data = data else {return}
        DispatchQueue.main.async {
            self.songImageView.image = UIImage(data: data)
        }
    }
}
