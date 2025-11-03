import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}

/// Adds a `printFive()` function to any type, that when called will print `five`
public struct CanPrintFiveMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        return ["""
        func printFive() {
            print("five")
        }
        """]
    }
}

/// Adds a `printInt()` function to any type, that when called will print `five`
public struct PrintIntMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let argument = node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return ["""
        func printInt() {
            print("\(argument)")
        }
        """]
    }
}

/// Creates a basic type with the name passed that has a single string member named `a`
public struct BasicTypeMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let argument = node.arguments.first?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return ["""
        struct \(raw: argument) {
            let a: String
        }
        """]
    }
}

@main
struct MacroExperimentsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        CanPrintFiveMacro.self,
        PrintIntMacro.self,
        BasicTypeMacro.self,
    ]
}
