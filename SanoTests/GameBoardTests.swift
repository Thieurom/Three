//
//  GameBoardTests.swift
//  SanoTests
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Sano

class GameBoardTests: XCTestCase {
    
    var board: GameBoard!
    
    override func setUp() {
        super.setUp()
        
        let piece: GamePiece = .solid
        board = GameBoard(size: 3, firstPiece: piece)
    }
    
    override func tearDown() {
        board = nil
        super.tearDown()
    }
    
    func testNewGameBoard() {
        XCTAssertEqual(board.size, 3)
        XCTAssertEqual(board.firstPiece, .solid)
    }
    
    func testPlaceValidPieceOnTheBoard() {
        XCTAssertNil(board.lastPlacedPiece)
        XCTAssertEqual(board.nextPlacingPiece, .solid)
        
        // place next piece to the top-left of the board (0,0)
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
        
        XCTAssertEqual(board.nextPlacingPiece, .donut)
        
        // place next piece to the center of the board (1,1)
        do {
            try board.placeNextPiece(toRow: 1, column: 1)
            XCTAssertEqual(board.lastPlacedPiece, .donut)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
    }
    
    func testPlacePieceOutsideTheBoard() {
        do {
            try board.placeNextPiece(toRow: 3, column: 3)
            XCTFail("The game board should not be mutated succefully when placing piece outside the board!")
        } catch GameBoardError.outOfBoard {
            XCTAssertNil(board.lastPlacedPiece)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
    
    func testPlacePieceOnThePlacedLocation() {
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
        
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTFail("The game board should not be mutated succefully when placing piece on the already-placed location!")
        } catch GameBoardError.notEmptyLocation {
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
    
    func testCheckWinningRow() {
        XCTAssertFalse(board.hasWinningPiece(), "The board is not in the winning state yet!")
        
        do {
            /*
                   0   1   2
                 .___.___.___.
              0  | ● | ● | ● |
                 |---|---|---|
              1  | ○ | ○ |   |
                 |---|---|---|
              2  |   |   |   |
                 '---'---'---'
            */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (1, 0), (0, 1), (1, 1), (0, 2))
            
            XCTAssertTrue(board.hasWinningPiece(), "The board should be in the state that the solid piece is the winner")
        } catch {
            fatalError()
        }
    }
    
    func testCheckWinningColumn() {
        XCTAssertFalse(board.hasWinningPiece(), "The board is not in the winning state yet!")
        
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ |   |
                |---|---|---|
             1  | ● | ○ |   |
                |---|---|---|
             2  | ● |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (1, 1), (2, 0))
            
            XCTAssertTrue(board.hasWinningPiece(), "The board should be in the state that the solid piece is the winner")
        } catch {
            fatalError()
        }
    }
    
    func testCheckWinningLeftToRightDiagonal() {
        XCTAssertFalse(board.hasWinningPiece(), "The board is not in the winning state yet!")
        
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ |   |
                |---|---|---|
             1  |   | ● | ○ |
                |---|---|---|
             2  |   |   | ● |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 1), (1, 2), (2, 2))
            
            XCTAssertTrue(board.hasWinningPiece(), "The board should be in the state that the solid piece is the winner")
        } catch {
            fatalError()
        }
    }
    
    func testCheckWinningRightToLeftDiagonal() {
        XCTAssertFalse(board.hasWinningPiece(), "The board is not in the winning state yet!")
        
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ○ | ○ | ● |
                |---|---|---|
             1  |   | ● |   |
                |---|---|---|
             2  | ● |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 2), (0, 0), (1, 1), (0, 1), (2, 0))
            
            XCTAssertTrue(board.hasWinningPiece(), "The board should be in the state that the solid piece is the winner")
        } catch {
            fatalError()
        }
    }
    
    func testPlacePieceOnTheBoardHasWinningPiece() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ○ | ○ | ● |
                |---|---|---|
             1  |   | ● |   |
                |---|---|---|
             2  | ● |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 2), (0, 0), (1, 1), (0, 1), (2, 0))
            
            XCTAssertTrue(board.hasWinningPiece(), "The board should be in the state that the solid piece is the winner")
        } catch {
            fatalError()
        }
        
        XCTAssertEqual(board.lastPlacedPiece, .solid)
        
        do {
            try board.placeNextPiece(toRow: 2, column: 2)
            XCTFail("The game board should not be mutated succefully when placing piece on the board has winning piece!")
        } catch GameBoardError.completed {
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
    
    func testCheckDrawBoard() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ | ● |
                |---|---|---|
             1  | ● | ○ | ○ |
                |---|---|---|
             2  | ○ | ● | ● |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (2, 0), (0, 2), (1, 1), (2, 1), (1, 2), (2, 2))
            
            XCTAssertTrue(board.isDrawEnding(), "The board should be in a draw ending!")
        } catch {
            fatalError()
        }
    }
    
    func testPlacePieceOnDrawBoard() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ | ● |
                |---|---|---|
             1  | ● | ○ | ○ |
                |---|---|---|
             2  | ○ | ● | ● |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (2, 0), (0, 2), (1, 1), (2, 1), (1, 2), (2, 2))
        } catch {
            fatalError()
        }
        
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTFail("The game board should not be mutated succefully when placing piece on the draw ending board!")
        } catch GameBoardError.completed {
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
    
    func testPieceAtLocation() {
        XCTAssertNil(board.piece(atRow: 0, column: 0), "The piece at (0, 0) should be nil because of empty board!")
        XCTAssertNil(board.piece(atRow: 1, column: 2), "The piece at (1, 2) should be nil because of empty board!")
        XCTAssertNil(board.piece(atRow: -1, column: -1), "The piece at (-1, -1) should be nil because the location is out of bound!")
        XCTAssertNil(board.piece(atRow: 3, column: 3), "The piece at (3, 3) should be nil because the location is out of bound!")
        
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            try board.placeNextPiece(toRow: 1, column: 2)
        } catch {
            XCTFail("The game board should be mutated without error!")
            return
        }
        
        XCTAssertEqual(board.piece(atRow: 0, column: 0), .solid, "The piece at (0, 0) should be solid after placing piece!")
        XCTAssertEqual(board.piece(atRow: 1, column: 2), .donut, "The piece at (1, 2) should be donut after placing piece!")
    }
}

extension GameBoardTests {
    
    class func makeGameBoard(firstPiece: GamePiece, filledWithLocations locations: (row: Int, column: Int)...) throws -> GameBoard {
        
        var board = GameBoard(size: 3, firstPiece: firstPiece)
        
        for location in locations {
            try board.placeNextPiece(toRow: location.row, column: location.column)
        }
        
        return board
    }
}
