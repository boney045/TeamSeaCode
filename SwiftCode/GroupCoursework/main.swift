import Foundation

var g = Grid(hx: [[]], chxh: [[]], chxe: [[]], hy: [[]], chyh: [[]], chye: [[]], hz: [[]], chzh: [[]], chze: [[]], ex: [[]], cexe: [[]], cexh: [[]], ey: [[]], ceye: [[]], ceyh: [[]], ez: [[]], ceze: [[]], cezh: [[]], sizeX: 0, sizeY: 0, sizeZ: 0, time: 0, maxTime: 0, cdtds: 0, type: 0)


public var presetChoice = 0
public var sourceChoice = 0
public var gridChoice = 0

while (presetChoice != 1) && (presetChoice != 2){
    print("Enter 1 for an example simulation OR 2 to enter your own conditions: ")
    let input0 = Int(readLine()!)
    if let input0 = input0{
        presetChoice = input0
    }
    if (presetChoice != 1) && (presetChoice != 2) {
        print("\nPlease enter a valid number")
    }
}

if (presetChoice == 1){
    sourceChoice = 2
    gridChoice = 1
}
else {
    while (sourceChoice != 1) && (sourceChoice != 2){
        print("Enter 1 for a harmonic source OR 2 for a ricker wavelet: ")
        let input1 = Int(readLine()!)
        if let input1 = input1{
            sourceChoice = input1
        }
        if (sourceChoice != 1) && (sourceChoice != 2) {
            print("\nPlease enter a valid number")
        }
    }
    
    while (gridChoice != 1) && (gridChoice != 2){
        print("Enter 1 for a grid with TMz OR 2 for a grid with TEz: ") 
        let input0 = Int(readLine()!)
        if let input0 = input0{
            gridChoice = input0
        }
        if (gridChoice != 1) && (gridChoice != 2) {
            print("\nPlease enter a valid number")
        }
    }
}


gridInit(grid: &g)

if gridChoice == 1 {
    print("\nGrid: TMz")
    gridInitTMz(grid: &g)
    print("\nSnapshots will display Ez field")
}
else{
    print("\nGrid: TEz")
    gridInitTEz(grid: &g)
    print("\nSnapshots will display Hz field")
}

abcInit(grid: &g)

tfsfInit(grid: &g)

snapshotInit(grid: g)

print("\nIn progress...")

for Time in 0...g.getMaxTime() {
    
    g.time = Time
    if gridChoice == 1 { 
        updateHTMz(grid: &g)
        tfsfUpdateTMz(grid: &g)
        updateETMz(grid: &g)
        abcTMz(grid: &g)
        
    }
    else {
        updateHTEz(grid: &g)
        tfsfUpdateTEz(grid: &g)
        updateETEz(grid: &g)
        abcTEz(grid: &g)
    }
    snapshot2dAcoustic(grid: g)
    
}

public var saveFile = 0


print("Enter 1 to save file: ")
let input0 = Int(readLine()!)
if let input0 = input0{
    saveFile = input0
}
if saveFile == 1{
    writeSnapToTextFile(grid: g) //- commenting this out - 23/11/2022 08:34
}
        

