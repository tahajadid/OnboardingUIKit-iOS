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
        "Numerous Title \nnumber SOUR",
        "Numerous Title \nnumber Second",
        "Numerous Title \nnumber Third"
    ]

    let subTitleArray = [
        "Numerous SubTitlte \nnumber SOUR",
        "Numerous SubTitlte \nnumber Second",
        "Numerous SubTitlte \nnumber Third"
    ]
    
    let imageArray = [
        ImageHelper.item1,
        ImageHelper.item2,
        ImageHelper.item3
    ]
}

// MARK: - View Life Cycle
extension OnboardingVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - IBActions
extension OnboardingVC {
    @IBAction func skipButtonAction(_ sender: UIButton) {
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
        skipShow(index != 2)
        pageControl.page = pageControl.currentPage
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally,.centeredVertically], animated: true)
    }
}

// MARK: - UICollection Delegate and DataSource
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
            setIndicatorImage(ImageHelper.pageSelected, forPage: newValue)
            
            for index in 0..<numberOfPages where index != newValue {
                preferredIndicatorImage = ImageHelper.pageUnselected
            }
        }
        
     }
}
