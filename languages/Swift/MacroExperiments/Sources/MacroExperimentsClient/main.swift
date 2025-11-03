import MacroExperiments

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

@canPrintFive
struct Foo {}

let foo = Foo()
foo.printFive()
