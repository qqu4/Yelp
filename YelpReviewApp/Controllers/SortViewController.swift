//
//  SortViewController.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-10.
//

import UIKit

protocol SortViewDelegate : AnyObject {
    func segmentedControlValueChanged(_ sender: UISegmentedControl)
}

class SortViewController: BottomPopupViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    weak var delegate: SortViewDelegate?
    private var selectedIndex: Int
    
    init(selectedIndex: Int, delegate: SortViewDelegate) {
        self.selectedIndex = selectedIndex
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updatePopupHeight(to: 160)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = selectedIndex
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(sender)
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
