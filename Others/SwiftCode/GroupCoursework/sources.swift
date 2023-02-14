import Foundation
import Darwin

var ppw = 0.0
var cdtds = 0.0

public func ezIncInit<T: Courantable>(grid: inout T){
    
    if (presetChoice == 1){
        ppw = 30.0
        print("\nPoint per wavelength for Ricker wavelet source: \(ppw)")
    }
    else{
        while (ppw <= 0) {
            print("Enter the points per wavelength for source: ")
            let input1 = Double(readLine()!)
            if let input1 = input1 {
                ppw = input1
            }
            if (ppw <= 0) {
                print("\nPlease enter a positive number")
            }
        }
        
    }
    cdtds = grid.cdtds
}

public func ezInc(time: Double, location: Double) -> Double {
    if (ppw <= 0) {
        print("width must be positive")
        exit(-1)
    }
    if (sourceChoice == 1){
        return sin(2.0 * Double.pi / ppw * (cdtds * time - location))
    }
    else{
        var arg = Double.pi * ((cdtds * time - location) / ppw - 1.0)
        arg = arg * arg
        return (1.0 - 2.0 * arg) * exp(-arg)
    }
}

