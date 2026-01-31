import Foundation
import Testing


extension ConcurrencyExperimentTests {
    @Suite(.serialized)
    struct AsyncIteratorTests {
        @Test func forAwait() async throws {
            let stream = AsyncStream { continuation in
                for i in 1...5 {
                    usleep(1_000)
                    continuation.yield(i)
                }
                // We must call finish to signal the listener (and iterator) to stop awaiting
                continuation.finish()
            }

            var count = 0
            for await item in stream {
                // We can use vars across `for await` boundaries because they are in the same Task context
                count += 1
                #expect(count == item)
            }
        }

        @Test func asyncIteratorWhile() async throws {
            let stream = AsyncStream { continuation in
                for i in 1...5 {
                    usleep(1_000)
                    continuation.yield(i)
                }
                continuation.finish()
            }

            var count = 0

            // This is functionally the same as `for await`
            var iterator = stream.makeAsyncIterator()
            while let item = await iterator.next() {
                count += 1
                #expect(count == item)
            }
        }

        @Test func asyncStreamContinuationCancellation() async throws {
            let stream = AsyncStream<Int> { continuation in
                continuation.onTermination = { _ in
                    print("Task terminated")
                }
                for i in 1...5 {
                    usleep(1_000)
                    continuation.yield(i)
                }
                continuation.finish()
            }

            let task = Task {
                for await item in stream {
                    try Task.checkCancellation()
                    print(item)
                }
            }
            usleep(2_500)
            task.cancel()
        }
    }
}
