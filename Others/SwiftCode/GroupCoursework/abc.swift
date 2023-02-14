import Foundation

var initDone = false

var coef0 = 0.0
var coef1 = 0.0
var coef2 = 0.0

var eyLeft = [Double]()
var eyRight = [Double]()
var exTop = [Double]()
var exBottom = [Double]()

var ezLeft = [Double]()
var ezRight = [Double]()
var ezTop = [Double]()
var ezBottom = [Double]()

func mqn(M: Int, Q: Int, N: Int) -> Int {
    return (N * 6 + Q * 3 + M)
}

public func abcInit<T: Fieldable>(grid: inout T) {
    
    var temp1 = 0.0
    var temp2 = 0.0
    initDone = true
    
    for _ in 0...(grid.sizeY*6)-1{
        ezLeft.append(0.0)
        ezRight.append(0.0)
    }
    for _ in 0...(grid.sizeX*6)-1{
        ezTop.append(0.0)
        ezBottom.append(0.0)
    }
    
    for _ in 0...((grid.sizeY-1)*6)-1{
        eyLeft.append(0.0)
        eyRight.append(0.0)
    }
    for _ in 0...((grid.sizeX-1)*6)-1{
        exTop.append(0.0)
        exBottom.append(0.0)
    }
    
    if gridChoice == 1{
        temp1 = sqrt(grid.cezh[0][0] * grid.chye[0][0])
    }
    else {
        temp1 = sqrt(grid.cexh[0][0] * grid.chze[0][0])
    }
    temp2 = 1.0 / temp1 + 2.0 + temp1
    coef0 = -(1.0 / temp1 - 2.0 + temp1) / temp2
    coef1 = -2.0 * (temp1 - 1.0 / temp1) / temp2
    coef2 = 4.0 * (temp1 + 1.0 / temp1) / temp2
    
}

public func abcTMz<T: Fieldable>(grid: inout T) {
    
    /* check if abcOnot() has been called */
    if (!initDone) {
        print("abc: abcInit must be called before abc.\n")
        exit(-1)
    }
    
    for nn in 0...grid.sizeY-1 {
        grid.ez[0][nn] = coef0 * (grid.ez[2][nn] + ezLeft[mqn(M: 0, Q: 1, N: nn)]) + coef1 * (ezLeft[mqn(M: 0, Q: 0, N: nn)] + ezLeft[mqn(M: 2, Q: 0, N: nn)] - grid.ez[1][nn] - ezLeft[mqn(M: 1, Q: 1, N: nn)]) + coef2 * ezLeft[mqn(M: 1, Q: 0, N: nn)] - ezLeft[mqn(M: 2, Q: 1, N: nn)]
        for mm in 0...2 {
            ezLeft[mqn(M: mm, Q: 1, N: nn)] = ezLeft[mqn(M: mm, Q: 0, N: nn)]
            ezLeft[mqn(M: mm, Q: 0, N: nn)] = grid.ez[mm][nn]
        }
    }
    
    for nn in 0...grid.sizeY-1 {
        grid.ez[grid.sizeX-1][nn] = coef0 * (grid.ez[grid.sizeX-3][nn] + ezRight[mqn(M: 0, Q: 1, N: nn)]) + coef1 * (ezRight[mqn(M: 0, Q: 0, N: nn)] + ezRight[mqn(M: 2, Q: 0, N: nn)] - grid.ez[grid.sizeX-2][nn] - ezRight[mqn(M: 1, Q: 1, N: nn)]) + coef2 * ezRight[mqn(M: 1, Q: 0, N: nn)] - ezRight[mqn(M: 2, Q: 1, N: nn)]
        for mm in 0...2 {
            ezRight[mqn(M: mm, Q: 1, N: nn)] = ezRight[mqn(M: mm, Q: 0, N: nn)]
            ezRight[mqn(M: mm, Q: 0, N: nn)] = grid.ez[grid.sizeX-1-mm][nn]
        }
    }
    
    for mm in 0...grid.sizeX-1 {
        grid.ez[mm][0] = coef0 * (grid.ez[mm][2] + ezBottom[mqn(M: 0, Q: 1, N: mm)]) + coef1 * (ezBottom[mqn(M: 0, Q: 0, N: mm)] + ezBottom[mqn(M: 2, Q: 0, N: mm)] - grid.ez[mm][1] - ezBottom[mqn(M: 1, Q: 1, N: mm)]) + coef2 * ezBottom[mqn(M: 1, Q: 0, N: mm)] - ezBottom[mqn(M: 2, Q: 1, N: mm)]
        for nn in 0...2{
            ezBottom[mqn(M: nn, Q: 1, N: mm)] = ezBottom[mqn(M: nn, Q: 0, N: mm)]
            ezBottom[mqn(M: nn, Q: 0, N: mm)] = grid.ez[mm][nn]
        }
    }
    
    for mm in 0...grid.sizeX-1 {
        grid.ez[mm][grid.sizeY-1] = coef0 * (grid.ez[mm][grid.sizeY-3] + ezTop[mqn(M: 0, Q: 1, N: mm)]) + coef1 * (ezTop[mqn(M: 0, Q: 0, N: mm)] + ezTop[mqn(M: 2, Q: 0, N: mm)] - grid.ez[mm][grid.sizeY-2] - ezTop[mqn(M: 1, Q: 1, N: mm)]) + coef2 * ezTop[mqn(M: 1, Q: 0, N: mm)] - ezTop[mqn(M: 2, Q: 1, N: mm)]
        for nn in 0...2{
            ezTop[mqn(M: nn, Q: 1, N: mm)] = ezTop[mqn(M: nn, Q: 0, N: mm)]
            ezTop[mqn(M: nn, Q: 0, N: mm)] = grid.ez[mm][grid.sizeY-1-nn]
        }
    }
}


