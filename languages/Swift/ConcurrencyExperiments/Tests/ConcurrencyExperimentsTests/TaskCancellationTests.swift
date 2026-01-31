import Foundation
import Testing

extension ConcurrencyExperimentTests {
    @Suite(.serialized)
    struct TaskCancellationTests {
        @Test func taskSleepCancellation() async throws {
            let counter = Counter()
            let task = Task {
                for _ in 1...5 {
                    try await Task.sleep(for: .milliseconds(2))
                    await counter.increment()
                }
            }
            try await Task.sleep(for: .milliseconds(5))
            task.cancel()
            // We throw a cancellation error after counting to 2 because Task.sleep checks for cancellation
            await #expect(throws: CancellationError.self) {
                try await task.value
            }
            await #expect(counter.value == 2)
        }

        @Test func taskCancellation() async throws {
            let counter = Counter()
            let task = Task {
                for _ in 1...5 {
                    try await Task.sleep(for: .milliseconds(2))
                    try Task.checkCancellation()
                    await counter.increment()
                }
            }
            try await Task.sleep(for: .milliseconds(5))
            task.cancel()
            // We throw a cancellation error after counting to 3 because we check for cancellation manually
            await #expect(throws: CancellationError.self) {
                try await task.value
            }
            await #expect(counter.value == 2)
        }

        @Test func taskNoCancellation() async throws {
            let counter = Counter()
            let task = Task {
                for _ in 1...5 {
                    try await Task.sleep(for: .milliseconds(2))
                    await counter.increment()
                }
            }
            try await Task.sleep(for: .milliseconds(5))
            task.cancel()
            // We do not throw a cancellation error because we don't check for cancellation
            await #expect(throws: Never.self) {
                try await task.value
            }
            // We count all the way to 5 even though we cancelled because we didn't check
            await #expect(counter.value == 5)
        }

        @Test func unownedTasks() async throws {
            let counter = Counter()
            Task {
                for _ in 1...5 {
                    usleep(2_000)
                    await counter.increment()
                }
            }
            // An unowned Task just runs in the background until it finishes
            try await Task.sleep(for: .milliseconds(5))
            await #expect(counter.value == 2)
            try await Task.sleep(for: .milliseconds(7))
            await #expect(counter.value == 5)
            try await Task.sleep(for: .milliseconds(3))
            await #expect(counter.value == 5)
        }
    }
}

actor Counter {
    var value = 0
    func increment() {
        value += 1
    }
}
