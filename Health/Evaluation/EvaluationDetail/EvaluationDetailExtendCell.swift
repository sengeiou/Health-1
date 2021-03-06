//
//  EvaluationDetailExtendCell.swift
//  Health
//
//  Created by Yalin on 15/10/21.
//  Copyright © 2015年 Yalin. All rights reserved.
//

import UIKit

class EvaluationDetailExtendCell: UITableViewCell {
    
    static var normalHeight: CGFloat = 65
    static var extendHeight: CGFloat = 246
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var markLowLabel: UILabel!
    @IBOutlet weak var markHighLabel: UILabel!
    @IBOutlet weak var descriptionLabel: AttributedLabel!
    
    @IBOutlet weak var lowLevelLabel: UILabel!
    @IBOutlet weak var normalLevelLabel: UILabel!
    @IBOutlet weak var highLevelLabel: UILabel!
    
    @IBOutlet weak var markBgImageView: UIImageView!
    @IBOutlet weak var markIconCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var markHighLabelCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var markLowLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var fatPercentageTooHighLabelCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var fatPercentageLeanLabelCenterConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViewModel(viewModel: EvaluationDetailExtendViewModel) {
        
        iconImageView.image = UIImage(named: viewModel.type.headIcon)
        titleLabel.text = viewModel.type.title
        unitLabel.text = viewModel.unit
        resultLabel.textColor = viewModel.status.statusColor
        markBgImageView.image = UIImage(named: viewModel.type.markBgImageName)
        
        if viewModel.valueIsNumber {
            resultLabel.text = viewModel.value
            
//            NSLog("%.1f\(viewModel.type) ---- %.1f", viewModel.range.1, viewModel.range.0);
            let unit = viewModel.unit
            let high = String(format: "%.1f", viewModel.range.1)
            let low = String(format: "%.1f", viewModel.range.0)
            markHighLabel.text = high + unit
            markLowLabel.text = low + unit
            
            // 等级描述
            descriptionLabel.clear()
            let levelDescription = viewModel.levelDescription
            let font = UIFont.systemFontOfSize(13)
            if viewModel.status == ValueStatus.High {
                descriptionLabel.append(levelDescription.2, font: font, color: viewModel.status.statusColor)
            }
            else if viewModel.status == ValueStatus.Normal {
                descriptionLabel.append(levelDescription.1, font: font, color: viewModel.status.statusColor)
            }
            else if viewModel.status == ValueStatus.Low {
                descriptionLabel.append(levelDescription.0, font: font, color: viewModel.status.statusColor)
            }
            
            // 等级title
            let levelTitle = viewModel.type.levelTitle
            lowLevelLabel.text = levelTitle.0
            normalLevelLabel.text = levelTitle.1
            highLevelLabel.text = levelTitle.2
            
            // 计算标记位置
            let rulerWidth = markBgImageView.frame.size.width
            let labelPad = rulerWidth / 3 / 2 + 15
            let labelPad2 = rulerWidth / 2 - 20
            let numberValues = viewModel.value.floatValue
            
            fatPercentageLeanLabelCenterConstraint.constant = -1 * labelPad2
            fatPercentageTooHighLabelCenterConstraint.constant = labelPad2
            
            markHighLabelCenterConstraint.constant = labelPad
            markLowLabelConstraint.constant = labelPad * -1
            
            let middleValue = (viewModel.range.0 + viewModel.range.1) / 2
            let offset = numberValues - middleValue
            
            if viewModel.range.1 != middleValue {
                
                var constant = CGFloat(offset) * (labelPad / CGFloat(viewModel.range.1 - middleValue))
                
                if constant > markBgImageView.frame.size.width / 2 {
                    constant = markBgImageView.frame.size.width / 2
                }
                else if constant < -1 * markBgImageView.frame.size.width / 2 {
                    constant = -1 * markBgImageView.frame.size.width / 2
                }
                
                markIconCenterConstraint.constant = constant
            }
        }
        else {
            resultLabel.text = viewModel.value
        }
        
        
    }
}
