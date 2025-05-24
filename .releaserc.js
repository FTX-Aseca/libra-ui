const appName = process.env.APP_NAME || 'app'; // Or your specific app name

module.exports = {
  branches: [
    'main',
    { name: 'dev', prerelease: 'dev' }, // Example: dev branch for dev pre-releases
  ],
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    '@semantic-release/changelog',
    [
      '@semantic-release/exec',
      {
        prepareCmd: `
          echo "Preparing release for version ${nextRelease.version}"
          # Update version in pubspec.yaml
          # This sed command assumes version: x.y.z or version: x.y.z+build
          # It will replace it with the new version x.y.z (semantic-release manages the full version)
          sed -i -E "s/^version: .*/version: ${nextRelease.version}/" pubspec.yaml
          echo "Updated pubspec.yaml to version ${nextRelease.version}"

          flutter clean
          flutter pub get

          # Build Android APK
          # semantic-release sets NEXT_RELEASE_VERSION which Flutter can use for build-name
          # semantic-release also sets NEXT_RELEASE_GIT_TAG for build-number if needed, but Flutter typically auto-increments or uses Git commit count.
          # For simplicity, we'll let Flutter manage build numbers or set a fixed one for the release build if not specified.
          echo "Building Android APK..."
          flutter build apk --release --build-name=${nextRelease.version} --build-number=1 # You might want a more dynamic build number
          # Rename APK to include version for clarity in release assets
          # Default path: build/app/outputs/flutter-apk/app-release.apk
          if [ -f build/app/outputs/flutter-apk/app-release.apk ]; then
            mv build/app/outputs/flutter-apk/app-release.apk ${appName}-${nextRelease.version}.apk
            echo "APK renamed to ${appName}-${nextRelease.version}.apk"
          else
            echo "::error::APK not found after build!"
            exit 1
          fi

          # Build iOS IPA
          # Ensure you have an ExportOptions.plist in your ios/ directory
          # and your Xcode project is set up for signing.
          echo "Building iOS IPA..."
          # Check for ExportOptions.plist
          if [ ! -f "ios/ExportOptions.plist" ]; then
            echo "::error::ios/ExportOptions.plist not found. This is required for IPA export."
            echo "Create one with your signing configuration (e.g., ad-hoc, app-store)."
            exit 1
          fi
          flutter build ipa --release --export-options-plist=ios/ExportOptions.plist --build-name=${nextRelease.version} --build-number=1
          # Rename IPA
          # Default path: build/ios/ipa/<YourProjectName>.ipa
          # This assumes the IPA is the only .ipa file in build/ios/ipa/
          BUILT_IPA_PATH=$(find build/ios/ipa -name '*.ipa' -type f | head -n 1)
          if [ -n "$BUILT_IPA_PATH" ] && [ -f "$BUILT_IPA_PATH" ]; then
            mv "$BUILT_IPA_PATH" ${appName}-${nextRelease.version}.ipa
            echo "IPA renamed to ${appName}-${nextRelease.version}.ipa"
          else
            echo "::error::IPA not found after build or multiple IPAs exist!"
            ls -R build/ios/ipa # List contents for debugging
            exit 1
          fi
        `,
      },
    ],
    [
      '@semantic-release/git',
      {
        assets: ['CHANGELOG.md', 'pubspec.yaml'],
        message: 'chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}',
      },
    ],
    [
      '@semantic-release/github',
      {
        assets: [
          { path: `${appName}-${nextRelease.version}.apk`, label: 'Android APK' },
          { path: `${appName}-${nextRelease.version}.ipa`, label: 'iOS IPA' },
        ],
      },
    ],
  ],
}; 