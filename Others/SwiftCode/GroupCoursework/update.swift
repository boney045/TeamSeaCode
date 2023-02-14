import Foundation


public func updateHTMz<T: Fieldable>(grid: inout T)  {
    
    if (grid.type == 1) {
        for mm in 0...grid.sizeX-2 {
            grid.hy[mm][0] = grid.chyh[mm][0] * grid.hy[mm][0] + grid.chye[mm][0] * (grid.ez[mm + 1][0] - grid.ez[mm][0])
        }
    }
    else {
        for mm in 0...grid.sizeX-1 {
            for nn in 0...grid.sizeY-2{
                grid.hx[mm][nn] = grid.hx[mm][nn] - grid.chxe[mm][nn] * (grid.ez[mm][nn+1] - grid.ez[mm][nn]) //grid.chxh[mm][nn] * grid.hx[mm][nn] - grid.chxe[mm][nn] * (grid.ez[mm][nn+1] - grid.ez[mm][nn])
            }
        }
        for mm in 0...grid.sizeX-2 {
            for nn in 0...grid.sizeY-1 {
                grid.hy[mm][nn] = grid.hy[mm][nn] + grid.chye[mm][nn] * (grid.ez[mm+1][nn] - grid.ez[mm][nn]) //grid.chyh[mm][nn] * grid.hy[mm][nn] + grid.chye[mm][nn] * (grid.ez[mm+1][nn] - grid.ez[mm][nn])
            }
        }
    }
}

public func updateETMz<T: Fieldable>(grid: inout T) {
    if (grid.type == 1) {
        for mm in 1...grid.sizeX-2{
            grid.ez[mm][0] = grid.ceze[mm][0] * grid.ez[mm][0] + grid.cezh[mm][0] * (grid.hy[mm][0] - grid.hy[mm - 1][0])
        }
    }
    else {
        for mm in 1...grid.sizeX-2 {
            for nn in 1...grid.sizeY-2 {
                grid.ez[mm][nn] = grid.ez[mm][nn] + grid.cezh[mm][nn] * ((grid.hy[mm][nn] - grid.hy[mm-1][nn]) - (grid.hz[mm][nn] - grid.hx[mm][nn-1]))  //grid.ceze[mm][nn] * grid.ez[mm][nn] + grid.cezh[mm][nn] * ((grid.hy[mm][nn] - grid.hy[mm-1][nn]) - (grid.hx[mm][nn] - grid.hx[mm][nn-1]))
            }
        }
    }
}



public func updateHTEz<T: Fieldable>(grid: inout T)  {
    
    if (grid.type == 1) {
        for mm in 0...grid.sizeX-2 {
            grid.hz[mm][0] = grid.chzh[mm][0] * grid.hz[mm][0] - grid.chze[mm][0] * (grid.ey[mm + 1][0] - grid.ey[mm][0])
        }
    }
    else {
        for mm in 0...grid.sizeX-2 {
            for nn in 0...grid.sizeY-2{
                grid.hz[mm][nn] = grid.chzh[mm][nn] * grid.hz[mm][nn] + grid.chze[mm][nn] * ((grid.ex[mm][nn+1] - grid.ex[mm][nn]) - (grid.ey[mm+1][nn] - grid.ey[mm][nn]))
            }
        }
    }
}

public func updateETEz<T: Fieldable>(grid: inout T) {
    if (grid.type == 1) {
        for mm in 1...grid.sizeX-2{
            grid.ey[mm][0] = grid.ceye[mm][0] * grid.ey[mm][0] - grid.ceyh[mm][0] * (grid.hz[mm][0] - grid.hz[mm - 1][0])
        }
    }
    else {
        for mm in 0...grid.sizeX-2 {
            for nn in 1...grid.sizeY-2 {
                grid.ex[mm][nn] = grid.cexe[mm][nn] * grid.ex[mm][nn] + grid.cexh[mm][nn] * (grid.hz[mm][nn] - grid.hz[mm][nn-1])
            }
        }
        for mm in 1...grid.sizeX-2 {
            for nn in 0...grid.sizeY-2 {
                grid.ey[mm][nn] = grid.ceye[mm][nn] * grid.ey[mm][nn] - grid.ceyh[mm][nn] * (grid.hz[mm][nn] - grid.hz[mm-1][nn])
            }
        }
    }
}
