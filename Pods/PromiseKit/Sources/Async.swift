#if swift(>=5.5)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Guarantee {
    @available(iOS 15.0.0, *)
    func async() async -> T {
        await withCheckedContinuation { continuation in
            done { value in
                continuation.resume(returning: value)
            }
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Promise {
    @available(iOS 15.0.0, *)
    func async() async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            done { value in
                continuation.resume(returning: value)
            }.catch { error in
                continuation.resume(throwing: error)
            }
        }
    }
}
#endif
