import XCTest

@testable import GroupCoursework



class Tests: XCTestCase {
    
    var testGrid: Grid!
    
    override func setUp() {
        super.setUp()
        testGrid = Grid(hx: [[]], chxh: [[]], chxe: [[]], hy: [[]], chyh: [[]], chye: [[]], hz: [[]], chzh: [[]], chze: [[]], ex: [[]], cexe: [[]], cexh: [[]], ey: [[]], ceye: [[]], ceyh: [[]], ez: [[]], ceze: [[]], cezh: [[]], sizeX: 0, sizeY: 0, sizeZ: 0, time: 0, maxTime: 0, cdtds: 0, type: 0)    }
    
    override func tearDown() {
        testGrid = nil
        super.tearDown()
    }
    
    func testSetfield(){
        
        testGrid.sizeX = 80
        testGrid.sizeY = 80
        
        XCTAssertEqual(testGrid.sizeX, 80)
        XCTAssertEqual(testGrid.sizeY, 80)
        
        testGrid.setField()
        
        for mm in 0...testGrid.sizeX-1{
            for nn in 0...testGrid.sizeY-1{
                 XCTAssertEqual(testGrid.ez[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.ceze[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.cezh[mm][nn], 0.0)
            }
        }
        
        for mm in 0...testGrid.sizeX-2{
             for nn in 0...testGrid.sizeY-2{
                 XCTAssertEqual(testGrid.hz[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chzh[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chze[mm][nn], 0.0)
             }
        }
        
        for mm in 0...testGrid.sizeX-1{
            for nn in 0...testGrid.sizeY-2{
                 XCTAssertEqual(testGrid.ey[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.ceye[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.ceyh[mm][nn], 0.0)
         
                 XCTAssertEqual(testGrid.hx[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chxe[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chxh[mm][nn], 0.0)
            }
        }
        
        for mm in 0...testGrid.sizeX-2{
            for nn in 0...testGrid.sizeY-1{
                 XCTAssertEqual(testGrid.ex[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.cexe[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.cexh[mm][nn], 0.0)
            
                 XCTAssertEqual(testGrid.hy[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chyh[mm][nn], 0.0)
                 XCTAssertEqual(testGrid.chye[mm][nn], 0.0)
            }
        }

    }
    
    func testHarmonic(){
        ppw = 20.0
        sourceChoice = 1
        cdtds =  1.0 / sqrt(2.0)

        let expectedHarmo = sin(2.0 * Double.pi / ppw * (cdtds * 1.5 - 0.0))
        let actualHarmo = ezInc(time: 1.5, location: 0.0)
    
        XCTAssertEqual(actualHarmo, expectedHarmo)
    }
    
    func testRicker(){
        ppw = 25.8
        sourceChoice = 2
        cdtds =  1.0 / sqrt(2.0)
        
        let expectedRicker1 = pow((Double.pi * ((cdtds * 2.3 - 1.5) / ppw - 1.0)),2)
        let expectedRicker2 = (1.0 - 2.0 * expectedRicker1) * exp(-expectedRicker1)
        
        let actualRicker = ezInc(time: 2.3, location: 1.5)
        
        XCTAssertEqual(actualRicker, expectedRicker2)
    }
    
    func testGridInitTMz(){
        
        testGrid.sizeX = 78
        testGrid.sizeY = 55
        testGrid.cdtds = 1.0 / sqrt(2.0)
        pcChoice = 0
        
        testGrid.setField()
        
        gridInitTMz(grid: &testGrid)
        
        let const = 1.0 / sqrt(2.0) * 377.0
        let const2 = 1.0 / sqrt(2.0) / 377.0
        
        for mm in 0...testGrid.sizeX-1 {
            for nn in 0...testGrid.sizeY-1 {
                XCTAssertEqual(testGrid.ceze[mm][nn], 1.0)
                XCTAssertEqual(testGrid.cezh[mm][nn], const)
            }
        }
        
        /* set magnetic-field update coefficients */
        for mm in 0...testGrid.sizeX-1 {
            for nn in 0...testGrid.sizeY-2 {
                XCTAssertEqual(testGrid.chxh[mm][nn], 1.0)
                XCTAssertEqual(testGrid.chxe[mm][nn], const2)
            }
        }
        
        for mm in 0...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-1{
                XCTAssertEqual(testGrid.chyh[mm][nn], 1.0)
                XCTAssertEqual(testGrid.chye[mm][nn], const2)
                
            }
        }
    }
    
    func testGridInitTEz() {
        
        testGrid.sizeX = 46
        testGrid.sizeY = 55
        testGrid.cdtds = 1.0 / sqrt(2.0)
        pcChoice = 0
        
        testGrid.setField()
        
        gridInitTEz(grid: &testGrid)
        
        let const = 1.0 / sqrt(2.0) * 377.0
        let const2 = 1.0 / sqrt(2.0) / 377.0
        
        for mm in 0...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-1 {
                XCTAssertEqual(testGrid.cexe[mm][nn], 1.0)
                XCTAssertEqual(testGrid.cexh[mm][nn], const)
            }
        }
        
        /* set magnetic-field update coefficients */
        for mm in 0...testGrid.sizeX-1 {
            for nn in 0...testGrid.sizeY-2 {
                XCTAssertEqual(testGrid.ceye[mm][nn], 1.0)
                XCTAssertEqual(testGrid.ceyh[mm][nn], const)
            }
        }
        
        for mm in 0...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-2{
                XCTAssertEqual(testGrid.chzh[mm][nn], 1.0)
                XCTAssertEqual(testGrid.chze[mm][nn], const2)
                
            }
        }
    }
    
    func testUpdateTMz(){
        
        testGrid.sizeX = 10
        testGrid.sizeY = 10
        
        testGrid.setField()
        
        updateHTMz(grid: &testGrid)
        
        for mm in 0...testGrid.sizeX-1 {
            for nn in 0...testGrid.sizeY-2{
                let updateHValue = testGrid.chxh[mm][nn] * testGrid.hx[mm][nn] - testGrid.chxe[mm][nn] * (testGrid.ez[mm][nn+1] - testGrid.ez[mm][nn])
                XCTAssertEqual(testGrid.hx[mm][nn], updateHValue)
            }
        }
        
        for mm in 0...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-1 {
                let updateHValue2 = testGrid.chyh[mm][nn] * testGrid.hy[mm][nn] + testGrid.chye[mm][nn] * (testGrid.ez[mm+1][nn] - testGrid.ez[mm][nn])
                XCTAssertEqual(testGrid.hy[mm][nn], updateHValue2)
            }
        }
        
        updateETMz(grid: &testGrid)
        
        for mm in 1...testGrid.sizeX-2 {
            for nn in 1...testGrid.sizeY-2 {
                let updateEvalue = testGrid.ceze[mm][nn] * testGrid.ez[mm][nn] + testGrid.cezh[mm][nn] * ((testGrid.hy[mm][nn] - testGrid.hy[mm-1][nn]) - (testGrid.hx[mm][nn] - testGrid.hx[mm][nn-1]))
                XCTAssertEqual(testGrid.ez[mm][nn], updateEvalue)
            }
        }
    }
    
    func testUpdateTEz(){
        
        testGrid.sizeX = 10
        testGrid.sizeY = 10
        
        testGrid.setField()
        
        updateHTEz(grid: &testGrid)
    
        for mm in 0...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-2{
                let updateHValue = testGrid.chzh[mm][nn] * testGrid.hz[mm][nn] + testGrid.chze[mm][nn] * ((testGrid.ex[mm][nn+1] - testGrid.ex[mm][nn]) - (testGrid.ey[mm+1][nn] - testGrid.ey[mm][nn]))
                XCTAssertEqual(testGrid.hz[mm][nn], updateHValue)
            }
        }
        
        updateETEz(grid: &testGrid)
        
        for mm in 0...testGrid.sizeX-2 {
            for nn in 1...testGrid.sizeY-2 {
                let updateEValue = testGrid.cexe[mm][nn] * testGrid.ex[mm][nn] + testGrid.cexh[mm][nn] * (testGrid.hz[mm][nn] - testGrid.hz[mm][nn-1])
                XCTAssertEqual(testGrid.ex[mm][nn], updateEValue)
            }
        }

        for mm in 1...testGrid.sizeX-2 {
            for nn in 0...testGrid.sizeY-2 {
                let updateEvalue2 = testGrid.ceye[mm][nn] * testGrid.ey[mm][nn] - testGrid.ceyh[mm][nn] * (testGrid.hz[mm][nn] - testGrid.hz[mm-1][nn])
                XCTAssertEqual(testGrid.ey[mm][nn], updateEvalue2)
            }
        }
        
    }
    
    func testAbcInit() {
        
        testGrid.sizeX = 13
        testGrid.sizeY = 14
        
        testGrid.setField()
        
        abcInit(grid: &testGrid)
        
        XCTAssertNotNil(eyLeft)
        XCTAssertNotNil(eyRight)
        XCTAssertNotNil(exTop)
        XCTAssertNotNil(exBottom)
        
        XCTAssertNotNil(ezLeft)
        XCTAssertNotNil(ezRight)
        XCTAssertNotNil(ezTop)
        XCTAssertNotNil(ezBottom)

    }
    
    func testGrid1D() {
        testGrid.sizeX = 70
        testGrid.sizeY = 50
        
        gridChoice = 1
        
        gridInit1d(grid: &testGrid)
        
        XCTAssertEqual(testGrid.ceze[0][0], 1.0)
        
        let test1dvalue = 80.0 - (90.0 - 1.0 - 20.0) + 0.5
        let test1dvalue2 = maxLoss * pow(test1dvalue/20.0, 2)
        let test1dvalue3 = (1.0 - test1dvalue2) / (1.0 + test1dvalue2)
        
        XCTAssertEqual(testGrid.ceze[80][0], test1dvalue3)
    }
}
