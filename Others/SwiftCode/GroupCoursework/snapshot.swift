import Foundation

var temporalStride = -2
//var frame = 0
var startTime = -1

var startNodeX = -1
var endNodeX = -1
var spatialStrideX = -1

var startNodeY = -1
var endNodeY = -1
var spatialStrideY = -1

var snapshots = [[[Double]]]()

public func snapshotInit<T: Gridable>(grid: T){
    
    print("\nFor the snapshots: \n")
    
    if (presetChoice == 1) {
        startTime = 0
        temporalStride = 10
        startNodeX = 0
        endNodeX = grid.sizeX-2
        spatialStrideX = 1
        startNodeY = 0
        endNodeY = grid.sizeY-2
        spatialStrideY = 1
        print("Start time: \(startTime)")
        print("Temporal Stride: \(temporalStride)")
        print("Start node: (\(startNodeX),\(startNodeY))")
        print("End node: (\(endNodeX),\(endNodeY))")
        print("Spatial stride in x and y: \(spatialStrideY)")
        
    }
    else{
        print("Duration of simulation is \(grid.maxTime) steps.")
        while (startTime < 0) || (startTime > grid.maxTime){
            print("Enter start time : ")
            let input1 = Int(readLine()!)
            if let input1 = input1{
                startTime = input1
            }
            if (startTime < 0) || (startTime > grid.maxTime) {
                print("\nPlease enter a valid time between 0 and \(grid.maxTime)")
            }
        }
        while (temporalStride <= 0) || (startTime > grid.maxTime){
            print("Enter temporal stride: ")
            let input2 = Int(readLine()!)
            if let input2 = input2 {
                temporalStride = input2
            }
            if (temporalStride <= 0) || (startTime > grid.maxTime) {
                print("\nPlease enter a valid temporal stride between 1 and \(grid.maxTime)")
            }
        }
        
        print("In x direction grid has \(grid.sizeX) nodes (ranging from 0 to \(grid.sizeX-1)) ")
        
        while (startNodeX < 0) || (startNodeX > grid.sizeX-1){
            print("Enter first node (x-direction): ")
            let input3 = Int(readLine()!)
            if let input3 = input3 {
                startNodeX = input3
            }
            if (startNodeX < 0) || (startNodeX > grid.sizeX-1) {
                print("\nPlease enter a valid first node between 0 and \(grid.sizeX-1)")
            }
        }
        
        while (endNodeX < startNodeX) || (endNodeX > grid.sizeX-1){
            print("Enter last node (x-direction): ")
            let input4 = Int(readLine()!)
            if let input4 = input4 {
                endNodeX = input4
            }
            if (endNodeX < 0) || (endNodeX > grid.sizeX-1) {
                print("\nPlease enter a valid last node between \(startNodeX) and \(grid.sizeX-1)")
            }
        }
        
        while (spatialStrideX <= 0) || (spatialStrideX > grid.sizeX-1){
            print("Enter spatial strides (x-direction): ")
            let input5 = Int(readLine()!)
            if let input5 = input5 {
                spatialStrideX = input5
            }
            if (spatialStrideX <= 0) || (spatialStrideX > grid.sizeX-1) {
                print("\nPlease enter a valid spatial stride between 1 and \(grid.sizeX-1)")
            }
        }
        
        
        print("In y direction grid has \(grid.sizeY) nodes (ranging from 0 to \(grid.sizeY-1)) ")
        
        while (startNodeY < 0) || (startNodeY > grid.sizeX-1){
            print("Enter first node (y-direction): ")
            let input6 = Int(readLine()!)
            if let input6 = input6 {
                startNodeY = input6
            }
            if (startNodeY < 0) || (startNodeY > grid.sizeY-1) {
                print("\nPlease enter a valid first node between 0 and \(grid.sizeY-1)")
            }
        }
        
        while (endNodeY < startNodeY) || (endNodeY > grid.sizeY-1){
            print("Enter last node (y-direction): ")
            let input7 = Int(readLine()!)
            if let input7 = input7 {
                endNodeY = input7
            }
            if (endNodeY < startNodeY) || (endNodeX > grid.sizeY-1) {
                print("\nPlease enter a valid last node between \(startNodeY) and \(grid.sizeY-1)")
            }
        }
        
        while (spatialStrideY <= 0) || (spatialStrideY > grid.sizeY-1){
            print("Enter spatial strides (y-direction): ")
            let input8 = Int(readLine()!)
            if let input8 = input8 {
                spatialStrideY = input8
            }
            if (spatialStrideY <= 0) || (spatialStrideY > grid.sizeY-1) {
                print("\nPlease enter a valid spatial stride between 1 and \(grid.sizeY-1)")
            }
        }
    }
}

