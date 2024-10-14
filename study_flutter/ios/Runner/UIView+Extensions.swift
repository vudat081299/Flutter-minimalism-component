//
//  UIView+Extensions.swift
//  Runner
//
//  Created by datvq24 on 11/10/24.
//

import Foundation
import UIKit

class BaseCustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewWithNib()
        setupDidLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewWithNib()
        setupDidLoad()
    }
    
    func setupDidLoad() {}
}

extension UIView {
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle.main
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func initViewWithNib() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
        [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: self.bounds.width*0.85, height: self.bounds.height))
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
