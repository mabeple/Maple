# AGENTS Guide For Maple

## Repository Summary

Maple is a Swift utility library composed mainly of extensions for Foundation, UIKit, SwiftUI, CoreGraphics, and Swift standard library types. The package is organized as a single library target and uses a namespaced extension model built around `mp`.

Primary references:

- [`Package.swift`](Package.swift)
- [`README.md`](README.md)
- [`Sources/General/Maple.swift`](Sources/General/Maple.swift)

## Environment And Support

- Swift tools version: `6.0`
- Supported platforms: `iOS 15+`, `macOS 12+`
- Distribution: Swift Package Manager and CocoaPods
- Test framework: `swift-testing`
- Concurrency setting: `StrictConcurrency=complete`

## What Matters Most

The most important implementation detail in this repository is the wrapper pattern:

- `MapleCompatible` for class types
- `MapleCompatibleValue` for value types
- `MapleWrapper<Base>` as the namespace carrier
- `mp` as the public access point

Most feature work should preserve and extend this pattern rather than bypass it.

## Directory Map

- `Sources/General`: namespace wrapper and compatibility protocols
- `Sources/Foundation`: Foundation extensions
- `Sources/SwiftStdlib`: standard library and protocol-based extensions
- `Sources/CoreGraphics`: geometry and scalar helpers
- `Sources/UIKit`: UIKit-only APIs
- `Sources/SwiftUI`: SwiftUI-specific APIs
- `Sources/Shared`: cross-platform helpers such as `MPCrossPlatformColor`
- `Sources/Protocol`: protocol conveniences
- `Sources/Runtime`: Objective-C runtime utilities
- `Tests/`: mirrored test structure using Swift Testing

## Implementation Rules

When editing or adding code:

- keep files in the existing domain folders
- follow the `TypeExtensions.swift` naming pattern
- default to `public extension MapleWrapper where Base == Type`
- use protocol-constrained wrappers when the existing module already works that way
- add compatibility conformance explicitly when required
- keep platform guards aligned with current usage
- avoid new external dependencies
- preserve public API names and semantics unless a breaking change is explicitly requested

## Comment Rules

- add concise doc comments for public APIs when introducing or changing them
- keep implementation comments minimal and only use them where behavior, constraints, or edge cases are not obvious from the code
- do not add redundant comments that simply restate the code

## Testing Rules

This repository uses `swift-testing`.

- use `@Suite` for each extension group
- use `@Test("...")` with descriptive names
- use `#expect(...)` for assertions
- mirror the source layout in `Tests/`
- add edge-case tests, not just happy-path tests

Typical verification:

```bash
swift test --parallel
```

Useful wrappers already exist in:

- [`Tests/General/MapleWrapperTests.swift`](Tests/General/MapleWrapperTests.swift)
- [`Tests/Foundation/DateExtensionTests.swift`](Tests/Foundation/DateExtensionTests.swift)
- [`Tests/UIKit/UIImageExtensionTests.swift`](Tests/UIKit/UIImageExtensionTests.swift)

## Commands

Repository commands from [`Makefile`](Makefile):

```bash
make test
make coverage
make docs
make preview
make lint
make clean
```

Release flow from [`fastlane/Fastfile`](fastlane/Fastfile):

- branch must be `master`
- worktree must be clean
- podspec version is bumped during release
- release publishes to CocoaPods and optionally creates a GitHub release

## Risks To Watch

- Date and calendar helpers can become timezone- or locale-sensitive
- UIKit and Shared modules often need platform guards to remain buildable on macOS
- Color helpers rely on `cgColor.components` assumptions; be cautious changing component logic
- This package enables strict concurrency checks, so avoid adding code that weakens compile-time guarantees

## Preferred Agent Workflow

1. Read the target source file and the matching test file.
2. Confirm whether the type should participate in the `mp` wrapper model.
3. Implement the smallest coherent change.
4. Add or update tests in the same turn.
5. Run targeted verification, then `swift test --parallel` when the change is broad enough.
6. If the public surface changed, consider updating `README.md` and docs-related guidance.
