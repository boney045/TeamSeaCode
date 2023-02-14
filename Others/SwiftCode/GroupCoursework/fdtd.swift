import Foundation

public struct Grid: Gridable {
    
    public var hx: [[Double]]; public var chxh: [[Double]]; public var chxe: [[Double]]
    
    public var hy: [[Double]]; public var chyh: [[Double]]; public var chye: [[Double]]
    
    public var hz: [[Double]]; public var chzh: [[Double]]; public var chze: [[Double]]
    
    public var ex: [[Double]]; public var cexe: [[Double]]; public var cexh: [[Double]]
    
    public var ey: [[Double]]; public var ceye: [[Double]]; public var ceyh: [[Double]]
    
    public var ez: [[Double]]; public var ceze: [[Double]]; public var cezh: [[Double]]
    
    public var sizeX: Int
    public var sizeY: Int
    public var sizeZ: Int
    public var time: Int
    public var maxTime: Int
    public var cdtds: Double
    public var type: Int
    
    
    public init(hx: [[Double]], chxh: [[Double]], chxe: [[Double]],
                hy: [[Double]], chyh: [[Double]], chye: [[Double]],
                hz: [[Double]], chzh: [[Double]], chze: [[Double]],
                
                ex: [[Double]], cexe: [[Double]], cexh: [[Double]],
                ey: [[Double]], ceye: [[Double]], ceyh: [[Double]],
                ez: [[Double]], ceze: [[Double]], cezh: [[Double]],
                
                sizeX: Int, sizeY: Int, sizeZ: Int,
                
                time: Int, maxTime: Int, cdtds: Double, type: Int){
        
        self.hx = hx; self.chxh = chxh; self.chxe = chxe
        self.hy = hy; self.chyh = chyh; self.chye = chye
        self.hz = hy; self.chzh = chzh; self.chze = chze
        
        self.ex = ex; self.cexe = cexe; self.cexh = cexh
        self.ey = ey; self.ceye = ceye; self.ceyh = ceyh
        self.ez = ez; self.ceze = ceze; self.cezh = cezh
        
        self.sizeX = sizeX; self.sizeY = sizeY; self.sizeZ = sizeZ
        
        self.time = time
        self.maxTime = maxTime
        self.cdtds = cdtds
        self.type = type
        
    }
    
    /* ---- getters ---- */
    
    public func getMaxTime() -> Int {
        return maxTime
    }
    
    public mutating func setField(){
        if ((ez.count != 0) || (hy.count != 0)){
            
            ex.removeAll()
            cexe.removeAll()
            cexh.removeAll()
            
            ey.removeAll()
            ceye.removeAll()
            ceyh.removeAll()
            
            ez.removeAll()
            ceze.removeAll()
            cezh.removeAll()
            
            hx.removeAll()
            chxe.removeAll()
            chxh.removeAll()
            
            hy.removeAll()
            chyh.removeAll()
            chye.removeAll()
            
            hy.removeAll()
            chyh.removeAll()
            chye.removeAll()
            
            hz.removeAll()
            chzh.removeAll()
            chze.removeAll()
            
        }
        for x in 0...sizeX-2{
            ex.append([])
            cexe.append([])
            cexh.append([])
            for _ in 0...sizeY-1{
                ex[x].append(0.0)
                cexe[x].append(0.0)
                cexh[x].append(0.0)
            }
        }
        
        for x in 0...sizeX-1{
            ey.append([])
            ceye.append([])
            ceyh.append([])
            for _ in 0...sizeY-2{
                ey[x].append(0.0)
                ceye[x].append(0.0)
                ceyh[x].append(0.0)
            }
        }
        
        for x in 0...sizeX-1{
            ez.append([])
            ceze.append([])
            cezh.append([])
            for _ in 0...sizeY-1{
                ez[x].append(0.0)
                ceze[x].append(0.0)
                cezh[x].append(0.0)
            }
        }
        for x in 0...sizeX-1 {
            hx.append([])
            chxe.append([])
            chxh.append([])
            for _ in 0...sizeY-2 {
                hx[x].append(0.0)
                chxe[x].append(0.0)
                chxh[x].append(0.0)
            }
        }
        
        for x in 0...sizeX-2{
            hy.append([])
            chyh.append([])
            chye.append([])
            for _ in 0...sizeY-1{
                hy[x].append(0.0)
                chyh[x].append(0.0)
                chye[x].append(0.0)
            }
        }
        
        for x in 0...sizeX-2{
            hz.append([])
            chzh.append([])
            chze.append([])
            for _ in 0...sizeY-2{
                hz[x].append(0.0)
                chzh[x].append(0.0)
                chze[x].append(0.0)
            }
        }
    }
}
