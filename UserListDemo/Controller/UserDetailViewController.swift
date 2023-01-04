//
//  UserDetailViewController.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

class UserDetailViewController: BaseViewController {

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        textField.delegate = self
        return textField
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusItem, locationItem, blogItem])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15.0
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var statusItem: UserDetailItemView = {
        let view = UserDetailItemView()
        view.iconImgView.image = UIImage(named: "icon_user")
        return view
    }()
    
    lazy var locationItem: UserDetailItemView = {
        let view = UserDetailItemView()
        view.iconImgView.image = UIImage(named: "icon_location")
        return view
    }()
    
    lazy var blogItem: UserDetailItemView = {
        let view = UserDetailItemView()
        view.iconImgView.image = UIImage(named: "icon_blog")
        return view
    }()
    
    let viewModel: UserDetailViewModel
    
    //MARK: - Initialize
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        viewModel.delegate = self
        viewModel.loadData()
    }
    
    //MARK: - Method
    override func setupLayout() {
        view.backgroundColor = UIColor.init(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1)
            
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.width.height.equalTo(40)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(40)
        }
        
        view.addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(80)
            make.height.equalTo(avatarImgView.snp.width)
        }
        
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let sepratorView = UIView()
        sepratorView.backgroundColor = .lightGray
        view.addSubview(sepratorView)
        sepratorView.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        view.addSubview(detailStackView)
        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(sepratorView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        statusItem.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        locationItem.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        blogItem.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        super.setupLayout()
    }
    
    func updateData() {
        if let userInfo = viewModel.userInfo {
            avatarImgView.getImage(urlString: userInfo.avatarUrl, radius: (UIScreen.main.bounds.size.width - 160) / 2)
            userNameTextField.text = userInfo.name
            bioLabel.text = userInfo.bio
            statusItem.updateItem(text: userInfo.login ?? "-", showStatus: userInfo.admin ?? false)
            locationItem.updateItem(text: userInfo.location ?? "-")
            blogItem.updateItem(text: userInfo.blog ?? "-")
        }
    }
    
    //MARK: - Action
    @objc func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonClicked() {
        userNameTextField.resignFirstResponder()
        self.showAlert(title: "Notice", message: "Do you want to update name?")
    }
}

extension UserDetailViewController: BaseViewModelDelegate {
    func willLoadData() {
        updateIndicatorStatus(isHidden: false)
    }
    
    func didLoadData() {
        updateIndicatorStatus(isHidden: true)
        updateData()
    }
    
    func receiveError(message: String?) {
        updateIndicatorStatus(isHidden: true)
    }
}

extension UserDetailViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
