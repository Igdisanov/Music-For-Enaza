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
    
    private lazy var songTableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.separatorStyle = .none
        tableView.register(SongViewCell.self, forCellReuseIdentifier: SongViewCell.className)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private let output: SongListViewOutput
    private var collection: Collection?
    
    // MARK: - Constraints
    
    private var albomImageViewTopAnchor: NSLayoutConstraint?
    private var albomImageViewcenterXAnchor: NSLayoutConstraint?
    private var albomImageViewcenterYAnchor: NSLayoutConstraint?
    private var albomImageViewLeadingAnchor: NSLayoutConstraint?
    private var albomImageViewWidthAnchor: NSLayoutConstraint?
    private var albomImageViewHeightAnchor: NSLayoutConstraint?
    
    private var songTableViewViewTopAnchor: NSLayoutConstraint?
    private var songTableViewViewLeadingAnchor: NSLayoutConstraint?
    private var songTableViewViewTrailingAnchor: NSLayoutConstraint?
    private var songTableViewViewBottomAnchor: NSLayoutConstraint?
    
    // MARK: - Initializers
    
    init(output: SongListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
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
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let orientation = windowScene.interfaceOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            coordinator.animate { [weak self] _ in
                guard let self = self else {return}
                
                self.albomImageViewTopAnchor?.isActive = false
                self.albomImageViewcenterXAnchor?.isActive = false
                self.songTableViewViewTopAnchor?.isActive = false
                self.songTableViewViewLeadingAnchor?.isActive = false
                
                self.albomImageViewcenterYAnchor?.isActive = true
                self.albomImageViewLeadingAnchor?.isActive = true
                
                self.songTableViewViewTopAnchor = self.songTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16)
                self.songTableViewViewLeadingAnchor = self.songTableView.leadingAnchor.constraint(equalTo: self.albomImageView.trailingAnchor)
                
                self.songTableViewViewTopAnchor?.isActive = true
                self.songTableViewViewLeadingAnchor?.isActive = true
            }
            
        } else if orientation == .portrait {
            
            coordinator.animate { [weak self] _ in
                guard let self = self else {return}
                
                self.albomImageViewcenterYAnchor?.isActive = false
                self.albomImageViewLeadingAnchor?.isActive = false
                
                self.songTableViewViewTopAnchor?.isActive = false
                self.songTableViewViewLeadingAnchor?.isActive = false
                
                self.albomImageViewTopAnchor?.isActive = true
                self.albomImageViewcenterXAnchor?.isActive = true
                
                self.songTableViewViewTopAnchor = self.songTableView.topAnchor.constraint(equalTo: self.albomImageView.bottomAnchor, constant: 16)
                self.songTableViewViewLeadingAnchor = self.songTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
                
                self.songTableViewViewTopAnchor?.isActive = true
                self.songTableViewViewLeadingAnchor?.isActive = true
                
                
            }
        }
        
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
        albomImageViewTopAnchor = albomImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8)
        albomImageViewcenterXAnchor = albomImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        albomImageViewHeightAnchor = albomImageView.heightAnchor.constraint(equalToConstant: 250)
        albomImageViewWidthAnchor = albomImageView.widthAnchor.constraint(equalToConstant: 250)
        albomImageViewLeadingAnchor = albomImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        albomImageViewcenterYAnchor = albomImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        albomImageViewTopAnchor?.isActive = true
        albomImageViewcenterXAnchor?.isActive = true
        albomImageViewWidthAnchor?.isActive = true
        albomImageViewHeightAnchor?.isActive = true
    }
    
    private func setupSongTableView() {
        songTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(songTableView)
        songTableViewViewTopAnchor = songTableView.topAnchor.constraint(equalTo: albomImageView.bottomAnchor, constant: 16)
        songTableViewViewLeadingAnchor = songTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        songTableViewViewTrailingAnchor = songTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        songTableViewViewBottomAnchor = songTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        songTableViewViewTopAnchor?.isActive = true
        songTableViewViewLeadingAnchor?.isActive = true
        songTableViewViewTrailingAnchor?.isActive = true
        songTableViewViewBottomAnchor?.isActive = true
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