public func snapshot2d<T: Gridable>(grid: T){
    
    /* ensure temporal stride set to a reasonable value */
    if (temporalStride == -1){
        return
    }
    
    if (temporalStride < -1) {
        print("snapshot: snapshotInit must be called before snapshot. \n Temporal stride must be set to positive vlaue. \n")
        exit(-1)
    }
    
    if ((grid.time >= startTime) && (grid.time - startTime) % temporalStride == 0) {
        
        var snap: [[Double]] = [[]]
        snap.removeAll()
        
        var i = 0
        
        for nn in stride(from: endNodeY-1, through: startNodeY, by: -spatialStrideY) {
            snap.append([])
            for mm in stride(from: startNodeX, through: endNodeX-1, by: spatialStrideX) {
                if (gridChoice == 1) {
                    snap[i].append(grid.ez[mm][nn])
                }
                else {
                    snap[i].append(grid.hz[mm][nn])
                }
            }
            i = i+1
        }
        snapshots.append(snap)
    }
}

public func snapshot2dAcoustic<T: Gridable>(grid: T){
    
    /* ensure temporal stride set to a reasonable value */
    if (temporalStride == -1){
        return
    }
    
    if (temporalStride < -1) {
        print("snapshot: snapshotInit must be called before snapshot. \n Temporal stride must be set to positive vlaue. \n")
        exit(-1)
    }
    
    if ((grid.time >= startTime) && (grid.time - startTime) % temporalStride == 0) {
        
        var snap: [[Double]] = [[]]
        snap.removeAll()
        
        var i = 0
        
        for nn in stride(from: endNodeY-1, through: startNodeY, by: -spatialStrideY) {
            snap.append([])
            for mm in stride(from: startNodeX, through: endNodeX-1, by: spatialStrideX) {
                if (gridChoice == 1) {
                    snap[i].append(grid.ez[mm][nn])
                }
                else {
                    snap[i].append(grid.hz[mm][nn])
                }
            }
            i = i+1
        }
        snapshots.append(snap)
    }
}


public func writeSnapToTextFile<T: Gridable>(grid: T){
    
    var pathToFile = ""
    let date = Date()
    
    print("Enter the file path where you would like to store the data: \nExample:  /Users/username/Documents/main/GroupCoursework-master/snapshots/")
    let input9 = String?(readLine()!)
    if let input9 = input9 {
        pathToFile = input9
    }
    
    let fileName = (date.description).replacingOccurrences(of: ":", with: "_")
    
    var writeFilename = pathToFile + "snapshot_" + fileName + ".dat"
    
    var fileHasBeenWritten = FileManager.default.createFile(atPath: writeFilename, contents: nil, attributes: nil)
    
    if !fileHasBeenWritten{
        pathToFile = FileManager.default.currentDirectoryPath
        writeFilename = pathToFile + "snapshot_" + fileName + ".dat"
        fileHasBeenWritten = FileManager.default.createFile(atPath: writeFilename, contents: nil, attributes: nil)
        
    }
    
    if fileHasBeenWritten {
        
        do {
            var outputText = String()
            for (index, elements) in snapshots.enumerated() {
                outputText.append("Index: \(index) /Time: \(index  * temporalStride + startTime)\n")
                for (_, xvalues) in elements.enumerated() {
                    for (_, values) in xvalues.enumerated() {
                        outputText.append("\(values), ")
                    }
                    outputText.append("\n")
                }
                outputText.append("\n\n")
            }
            try outputText.write(toFile: writeFilename, atomically: false, encoding: .utf8)
        } catch {
            print("Erorr \(error) ")
        }
    }
    
    
    print("File has been written: \(fileHasBeenWritten)") 
    if (pathToFile == ""){
        pathToFile = FileManager.default.currentDirectoryPath
    }
    print("Path: \(pathToFile)")
}

