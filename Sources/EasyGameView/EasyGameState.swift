import Foundation

/// Model struct for game state data.
public struct EasyGameState: Codable, CustomStringConvertible {

    // MARK: Sub Types

    /// For relating positions to one another.
    enum Direction {
        case up
        case down
        case left
        case right
    }

    /// Encapsulation of x,y `Int` values.
    typealias Point = (x: Int, y: Int)

    // MARK: convenience properties

    /// Whether or not the game is over.
    var isOver = false

    /// Whether or not the game is paused.
    var isPaused = false

    // MARK: Date & time & game duration (mostly still TODO)

    /// The start datetime of the game.
    var gameTimeStartDate: Date

    // MARK: state properties

    /// A default variable for grid states.
    var stateDefault = -1

    /// The value representing an empty game state
    var stateEmpty = -1

    /// game states are between 0 and gridMaxStateInt
    var stateMax = 1

    /// A multidimensional array representing the state of each grid space
    private(set) var states = [[Int]]()

    // MARK: grid properties

    /// Total number of grid states.
    var gridCount: Int {
        gridWidth * gridHeight
    }

    /// Height of the grid in "units".
    var gridHeight: Int {
        didSet {
            resizeGrid()
        }
    }

    /// Width of the grid in "units".
    var gridWidth: Int {
        didSet {
            resizeGrid()
        }
    }

    // MARK: Initializers & setup

    /// Initializer for the GGM_Model instance.
    public init(gridWidth width: Int = 8,
         gridHeight height: Int = 8,
         stateDefault newDefault: Int? = nil,
         startDate: Date = Date()) {

        gameTimeStartDate = startDate
        gridWidth = width
        gridHeight = height
        if let newDefault = newDefault {
            stateDefault = newDefault
        }
        setupGrid()
    }

    /// This re-creates the "grid", which is essentially the multidimensional state array. Called on init.
    mutating func setupGrid() {
        states.removeAll()
        for _ in 0..<gridHeight {
            states.append(Array(repeating: stateDefault, count: gridWidth))
        }
    }

    /// This creates a new grid, copying over old state values when possible.
    mutating func resizeGrid() {
        let oldStates = states
        setupGrid()
        for y in 0..<oldStates.count {
            for x in 0..<oldStates[y].count {
                if y < gridHeight && x < gridWidth {
                    states[y][x] = oldStates[y][x]
                }
            }
        }
    }

    // MARK: setting state

    /// set a single state when x and y are known
    mutating func setState(atX x: Int, andY y: Int, to state: Int) {
        guard x >= 0, x < gridWidth, y >= 0, y < gridHeight else {
            return
        }
        states[y][x] = state
    }

    /// set a single state when only the index is known
    mutating func setState(atIndex index: Int, to state: Int) {
        setState(atPoint: pointFor(index: index), to: state)
    }

    /// set a single state at a given Point
    mutating func setState(atPoint point: Point, to state: Int) {
        setState(atX: point.x, andY: point.y, to: state)
    }

    /// get a random possible state int between 0 and `stateMax`
    func randomStateInt() -> Int {
        return Int.random(in: 0...stateMax)
    }

    /// completely randomize the grid states with values between `0` and `stateMax`
    mutating func randomizeStates() {
        for y in 0..<gridHeight {
            for x in 0..<gridWidth {
                states[y][x] = randomStateInt()
            }
        }
    }

    /// set all states to this new value
    mutating func setAllStates(to state: Int) {
        for y in 0..<gridHeight {
            for x in 0..<gridWidth {
                states[y][x] = state
            }
        }
    }

    // MARK: getting state

    /// get the state from an index
    func stateAt(index: Int) -> Int? {
        return stateAt(point: pointFor(index: index))
    }

    /// get the state at a given point
    func stateAt(point: Point) ->Int? {
        return stateAt(x: point.x, y: point.y)
    }

    /// get a single state value
    func stateAt(x: Int, y: Int) -> Int? {
        guard x >= 0, y >= 0, x < gridWidth, y < gridHeight else {
            return nil
        }
        return states[y][x]
    }

    /// get a state in a position one unit away in a given direction
    func state(inDirection: Direction, fromX x: Int, andY y: Int) -> Int? {
        switch inDirection {
        case .up:
            return stateAt(x: x, y: y-1)
        case .down:
            return stateAt(x: x, y: y+1)
        case .left:
            return stateAt(x: x-1, y: y)
        case .right:
            return stateAt(x: x+1, y: y)
        }
    }

    // MARK: index to point

    /// Get an index from a point
    func indexFor(point: Point) -> Int {
        guard point.x >= 0, point.x < gridWidth,
              point.y >= 0, point.y < gridHeight else {
            return -1
        }
        return (point.y * gridHeight) + point.x
    }

    /// Get a Point from an index
    func pointFor(index: Int) -> Point {
        guard index >= 0, index < gridCount else {
            return Point(x: -1, y: -1)
        }
        let y = index / gridHeight
        let x = index % gridHeight
        return Point(x: x, y: y)
    }

    // MARK: debug

    /// `toString` for debugging
    func toString() -> String {
        var string = "GGM_Game (\(type(of: self))) \n"
        string += "\(String(describing: states)) \n"
        string += "Game Over: \(isOver), Paused: \(isPaused)"
        return string
    }

    /// This exists to satisfy `CustomStringConvertible`, and allow you to
    /// `print("\(game)")` where game is an instance of `GGM_Game`.
    public var description: String {
        return toString()
    }
}
