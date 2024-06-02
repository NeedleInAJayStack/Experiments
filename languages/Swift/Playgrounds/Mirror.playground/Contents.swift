
struct Container {
    static let string1 = "string1"
    static let string2 = "string2"
    static let string3 = "string3"
}

Mirror.init(reflecting: Container.Type)
