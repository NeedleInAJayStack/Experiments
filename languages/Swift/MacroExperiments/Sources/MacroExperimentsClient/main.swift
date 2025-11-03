import MacroExperiments

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

@canPrintFive
struct Foo {}
Foo().printFive()

@printInt(42)
struct Bar {}
Bar().printInt()
