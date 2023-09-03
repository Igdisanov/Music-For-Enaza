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
    
    private var albomImageViewTopAnchor: NSLayoutConstraint?
    private var albomImageViewLeadingAnchor: NSLayoutConstraint?
    private var albomImageViewTrailingAnchor: NSLayoutConstraint?
    private var albomImageViewBottomAnchor: NSLayoutConstraint?
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
            
            UIView.animate(withDuration: 5) {
                
                self.songTableViewViewTopAnchor?.isActive = false
                self.songTableViewViewLeadingAnchor?.isActive = false
                self.songTableViewViewTrailingAnchor?.isActive = false
                self.songTableViewViewBottomAnchor?.isActive = false
                self.albomImageViewTopAnchor?.isActive = false
                self.albomImageViewLeadingAnchor?.isActive = false
                self.albomImageViewTrailingAnchor?.isActive = false
                self.albomImageViewHeightAnchor?.isActive = false
                
                self.albomImageViewTopAnchor?.constant = 64
                self.albomImageViewBottomAnchor = self.albomImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -64)
                self.albomImageViewLeadingAnchor?.constant = 16
                self.albomImageViewWidthAnchor = self.albomImageView.widthAnchor.constraint(equalTo: self.albomImageView.heightAnchor)

                self.songTableViewViewTopAnchor = self.songTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
                self.songTableViewViewLeadingAnchor = self.songTableView.leadingAnchor.constraint(equalTo: self.albomImageView.trailingAnchor)
                
                self.albomImageViewBottomAnchor?.isActive = true
                self.albomImageViewWidthAnchor?.isActive = true
                self.albomImageViewTopAnchor?.isActive = true
                self.albomImageViewLeadingAnchor?.isActive = true
                self.songTableViewViewTopAnchor?.isActive = true
                self.songTableViewViewLeadingAnchor?.isActive = true
                self.songTableViewViewTrailingAnchor?.isActive = true
                self.songTableViewViewBottomAnchor?.isActive = true
                
                self.view.layoutIfNeeded()
            }
            
        } else if orientation == .portrait {
            
            UIView.animate(withDuration: 5) {
                
                self.albomImageViewBottomAnchor?.isActive = false
                self.albomImageViewWidthAnchor?.isActive = false
                self.albomImageViewTopAnchor?.isActive = false
                self.albomImageViewLeadingAnchor?.isActive = false
                self.songTableViewViewTopAnchor?.isActive = false
                self.songTableViewViewLeadingAnchor?.isActive = false
                self.songTableViewViewTrailingAnchor?.isActive = false
                self.songTableViewViewBottomAnchor?.isActive = false
                
                self.albomImageViewTopAnchor?.constant = 8
                self.albomImageViewLeadingAnchor?.constant = 64
                self.albomImageViewTrailingAnchor = self.albomImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64)
//                self.albomImageViewHeightAnchor = self.albomImageView.heightAnchor.constraint(equalToConstant: 250)
                
                self.songTableViewViewTopAnchor = self.songTableView.topAnchor.constraint(equalTo: self.albomImageView.bottomAnchor, constant: 16)
                self.songTableViewViewLeadingAnchor = self.songTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
                
                self.albomImageViewTopAnchor?.isActive = true
                self.albomImageViewLeadingAnchor?.isActive = true
                self.albomImageViewTrailingAnchor?.isActive = true
                self.albomImageViewHeightAnchor?.isActive = true
                self.songTableViewViewTopAnchor?.isActive = true
                self.songTableViewViewLeadingAnchor?.isActive = true
                self.songTableViewViewTrailingAnchor?.isActive = true
                self.songTableViewViewBottomAnchor?.isActive = true
                
                self.view.layoutIfNeeded()
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
        albomImageViewLeadingAnchor = albomImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64)
        albomImageViewTrailingAnchor = albomImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64)
        albomImageViewHeightAnchor = albomImageView.heightAnchor.constraint(equalTo: albomImageView.widthAnchor)
        albomImageViewTopAnchor?.isActive = true
        albomImageViewLeadingAnchor?.isActive = true
        albomImageViewTrailingAnchor?.isActive = true
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
        
        songTableView.backgroundColor = UIColor(named: "backgroundColor")
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

