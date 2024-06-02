import Foundation

Measurement(value: 5, unit: UnitLength.feet)

// Conversion
Measurement(value: 5, unit: UnitLength.feet).converted(to: UnitLength.inches)
Measurement(value: 5, unit: UnitLength.feet).converted(to: UnitLength.baseUnit())
let handsToMeters = UnitConverterLinear.init(coefficient: 0.1015999967488)
Measurement(value: 10, unit: UnitLength.init(symbol: "hands", converter: handsToMeters)).converted(to: UnitLength.meters)
Measurement(value: 1, unit: UnitLength.init(symbol: "hands", converter: handsToMeters)).converted(to: UnitLength.inches)

// Arithmatic
Measurement(value: 5, unit: UnitLength.feet) + Measurement(value: 3, unit: UnitLength.feet)
Measurement(value: 5, unit: UnitLength.feet) + Measurement(value: 3, unit: UnitLength.inches)
Measurement(value: 5, unit: UnitLength.feet) + Measurement(value: 3, unit: UnitLength.meters)
  // Silently computed as if kilograms was meters
Measurement(value: 5, unit: UnitLength.feet) + Measurement(value: 3, unit: UnitMass.kilograms)

Measurement(value: 5, unit: UnitLength.feet) - Measurement(value: 3, unit: UnitLength.feet)
Measurement(value: 5, unit: UnitLength.feet) - Measurement(value: 2, unit: UnitLength.inches)

Measurement(value: 5, unit: UnitLength.feet) * 5
  // Error: Not possible
//Measurement(value: 5, unit: UnitLength.feet) * Measurement(value: 3, unit: UnitMass.kilograms)
Measurement(value: 5, unit: UnitLength.feet) / 5
// This is incorrect - It should be a unit of 1/feet
5 / Measurement(value: 5, unit: UnitLength.feet)

// Comparison
Measurement(value: 3, unit: UnitLength.feet) == Measurement(value: 3, unit: UnitLength.feet)
Measurement(value: 3, unit: UnitLength.feet) != Measurement(value: 5, unit: UnitLength.feet)
Measurement(value: 3, unit: UnitLength.feet) != Measurement(value: 3, unit: UnitLength.inches)
// Unit conversion is not performed automatically on equality checks
Measurement(value: 3, unit: UnitLength.feet) == Measurement(value: 36, unit: UnitLength.inches)

Measurement(value: 1, unit: UnitLength.feet) < Measurement(value: 3, unit: UnitLength.feet)
// Unit conversion is performed on > and <
Measurement(value: 1, unit: UnitLength.feet) > Measurement(value: 3, unit: UnitLength.inches)


// Findings:
// Conversion between two units of the same dimension result in a measurement using the base unit

// Issues:
// - Cross-dimensional multiplication/division is not permitted
// - Type checked arithmatic is not possible (is this due to an operator `throwing` limitation?)
// - Scalar division results in an incorrect unit
// - Unit conversion is not performed on equality checks

