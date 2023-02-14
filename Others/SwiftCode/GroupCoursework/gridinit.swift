import Foundation

let imp0 =  377.0// 997.0 // impedance of free space

private var rad = -1.0
private var r2 = 0.0
private var xLocation = 0.0
private var yLocation = 0.0
private var xCenter = 0.0
private var yCenter = 0.0

var pcChoice = 0

public func gridInit<T: Gridable>(grid: inout T){
    
    if (presetChoice == 1) {
        grid.sizeX = 92
        print("\nGrid size X: \(grid.sizeX)")
        grid.sizeY = 82
        print("Grid size Y: \(grid.sizeY)")
        grid.maxTime = 300
        print("Max Time: \(grid.maxTime)")
        
        if (gridChoice == 2){
            pcChoice = 1
        }
    }
    else {
        while (grid.sizeX < 10) || (grid.sizeX > 300){
            print("Enter the x size of the grid (between 10-300): ")
            let input0 = Int(readLine()!)
            if let input0 = input0{
                grid.sizeX = input0
            }
            if (grid.sizeX < 10) || (grid.sizeX > 300) {
                print("\nPlease enter a valid integer between 10-300")
            }
        }
        
        while (grid.sizeY < 10) || (grid.sizeY > 300){
            print("Enter the y size of the grid (between 10-300): ")
            let input1 = Int(readLine()!)
            if let input1 = input1{
                grid.sizeY = input1
            }
            if (grid.sizeY < 10) || (grid.sizeY > 300) {
                print("\nPlease enter a valid integer between 10-300")
            }
        }
        
        while (grid.maxTime < 10) || (grid.maxTime > 350){
            print("Enter the max simulation time (between 10-350): ")
            let input3 = Int(readLine()!)
            if let input3 = input3{
                grid.maxTime = input3
            }
            if (grid.maxTime < 10) || (grid.maxTime > 350) {
                print("\nPlease enter a valid integer between 10-350")
            }
        }
        
        while (pcChoice != 1) && (pcChoice != 2){
            print("Do you want to add a scatterer in the grid. \nEnter 1 for YES OR 2 for NO: ")
            let input5 = Int(readLine()!)
            if let input5 = input5{
                pcChoice = input5
            }
            if (pcChoice != 1) && (pcChoice != 2) {
                print("\nPlease enter a valid number")
            }
        }
        
    }
    
    if (pcChoice == 1) {
        if (presetChoice==1){
            rad = 10.0
        }
        else{
            while (rad < 0.0){
                print("Enter the radius of the scatterer (keep it below the size of the grid for best result): ")
                let input6 = Double(readLine()!)
                if let input6 = input6{
                    rad = input6
                }
                if (rad < 0.0) {
                    print("\nPlease enter a valid number")
                }
            }
        }
        xCenter = Double(grid.sizeX/2)
        yCenter = Double(grid.sizeY/2)
        r2 = rad * rad
    }
    
    grid.cdtds = 1.0 / sqrt(2.0) // Courant number
    
    grid.setField()
}

public func gridInitTMz<T: Gridable>(grid: inout T){
    
    grid.type = 2
    
    for mm in 0...grid.sizeX-1 {
        for nn in 0...grid.sizeY-1 {
            grid.ceze[mm][nn] = 1.0
            grid.cezh[mm][nn] = grid.cdtds * imp0
        }
    }
    
    for mm in 0...grid.sizeX-1 {
        for nn in 0...grid.sizeY-2 {
            grid.chxh[mm][nn] = 1.0
            grid.chxe[mm][nn] = grid.cdtds / imp0
        }
    }
    
    for mm in 0...grid.sizeX-2 {
        for nn in 0...grid.sizeY-1{
            grid.chyh[mm][nn] = 1.0
            grid.chye[mm][nn] = grid.cdtds / imp0
        }
    }
    
    if (pcChoice == 1) {
        for mm in 1...grid.sizeX-2 {
            xLocation = Double(mm) - xCenter
            for nn in 1...grid.sizeY-2 {
                yLocation = Double(nn) - yCenter
                if ((xLocation * xLocation + yLocation * yLocation) < r2) {
                    grid.chxh[mm][nn] = 0.0
                    grid.chxe[mm][nn] = 0.0
                    grid.chxh[mm+1][nn] = 0.0
                    grid.chxe[mm+1][nn] = 0.0
                    grid.chye[mm][nn+1] = 0.0
                    grid.chyh[mm][nn+1] = 0.0
                    grid.chye[mm][nn] = 0.0
                    grid.chyh[mm][nn] = 0.0
                }
            }
        }
    }
}


public func gridInitTEz<T: Gridable>(grid: inout T){
    
    grid.type = 3
    
    for mm in 0...grid.sizeX-2 {
        for nn in 0...grid.sizeY-1 {
            grid.cexe[mm][nn] = 1.0
            grid.cexh[mm][nn] = grid.cdtds * imp0
        }
    }
    
    for mm in 0...grid.sizeX-1 {
        for nn in 0...grid.sizeY-2 {
            grid.ceye[mm][nn] = 1.0
            grid.ceyh[mm][nn] = grid.cdtds * imp0
        }
    }
    
    if (pcChoice == 1) {
        print("\nRadius of the scatterer: \(rad)")
        print("Position of the scatterer (\(xCenter),\(yCenter))")
        for mm in 1...grid.sizeX-2 {
            xLocation = Double(mm) - xCenter
            for nn in 1...grid.sizeY-2 {
                yLocation = Double(nn) - yCenter
                if ((xLocation * xLocation + yLocation * yLocation) < r2) {
                    grid.cexe[mm][nn] = 0.0
                    grid.cexh[mm][nn] = 0.0
                    grid.cexe[mm][nn+1] = 0.0
                    grid.cexh[mm][nn+1] = 0.0
                    grid.ceye[mm+1][nn] = 0.0
                    grid.ceyh[mm+1][nn] = 0.0
                    grid.ceye[mm][nn] = 0.0
                    grid.ceyh[mm][nn] = 0.0
                }
            }
        }
        
    }
    
    for mm in 0...grid.sizeX-2 {
        for nn in 0...grid.sizeY-2 {
            grid.chzh[mm][nn] = 1.0
            grid.chze[mm][nn] = grid.cdtds / imp0
        }
    }
}

