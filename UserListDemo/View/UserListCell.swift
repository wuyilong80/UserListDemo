//
//  UserListCell.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit

class UserListCell: UICollectionViewCell {

    static let reuseIdentifier = "UserListCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [userNameLabel, userStatusLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var userAvatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 30
        return imgView
    }()
    
    lazy var userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var userStatusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.text = "STAFF"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.layer.cornerRadius = 11.25
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        
        contentView.addShadow()
        
        contentView.addSubview(userAvatarImgView)
        userAvatarImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(userAvatarImgView.snp.height)
        }
        userAvatarImgView.backgroundColor = .red
        
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(userAvatarImgView.snp.trailing).offset(10)
            make.top.bottom.equalTo(userAvatarImgView).inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        
        userStatusLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
}
