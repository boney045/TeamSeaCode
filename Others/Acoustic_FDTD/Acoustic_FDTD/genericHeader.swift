import Foundation

public struct Grid<T>{
    public private(set) var vx = [T]()
    public private(set) var vy = [T]()
    public private(set) var Pr = [T]()

    //public private(set) var cexe = [T]()
    //public let sizeX : Int
    //public let sizeY: Int
    //public let sizeZ: Int
    //public let maxTime: Double
    //public let cdtds: Double
    //public let type: String
}

func initArray(array: Array<Double>, SIZE: Int) -> Array<Double>{
    var tempArray = array
    for _ in stride(from: 0, to: SIZE, by: 1){
        tempArray.append(0.0)
    }
    return tempArray
}

/*func init2DArray(sizeX: Int, sizeY: Int) -> Array<Array<Double>>{
    var temp2DArray = [[Double]]()
    var tempNNArray = [Double]()
    for _ in stride(from: 0, to: sizeX, by: 1){
        for _ in stride(from: 0, to: sizeY, by: 1){
            tempNNArray.append(0.0)
        }
        temp2DArray.append(tempNNArray)
    }
    return temp2DArray
}*/

func init3DArray(sizeX: Int, sizeY: Int, sizeZ: Int) -> Array<Array<Array<Double>>>{
    var temp3DArray = [[[Double]]]()
    var tempPPArray = [Double]()
    var tempNNArray = [[Double]]()
    
    for _ in stride(from: 0, to: sizeX, by: 1){
        for _ in stride(from: 0, to: sizeY, by: 1){
            for _ in stride(from: 0, to: sizeZ, by: 1){
                tempPPArray.append(0.5)
            }
            tempNNArray.append(tempPPArray)
        }
        temp3DArray.append(tempNNArray)
    }
    return temp3DArray
}
