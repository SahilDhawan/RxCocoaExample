//
//  TableViewModel.swift
//  RxCocoaTest
//
//  Created by Sahil Dhawan on 08/01/18.
//  Copyright © 2018 Sahil Dhawan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TableViewModel {
    private let disposeBag = DisposeBag()
    private let tableDataSource : Variable<[String]> = Variable([])
    
    let dataSource : Observable<[String]>
    
    
    init(addDriver : Driver<Void>) {
        self.dataSource = tableDataSource.asObservable()
        
        addDriver.drive(onNext: { _  in
            self.tableDataSource.value.append("item")
        }).disposed(by: disposeBag)
    }
}
