//
//  barebones.swift
//  Acoustic_FDTD
//
//  Created by Jake Mcilvaney on 23/11/2022.
//
// To analyse results, copy printed values into excel and create a scatter plot.

import Foundation
// Defining constants
let c0 = 343.0 // speed of sound in m/s
let cr = 1.0 // relative speed of sound, assuming perfect conditions
let SIZE = 50 // size of each array
let delta_t = 1.0 // time step
let delta = 1.0 // spatial step
let rho = 997.0 // density of water in kg/m^3
let Sc = (c0*delta_t)/delta // Courant number

//function to initialise a 2D array (matrix) of 0.0 of size sizeX by sizeY
func init2DArray(sizeX: Int, sizeY: Int) -> Array<Array<Double>>{
    var temp2DArray = [[Double]]()
    var tempNNArray = [Double]()
    for _ in stride(from: 0, to: sizeX, by: 1){
        for _ in stride(from: 0, to: sizeY, by: 1){
            tempNNArray.append(0.0)
        }
        temp2DArray.append(tempNNArray)
    }
    return temp2DArray
}

func Acoustic_bareBones2D(){
    // initialise arrays
    var Pr = init2DArray(sizeX: SIZE, sizeY: SIZE)
    var vx = init2DArray(sizeX: SIZE, sizeY: SIZE)
    var vy = init2DArray(sizeX: SIZE, sizeY: SIZE)
    // simulation ends at maxTime
    let maxTime = 250.0
    // time stepping
    for qTime in stride(from: 0.0, to: maxTime, by: delta_t){
        // update velocity in x-axis with embedded for loops
        for mm in stride(from: 0, to: SIZE-1, by: 1){
            for nn in stride(from: 0, to: SIZE-1, by: 1){
                vx[mm][nn] = vx[mm][nn] - (Pr[mm+1][nn] - Pr[mm][nn])*(Sc/(rho*c0))
            }
        }
        // update velocity in y-axis
        for mm in stride(from: 0, to: SIZE-1, by: 1){
            for nn in stride(from: 0, to: SIZE-1, by: 1){
                vy[mm][nn] = vy[mm][nn] - (Pr[mm][nn+1] - Pr[mm][nn])*(Sc/(rho*c0))
            }
        }
        // update pressure field
        for mm in stride(from: 1, to: SIZE, by: 1){
            for nn in stride(from: 1, to: SIZE, by: 1){
                Pr[mm][nn] = Pr[mm][nn] - (vx[mm][nn] - vx[mm-1][nn] + vy[mm][nn] - vy[mm][nn-1])*rho*pow(cr,2)*Sc
            }
        }
        //hardwire a source node
        Pr[0][0] = 5.0*exp(-(qTime-30.0)*(qTime-30.0)/100)
        print(vx[0][0]) // check change in velocity over time at source node
        //print(Pr[0][0]) // check form of source node in time
    }
}
