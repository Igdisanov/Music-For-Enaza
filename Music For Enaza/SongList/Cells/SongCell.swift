//
//  SongCell.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

class SongViewCell: UITableViewCell {
    
    // MARK: - Visual Components
    
    private lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var songNameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.songImageView.image = nil
        self.songNameLable.text = nil
    }
    
    public func configure() {
        self.songNameLable.text = "Vadim"
        self.songImageView.image = UIImage(systemName: "music.note.house.fill")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        setupSongImageView()
        setupSongNameLable()
    }
    
    private func setupSongImageView() {
        contentView.addSubview(songImageView)
        songImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        songImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    private func setupSongNameLable() {
        contentView.addSubview(songNameLable)
        songNameLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        songNameLable.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8).isActive = true
    }
    
    static var className: String {
        return String(describing: self)
    }
    
}