public func abcTEz<T: Fieldable>(grid: inout T) {
    
    if (!initDone) {
        print("abc: abcInit must be called before abc.\n")
        exit(-1)
    }
    
    for nn in 0...grid.sizeY-2 {
        grid.ey[0][nn] = coef0 * (grid.ey[2][nn] + eyLeft[mqn(M: 0, Q: 1, N: nn)]) + coef1 * (eyLeft[mqn(M: 0, Q: 0, N: nn)] + eyLeft[mqn(M: 2, Q: 0, N: nn)] - grid.ey[1][nn] - eyLeft[mqn(M: 1, Q: 1, N: nn)]) + coef2 * eyLeft[mqn(M: 1, Q: 0, N: nn)] - eyLeft[mqn(M: 2, Q: 1, N: nn)]
        for mm in 0...2 {
            eyLeft[mqn(M: mm, Q: 1, N: nn)] = eyLeft[mqn(M: mm, Q: 0, N: nn)]
            eyLeft[mqn(M: mm, Q: 0, N: nn)] = grid.ey[mm][nn]
        }
    }
    
    for nn in 0...grid.sizeY-2 {
        grid.ey[grid.sizeX-1][nn] = coef0 * (grid.ey[grid.sizeX-3][nn] + eyRight[mqn(M: 0, Q: 1, N: nn)]) + coef1 * (eyRight[mqn(M: 0, Q: 0, N: nn)] + eyRight[mqn(M: 2, Q: 0, N: nn)] - grid.ey[grid.sizeX-2][nn] - eyRight[mqn(M: 1, Q: 1, N: nn)]) + coef2 * eyRight[mqn(M: 1, Q: 0, N: nn)] - eyRight[mqn(M: 2, Q: 1, N: nn)]
        for mm in 0...2 {
            eyRight[mqn(M: mm, Q: 1, N: nn)] = eyRight[mqn(M: mm, Q: 0, N: nn)]
            eyRight[mqn(M: mm, Q: 0, N: nn)] = grid.ey[grid.sizeX-1-mm][nn]
        }
    }
    
    for mm in 0...grid.sizeX-2 {
        grid.ex[mm][0] = coef0 * (grid.ex[mm][2] + exBottom[mqn(M: 0, Q: 1, N: mm)]) + coef1 * (exBottom[mqn(M: 0, Q: 0, N: mm)] + exBottom[mqn(M: 2, Q: 0, N: mm)] - grid.ex[mm][1] - exBottom[mqn(M: 1, Q: 1, N: mm)]) + coef2 * exBottom[mqn(M: 1, Q: 0, N: mm)] - exBottom[mqn(M: 2, Q: 1, N: mm)]
        for nn in 0...2{
            exBottom[mqn(M: nn, Q: 1, N: mm)] = exBottom[mqn(M: nn, Q: 0, N: mm)]
            exBottom[mqn(M: nn, Q: 0, N: mm)] = grid.ex[mm][nn]
        }
    }
    
    for mm in 0...grid.sizeX-2 {
        grid.ex[mm][grid.sizeY-1] = coef0 * (grid.ex[mm][grid.sizeY-3] + exTop[mqn(M: 0, Q: 1, N: mm)]) + coef1 * (exTop[mqn(M: 0, Q: 0, N: mm)] + exTop[mqn(M: 2, Q: 0, N: mm)] - grid.ex[mm][grid.sizeY-2] - exTop[mqn(M: 1, Q: 1, N: mm)]) + coef2 * exTop[mqn(M: 1, Q: 0, N: mm)] - exTop[mqn(M: 2, Q: 1, N: mm)]
        for nn in 0...2{
            exTop[mqn(M: nn, Q: 1, N: mm)] = exTop[mqn(M: nn, Q: 0, N: mm)]
            exTop[mqn(M: nn, Q: 0, N: mm)] = grid.ex[mm][grid.sizeY-1-nn]
        }
    }
}

