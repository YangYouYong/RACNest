//
//  PuzzlePiece.swift
//  RACNest
//
//  Created by Rui Peres on 31/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa

struct PuzzlePiecePosition {
    
    let row: Int
    let column: Int
    
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

extension PuzzlePiecePosition: Hashable {
    
    var hashValue: Int {
        return "\(row),\(column)".hash
    }
}

func ==(lhs: PuzzlePiecePosition, rhs: PuzzlePiecePosition) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

typealias MovePiece = (PuzzlePiece, PuzzlePiecePosition) -> Void

final class PuzzlePiece: UIView {
    
    private let puzzleImageView: UIImageView = UIImageView()
    private let viewModel: PuzzlePieceViewModel
    private let moveAnimation: MovePiece
    
    init(size: CGSize, moveAnimation: MovePiece, viewModel: PuzzlePieceViewModel) {
        
        self.viewModel = viewModel
        self.moveAnimation = moveAnimation
        
        super.init(frame: CGRect(origin: CGPointZero, size: size))
        
        addSubview(puzzleImageView)
        self.puzzleImageView.image = viewModel.image
        
        viewModel.currentPiecePosition.producer.startWithNext { piecePosition in
            moveAnimation(self, piecePosition)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        puzzleImageView.frame = bounds
    }
}
