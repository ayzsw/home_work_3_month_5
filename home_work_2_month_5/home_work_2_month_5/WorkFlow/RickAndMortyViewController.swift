//
//  RickAndMortyViewController.swift
//  home_work_2_month_5
//
//  Created by Аяз on 30/6/23.
//

import UIKit

class RickAndMortyViewController: UIViewController, UICollectionViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: 90)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.delegate = self
        view.dataSource = self
        view.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID
        )
        return view
    }()
    
    private let viewModel: CharactersViewModel
    
    init() {
        viewModel = CharactersViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = CharactersViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCharacters()
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func fetchCharacters() {
        Task {
            do {
                characters = try await viewModel.fetchCharacters()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}

extension RickAndMortyViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.reuseID,
            for: indexPath
        ) as! CharacterCollectionViewCell
        let model = characters[indexPath.item]
        cell.display(item: model)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedCharacter = characters[indexPath.item]
        let detailViewController = CharacterDetailViewController(character: selectedCharacter)
        present(detailViewController, animated: true, completion: nil)
    }
}
