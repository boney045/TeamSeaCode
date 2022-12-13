
import Foundation

var NLOSS = 20
var maxLoss = 0.35
public func gridInit1d<T: Gridable>(grid: inout T){
    
    let imp0 = 377.0
    var depthInLayer = 0.0
    var lossFactor = 0.0
    
    grid.sizeX += NLOSS
    grid.sizeY = 2
    grid.type = 1
    
    grid.setField()
    
    if (gridChoice == 1){
        for mm in 0...grid.sizeX-2 {
            if (mm<grid.sizeX-1-NLOSS){
                grid.ceze[mm][0] = 1.0
                grid.cezh[mm][0] = grid.cdtds * imp0
                grid.chyh[mm][0] = 1.0
                grid.chye[mm][0] = grid.cdtds / imp0
            }
            else {
                depthInLayer = Double(mm) - (Double(grid.sizeX) - 1.0 - Double(NLOSS)) + 0.5
                lossFactor = maxLoss * pow(depthInLayer/Double(NLOSS), 2)
                grid.ceze[mm][0] = (1.0 - lossFactor) / (1.0 + lossFactor)
                grid.cezh[mm][0] = grid.cdtds * imp0 / (1.0 + lossFactor)
                depthInLayer += 0.5
                lossFactor = maxLoss * pow(depthInLayer/Double(NLOSS), 2)
                grid.chyh[mm][0] = (1.0-lossFactor) / (1.0+lossFactor)
                grid.chye[mm][0] = grid.cdtds / imp0 / (1.0 + lossFactor)
            }
        }
    }
    else{
        for mm in 0...grid.sizeX-2 {
            if (mm<grid.sizeX-1-NLOSS){
                grid.ceye[mm][0] = 1.0
                grid.ceyh[mm][0] = grid.cdtds * imp0
                grid.chzh[mm][0] = 1.0
                grid.chze[mm][0] = grid.cdtds / imp0
            }
            else {
                depthInLayer += 0.5
                lossFactor = maxLoss * pow(depthInLayer/Double(NLOSS), 2)
                grid.ceye[mm][0] = (1.0 - lossFactor) / (1.0 + lossFactor)
                grid.ceyh[mm][0] = grid.cdtds * imp0 / (1.0 + lossFactor)
                depthInLayer += 0.5
                lossFactor = maxLoss * pow(depthInLayer/Double(NLOSS), 2)
                grid.chzh[mm][0] = (1.0-lossFactor) / (1.0+lossFactor)
                grid.chze[mm][0] = grid.cdtds / imp0 / (1.0 + lossFactor)
            }
        }
    }
}
