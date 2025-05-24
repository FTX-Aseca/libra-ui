# Pull Request Template

## Description
_Please include a concise summary of the changes introduced and the rationale behind them._

**Related issue:** Closes #[issue number]

---

## Validation Checklist

- [ ] **Builds successfully**: Project builds without errors (`flutter build apk && flutter build ios`).
- [ ] **All widget tests pass**: Ensure there are no regressions in UI logic.
- [ ] **Acceptance criteria met**: All acceptance criteria for the related issue(s) have been implemented and verified.
- [ ] **No lint/static analysis warnings**: Dart analyzer (`flutter analyze`) reports no new issues.
- [ ] **Environment variables documented**: README or `.env` files include new configuration properties.
- [ ] **Relevant backend services (if any) are operational**: e.g., via Docker Compose.
- [ ] **README/CHANGELOG updated**: Describes changes and testing instructions.
- [ ] **Peer review completed**: Feedback from at least one teammate has been incorporated.

---

## How to Test the Changes
_Provide brief steps to set up the environment and verify the introduced changes._

1. `git checkout -b feature/your-feature`
2. `flutter pub get`
3. `flutter analyze`
4. `flutter test`
5. `flutter run` (on an emulator/device)
6. _Verify specific functionality related to the changes..._

---

> Thank you for your contribution! Please ensure all items above are complete before requesting a review.

