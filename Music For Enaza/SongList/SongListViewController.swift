//
//  SongListViewController.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

class SongListViewController: UIViewController {
    
    // MARK: - Visual Components
    
    private lazy var albomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "backgroundColor")
        imageView.image = UIImage(systemName: "music.note.house.fill")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private lazy var songTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Private Properties
    
    private let output: SongListViewOutput
    private var collection: Collection?
    
    init(output: SongListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activityIndicator.startAnimating()
        requestData()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupUI()
        print("QQQQQQQQQQQQ")
    }
    
    // MARK: - Private Methods
    
    private func requestData() {
        output.collectionRequest { [weak self] (collection) in
            self?.collection = collection
            self?.output.getImageAlbum { [weak self] (data) in
                guard let data = data else {return}
                DispatchQueue.main.async {
                    self?.albomImageView.image = UIImage(data: data)
                    self?.songTableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func getTrackList() -> [Track] {
        var tracks = [Track]()
        guard let collection = collection else {return []}
        for (_, value) in collection.track {
            tracks.append(value)
        }
        return tracks
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        setupAlbomImageView()
        setupSongTableView()
        setupActivityIndicator()
    }
    
    private func setupAlbomImageView() {
        albomImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(albomImageView)
        albomImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albomImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        albomImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.5).isActive = true
        albomImageView.heightAnchor.constraint(equalTo: albomImageView.widthAnchor).isActive = true
    }
    
    private func setupSongTableView() {
        songTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(songTableView)
        songTableView.backgroundColor = UIColor(named: "backgroundColor")
        songTableView.topAnchor.constraint(equalTo: albomImageView.bottomAnchor, constant: 16).isActive = true
        songTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        songTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        songTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songTableView.separatorStyle = .none
        songTableView.register(SongViewCell.self, forCellReuseIdentifier: SongViewCell.className)
        songTableView.delegate = self
        songTableView.dataSource = self
    }
    
    private func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
}

// MARK: - SongListViewInput

extension SongListViewController: SongListViewInput {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collection?.track.count ??  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongViewCell.className, for: indexPath) as! SongViewCell
        let tracks = getTrackList()
        cell.configure(track: tracks[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.collection?.album.first?.value.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trackList = getTrackList()
        let currentTrack = trackList[indexPath.row]
        self.output.pushViewController(view: self, trackList: trackList, currentTrack: currentTrack)
    }
    
}

