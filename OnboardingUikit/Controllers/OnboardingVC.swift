//
//  OnboardingVC.swift
//  OnboardingUikit
//
//  Created by Taha JADID on 20/2/2023.
//

import UIKit

class OnboardingVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let titleArray = [
        "Painter job",
        "Pizza Maker  job",
        "Waiter job"
    ]

    let subTitleArray = [
        "> SubTitlte \nnumber 1",
        "> SubTitlte \nnumber 2",
        "> SubTitlte \nnumber 3",
    ]
    
    let imageArray = [
        ImageHelper.item1,
        ImageHelper.item2,
        ImageHelper.item3
    ]
    
    let bgArray = [
        ImageHelper.bg1,
        ImageHelper.bg2,
        ImageHelper.bg3
    ]
}

// MARK: - View Life Cycle
extension OnboardingVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        signupButton.layer.cornerRadius = 12
        loginButton.layer.cornerRadius = 12
        
        signupButton.isHidden = true
        loginButton.isHidden = true
        
        pageControl.page = 0
        skipShow(0 != 2)

    }
    
}

// MARK: - IBActions
extension OnboardingVC {
    @IBAction func skipButtonAction(_ sender: UIButton) {
        showItem(at: 2)
        skipShow(true)
    }
    
    @IBAction func signupButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func pageValueChanged(_ sender: UIPageControl) {
        showItem(at: pageControl.currentPage)
    }
}

// MARK: - Private Functions
extension OnboardingVC {
    private func skipShow(_ bool: Bool){
        skipButton.isHidden = !bool
        loginButton.isHidden = bool
        signupButton.isHidden = bool
    }
    
    private func showItem(at index: Int){
        skipShow(index == 2)
        pageControl.page = pageControl.currentPage
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally,.centeredVertically], animated: true)
    }
}

// MARK: - UICollection Delegate and DataSource
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCellCollectionViewCell", for: indexPath) as! OnboardingCellCollectionViewCell
        cell.artImageWidthConstraint.constant = normalize(value: 260.0)
        cell.artImageView.image = imageArray[indexPath.row]
        cell.bgImageView.image = bgArray[indexPath.row]

        cell.headingLabel.text = titleArray[indexPath.row]
        cell.subHeadingLabel.text = subTitleArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) /
                             pageWidth) + 1)
        pageControl.page = page
        
        skipShow(page != 2)
    }
}

extension UIPageControl {
    var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
            
            
            for index in 0..<numberOfPages where index != newValue {
                setIndicatorImage(ImageHelper.pageUnselected, forPage: index)
                preferredIndicatorImage = ImageHelper.pageUnselected
            }
            
            
            setIndicatorImage(ImageHelper.pageSelected, forPage: newValue)
        }
        
     }
}

func normalize(value: CGFloat) -> CGFloat {
    let scale = UIScreen.main.bounds.width / 375.0
    return value*scale
}
