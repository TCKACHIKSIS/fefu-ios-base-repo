//
//  one_statement_in_activity.swift
//  fefuactivity
//
//  Created by иван on 29.10.2021.
//

import UIKit

class OneStatementInActivity: UIView{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        
        commonInit()
    }
    private func commonInit(){
        self.viewWithTag(1)?.layer.cornerRadius = 12;
        
        ///заготовка под класс для штучек на вью, где показывается список тренировок, которых по идее много, просто пока разбираюсь  с тем, как нормально компонент в коде сохранить с автолейаутом, пока просто сверстал.
    }
}
