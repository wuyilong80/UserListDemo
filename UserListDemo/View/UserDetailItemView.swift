//
//  UserDetailItemView.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

class UserDetailItemView: UIView {
        
    lazy var iconImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .red
        return imgView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [itemTitleLabel, linkButton, statusLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var itemTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var linkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.text = "STAFF"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.layer.cornerRadius = 11.25
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
    
    private var linkUrl: URL?
    
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(iconImgView.snp.height)
        }
        
        self.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.top.bottom.equalTo(iconImgView).inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    func updateItem(text: String, showStatus: Bool = false) {
        if text.contains("http") {
            itemTitleLabel.isHidden = true
            linkButton.isHidden = false
            linkButton.setTitle(text, for: .normal)
            linkUrl = URL(string: text)
        } else {
            itemTitleLabel.isHidden = false
            linkButton.isHidden = true
            itemTitleLabel.text = text
            linkUrl = nil
        }
        statusLabel.isHidden = !showStatus
    }
    
    //MARK: - Action
    @objc func linkButtonClicked() {
        guard let url = linkUrl else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
