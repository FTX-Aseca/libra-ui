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
          echo "Preparing release for version $NEXT_RELEASE_VERSION"
          # Update version in pubspec.yaml
          sed -i -E "s/^version: .*/version: $NEXT_RELEASE_VERSION/" pubspec.yaml
          echo "Updated pubspec.yaml to version $NEXT_RELEASE_VERSION"

          flutter clean
          flutter pub get

          echo "Building Android APK..."
          flutter build apk --release --build-name=$NEXT_RELEASE_VERSION --build-number=1
          APK_NAME="${appName}-$NEXT_RELEASE_VERSION.apk"
          if [ -f build/app/outputs/flutter-apk/app-release.apk ]; then
            mv build/app/outputs/flutter-apk/app-release.apk "$APK_NAME"
            echo "APK renamed to $APK_NAME"
          else
            echo "::error::APK not found after build!"
            exit 1
          fi

          echo "Building iOS IPA..."
          if [ ! -f "ios/ExportOptions.plist" ]; then
            echo "::error::ios/ExportOptions.plist not found. This is required for IPA export."
            echo "Create one with your signing configuration (e.g., ad-hoc, app-store)."
            exit 1
          fi
          flutter build ipa --release --export-options-plist=ios/ExportOptions.plist --build-name=$NEXT_RELEASE_VERSION --build-number=1
          IPA_NAME="${appName}-$NEXT_RELEASE_VERSION.ipa"
          BUILT_IPA_PATH=$(find build/ios/ipa -name '*.ipa' -type f | head -n 1)
          if [ -n "$BUILT_IPA_PATH" ] && [ -f "$BUILT_IPA_PATH" ]; then
            mv "$BUILT_IPA_PATH" "$IPA_NAME"
            echo "IPA renamed to $IPA_NAME"
          else
            echo "::error::IPA not found after build or multiple IPAs exist!"
            ls -R build/ios/ipa
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
          `${appName}-*.apk`,
          `${appName}-*.ipa`,
        ],
      },
    ],
  ],
}; 