import XCTest
@testable import SwiftSequence
import Foundation

class CombinationsTests: XCTestCase {
  // MARK: Eager
  
  func testCombosWithoutRep() {
    
    let comboed = [1, 2, 3].combos(2)
    
    let expectation = [[1, 2], [1, 3], [2, 3]]
    
    XCTAssertEqual(comboed)(expectation)
    
  }
  
  func testCombosWithRep() {
    
    let comboed = [1, 2, 3].combosWithRep(2)
    
    let expectation = [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]
    
    XCTAssertEqual(comboed)(expectation)
    
  }
  
  // MARK: Lazy
  
  func testLazyCombosWithoutRep() {
    
    for randAr in (0..<10).map(Array<Int>.init) {
      
      let eager = randAr.combos(min(randAr.count, 3))
      
      let lazy = randAr.lazyCombos(min(randAr.count, 3))
      
      XCTAssertEqual(eager)(lazy)
      
    }
    
  }
  
  func testLazyCombosWithRep() {
    
    for randAr in(0..<10).map(Array<Int>.init) {
      
      let eager = randAr.combosWithRep(min(randAr.count, 3))
      
      let lazy = randAr.lazyCombosWithRep(min(randAr.count, 3))
      
      XCTAssertEqual(eager)(lazy)
      
    }
    
  }
  
  func testNoDuplicates() {
    
    var letters: Set<Character> = []
    while letters.count < 10 {
      letters.insert(
        Character(
          UnicodeScalar(arc4random_uniform(156) + 100)
        )
      )
    }
    
    let sComboes    = letters.combos(5).map(String.init)
    let lComboes    = Array(letters.lazyCombos(5).map(String.init))
    let sRepComboed = letters.combosWithRep(5).map(String.init)
    let lRepComboed = Array(letters.lazyCombosWithRep(5).map(String.init))
    
    XCTAssertEqual(sComboes.count, Set(sComboes).count)
    XCTAssertEqual(lComboes.count, Set(lComboes).count)
    XCTAssertEqual(sRepComboed.count, Set(sRepComboed).count)
    XCTAssertEqual(lRepComboed.count, Set(lRepComboed).count)
    
  }
  
  
}