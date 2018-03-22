//
//  ViewController.swift
//  ListingImpressionDemoApp
//
//  Created by Emre on 22.03.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var impressionEventStalker: ListingImpressionStalker?
    var indexPathsOfCellsTurnedGreen = [IndexPath]()
    
    @IBOutlet weak var collectionView:UICollectionView!{
        didSet{
            collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
            impressionEventStalker = ListingImpressionStalker(minimumPercentageOfCell: 0.75, collectionView: collectionView, delegate: self)
        }
    }
    
    func registerCollectionViewCells(){
        let cellNib = UINib(nibName: CustomCollectionViewCell.nibName, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        impressionEventStalker?.stalkCells()
    }
    
    //MARK: UIScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        impressionEventStalker?.stalkCells()
    }
}

extension ViewController:ListingImpressionStalkerDelegate{
    func sendEventForCell(atIndexPath indexPath: IndexPath) {
        print("Event can be sent for indexPath: \(indexPath)")
        
        guard let customCell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else {
            return
        }
        customCell.cellBackground.backgroundColor = .green
        indexPathsOfCellsTurnedGreen.append(indexPath)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError()
        }
        customCell.indexLabel.text = "\(indexPath.row)"
        
        if indexPathsOfCellsTurnedGreen.contains(indexPath){
            customCell.cellBackground.backgroundColor = .green
        }else{
            customCell.cellBackground.backgroundColor = .red
        }
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

