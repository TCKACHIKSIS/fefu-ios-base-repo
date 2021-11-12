//
//  OneStatementInActivityTableViewCell.swift
//  fefuactivity
//
//  Created by иван on 12.11.2021.
//

import UIKit

class OneStatementInActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func commonInit(){
        self.viewWithTag(1)?.layer.cornerRadius = 12;
        
        ///заготовка под класс для штучек на вью, где показывается список тренировок, которых по идее много, просто пока разбираюсь  с тем, как нормально компонент в коде сохранить с автолейаутом, пока просто сверстал.
    }
}
