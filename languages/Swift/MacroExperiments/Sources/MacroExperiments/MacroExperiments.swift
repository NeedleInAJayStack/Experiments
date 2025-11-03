// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "MacroExperimentsMacros", type: "StringifyMacro")

@attached(member, names: named(printFive))
public macro canPrintFive() = #externalMacro(module: "MacroExperimentsMacros", type: "CanPrintFiveMacro")

@attached(member, names: named(printInt))
public macro printInt(_ int: Int) = #externalMacro(module: "MacroExperimentsMacros", type: "PrintIntMacro")

/// A macro that creates a basic type with a single `a` property. Due to Swift macro protections, this cannot be created
/// in a global scope.
@freestanding(declaration, names: arbitrary)
public macro basicType(named: String) = #externalMacro(module: "MacroExperimentsMacros", type: "BasicTypeMacro")
