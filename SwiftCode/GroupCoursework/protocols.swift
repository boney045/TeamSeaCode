import Foundation

public protocol Gridable: Courantable, Fieldable {

    var maxTime: Int {get set}
    
    func getMaxTime() -> Int
    
    mutating func setField()
}

public protocol Courantable {
    var cdtds: Double {get set}
}

public protocol Fieldable {
    
    var sizeX: Int {get set}
    var sizeY: Int {get set}
    var sizeZ: Int {get set}
    var type: Int {get set}
    var time: Int {get set}

    var ex: [[Double]] {get set}
    var cexe: [[Double]] {get set}
    var cexh: [[Double]] {get set}
    
    var ey: [[Double]] {get set}
    var ceye: [[Double]] {get set}
    var ceyh: [[Double]] {get set}
    
    var ez : [[Double]] {get set}
    var ceze : [[Double]] {get set}
    var cezh : [[Double]] {get set}
    
    var hx : [[Double]] {get set}
    var chxh : [[Double]]{ get set}
    var chxe : [[Double]] {get set}
    
    var hy : [[Double]] {get set}
    var chyh : [[Double]] {get set}
    var chye : [[Double]] {get set}
    
    var hz: [[Double]] {get set}
    var chzh: [[Double]] {get set}
    var chze: [[Double]] {get set}
}
