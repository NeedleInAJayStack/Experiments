import Foundation
import Testing

extension ConcurrencyExperimentTests {
    @Suite(.serialized)
    struct ActorTests {
        @Test func actorReentrancy() async throws {
            actor Foo {
                var callEnterCount = 0
                var callExitCount = 0

                func call() async throws {
                    callEnterCount += 1
                    try await Task.sleep(for: .milliseconds(5))
                    callExitCount += 1
                }
            }

            let foo = Foo()
            async let _ = foo.call()
            async let _ = foo.call()
            async let _ = foo.call()

            usleep(1_000)

            // We entered `call` multiple times before the first one exited
            // That is, function access is not blocked once we use `await` inside the function
            await #expect(foo.callEnterCount == 3)
            await #expect(foo.callExitCount == 0)

            usleep(10_000)

            await #expect(foo.callEnterCount == 3)
            await #expect(foo.callExitCount == 3)
        }
    }
}
