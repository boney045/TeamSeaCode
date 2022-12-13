import Foundation

var tfsfBoundary = 0

var firstX = 0
var firstY = 0
var lastX = 0
var lastY = 0

var g1 = Grid(hx: [[]], chxh: [[]], chxe: [[]], hy: [[]], chyh: [[]], chye: [[]], hz: [[]], chzh: [[]], chze: [[]], ex: [[]], cexe: [[]], cexh: [[]], ey: [[]], ceye: [[]], ceyh: [[]], ez: [[]], ceze: [[]], cezh: [[]], sizeX: 0, sizeY: 0, sizeZ: 0, time: 0, maxTime: 0, cdtds: 0, type: 0)

public func tfsfInit<T: Gridable>(grid: inout T) {
    
    g1 = grid as! Grid
    
    gridInit1d(grid: &g1)
    
    if (presetChoice == 1) {
        firstX = 5
        firstY = 5
        lastX = 80
        lastY = 70
        print("\nTFSF starts at (\(firstX),\(firstY)) and ends at (\(lastX),\(lastY))")
    }
    else{
        print("Grid is \(grid.sizeX) by \(grid.sizeY) cell. \n ")
        print("Enter indices for first point in TF region")
        
        while (firstX <= 0) || (firstX > grid.sizeX-2){
            print("x point (between 1-\(grid.sizeX-2)): ")
            let input1 = Int(readLine()!)
            if let input1 = input1 {
                firstX = input1
            }
            if (firstX <= 0) || (firstX > grid.sizeX-2) {
                print("\nPlease enter a valid number")
            }
        }
        
        while (firstY <= 0) || (firstY > grid.sizeY-2){
            print("y point (between 1-\(grid.sizeY-2)): ")
            let input2 = Int(readLine()!)
            if let input2 = input2 {
                firstY = input2
            }
            if (firstY <= 0) || (firstY > grid.sizeY-2) {
                print("\nPlease enter a valid number")
            }
        }
        
        print("Enter indices for last point in TF region")
        while (lastX < firstX) || (lastX > grid.sizeX-2) {
            print("x point (between \(firstX)-\(grid.sizeX-2)):")
            let input3 = Int(readLine()!)
            if let input3 = input3 {
                lastX = input3
            }
            if (lastX < firstX) || (lastX > grid.sizeX-2){
                print("\nPlease enter a valid number")
            }
        }
        
        while (lastY < firstX) || (lastY > grid.sizeY-2) {
            print("y point (between \(firstY)-\(grid.sizeY-2)): ")
            let input4 = Int(readLine()!)
            if let input4 = input4 {
                lastY = input4
            }
            if (lastY < firstX) || (lastY > grid.sizeY-2) {
                print("\nPlease enter a valid number")
            }
        }
        
    }
    
    ezIncInit(grid: &grid)
    
}

public func tfsfUpdateTMz<T: Fieldable>(grid: inout T){
    
    var mm = 0
    var nn = 0
    
    if (firstX <= 0){
        print(" tfsfInit must be called before tfsfUpdate. \n Boundary location must be set to positive value. \n")
        exit(-1)
    }
    
    mm = firstX - 1
    for nn in firstY...lastY{
        grid.hy[mm][nn] -= grid.chye[mm][nn] * g1.ez[mm+1][0]
    }
    
    mm = lastX
    for nn in firstY...lastY {
        grid.hy[mm][nn] += grid.chye[mm][nn] * g1.ez[mm][0]
    }
    
    nn = firstY - 1
    for mm in firstX...lastX {
        grid.hx[mm][nn] += grid.chxe[mm][nn] * g1.ez[mm][0]
    }
    
    nn = lastY
    for mm in firstX...lastX {
        grid.hx[mm][nn] -= grid.chxe[mm][nn] * g1.ez[mm][0]
    }
    updateHTMz(grid: &g1)
    updateETMz(grid: &g1)
    
    g1.ez[0][0] = ezInc(time: Double(g1.time), location: 0.0)
    
    g1.time = grid.time + 1

    mm = firstX
    for nn in firstY...lastY {
        grid.ez[mm][nn] -= grid.cezh[mm][nn] * g1.hy[mm-1][0]
    }
    
    mm = lastX
    for nn in firstY...lastY {
        grid.ez[mm][nn] += grid.cezh[mm][nn] * g1.hy[mm][0]
    }
}


public func tfsfUpdateTEz<T: Fieldable>(grid: inout T){
    
    var mm = 0
    var nn = 0
    
    if (firstX <= 0){
        print(" tfsfInit must be called before tfsfUpdate. \n Boundary location must be set to positive value. \n")
        exit(-1)
    }
    
    mm = firstX - 1
    for nn in firstY...lastY-1{
        grid.hz[mm][nn] += grid.chze[mm][nn] * g1.ey[mm+1][0]
    }
    
    mm = lastX
    for nn in firstY...lastY-1 {
        grid.hz[mm][nn] -= grid.chze[mm][nn] * g1.ey[mm][0]
    }
    
    updateHTEz(grid: &g1)
    updateETEz(grid: &g1)
    
    g1.ey[0][0] = ezInc(time: Double(g1.time), location: 0.0)
    
    g1.time = grid.time + 1
    
    nn = firstY
    for mm in firstX...lastX-1 {
        grid.ex[mm][nn] -= grid.cexh[mm][nn] * g1.hz[mm][0]
    }
    
    nn = lastY
    for mm in firstX...lastX-1 {
        grid.ex[mm][nn] += grid.cexh[mm][nn] * g1.hz[mm][0]
    }
    
    mm = firstX
    for nn in firstY...lastY-1 {
        grid.ey[mm][nn] += grid.ceyh[mm][nn] * g1.hz[mm-1][0]
    }
    
    mm = lastX
    for nn in firstY...lastY-1 {
        grid.ey[mm][nn] -= grid.ceyh[mm][nn] * g1.hz[mm][0]
    }
}

