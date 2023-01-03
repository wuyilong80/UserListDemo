//
//  UserListViewController.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit
import SnapKit

class UserListViewController: UIViewController {
    
    // api login first
    // get user list
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersAPI(perPage: 15).requestData { data, error in
            
        }
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
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
    }
}

extension UserListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCell.reuseIdentifier, for: indexPath)
        return cell
    }
}
