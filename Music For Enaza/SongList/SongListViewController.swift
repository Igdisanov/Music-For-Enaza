//
//  SongListViewController.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

class SongListViewController: UIViewController {
    
    private lazy var albomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor(named: "backgroundColor")
        imageView.image = UIImage(systemName: "music.note.house.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(named: "backgroundColor")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var songTableView = UITableView(frame: .zero, style: .plain)
    private let output: SongListViewOutput
    
    init(output: SongListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
//        setupContentScrollView()
//        setupContentView()
        setupAlbomImageView()
        setupSongTableView()
//        contentScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentView.frame.height + self.songTableView.frame.height)
        
    }
    
    private func setupContentScrollView() {
        self.view.addSubview(contentScrollView)
        contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func setupContentView() {
        self.contentScrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
    }
    
    private func setupAlbomImageView() {
        self.view.addSubview(albomImageView)
        albomImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albomImageView.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: 8).isActive = true
        albomImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.5).isActive = true
        albomImageView.heightAnchor.constraint(equalTo: albomImageView.widthAnchor).isActive = true
    }
    
    private func setupSongTableView() {
        songTableView.translatesAutoresizingMaskIntoConstraints = false
        songTableView.backgroundColor = UIColor(named: "backgroundColor")
        self.view.addSubview(songTableView)
        songTableView.topAnchor.constraint(equalTo: albomImageView.bottomAnchor, constant: 16).isActive = true
        songTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        songTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        songTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songTableView.separatorStyle = .none
        songTableView.register(SongViewCell.self, forCellReuseIdentifier: SongViewCell.className)
        songTableView.delegate = self
        songTableView.dataSource = self
    }
    
}

extension SongListViewController: SongListViewInput {
    
}

extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongViewCell.className, for: indexPath) as! SongViewCell
        cell.configure()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Топ Узбекистан"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicPlayerVC = MusicPlayerContainer.assemble(with: MusicPlayerContext()).viewController
        self.navigationController?.pushViewController(musicPlayerVC, animated: true)
    }
    
}

