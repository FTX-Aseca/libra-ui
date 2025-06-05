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