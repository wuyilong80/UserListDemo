//
//  UserListViewController.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit
import SnapKit

class UserListViewController: BaseViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UserList"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionLayout: UICollectionViewLayout = {
        let width = UIScreen.main.bounds.size.width
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width-16), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: -8)
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    lazy var listCollectionView: UICollectionView = {
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: collectionLayout)
        collection.register(UserListCell.self, forCellWithReuseIdentifier: UserListCell.reuseIdentifier)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    let viewModel: UserListViewModel
    
    //MARK: - Initialize
    init(viewModel: UserListViewModel) {
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
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        view.addSubview(listCollectionView)
        listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        super.setupLayout()
    }
}

extension UserListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? UserListCell {
            cell.updateUserInfo(info: viewModel.userInfoList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.userInfoList.count - 1 {
            viewModel.loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userInfo = viewModel.userInfoList[indexPath.row]
        let detailViewModel = UserDetailViewModel(username: userInfo.login ?? "")
        let detailVC = UserDetailViewController(viewModel: detailViewModel)
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
}

extension UserListViewController: BaseViewModelDelegate {
    
    func willLoadData() {
        updateIndicatorStatus(isHidden: false)
    }
    
    func didLoadData() {
        updateIndicatorStatus(isHidden: true)
        listCollectionView.reloadItems(at: viewModel.reloadIndexPaths)
    }
    
    func receiveError(message: String?) {
        updateIndicatorStatus(isHidden: true)
        self.showAlert(message: message ?? "")
    }
}
