//
//  WaitingView.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 06/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import EasyPeasy

class WaitingView: UIView {
	var indicator = UIActivityIndicatorView(style: .large)
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if !subviews.contains(indicator) {
			backgroundColor = UIColor.black.withAlphaComponent(0.7)
			indicator.color = .white
			indicator.stopAnimating()
			addSubview(indicator)
			indicator.easy.layout(CenterY(), CenterX())
		}
	}
	
	func animate(in presenter: UIView) {
		presenter.addSubview(self)
		easy.layout(Edges())
		indicator.startAnimating()
	}
	
	func stopAnimating() {
		indicator.stopAnimating()
		removeFromSuperview()
	}
}
