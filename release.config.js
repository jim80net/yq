module.exports = {
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    [
      "@semantic-release/changelog",
      {
        "changelogFile": "CHANGELOG.md"
      }
    ],
    [
      "semantic-release-rubygem",
      {
        "gemFileDir": "."
      }
    ],
    [
      "@semantic-release/git",
      {
        "assets": [
          "CHANGELOG.md"
        ],
        "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
      }
    ],
    [
      "@semantic-release/github",
      {
        "assets": [
          {
            "path": "yq.zip",
            "name": "yq.${nextRelease.version}.zip",
            "label": "Full zip distribution"
          },
          {
            "path": "yq-*.gem",
            "label": "Gem distribution"
          }
        ]
      }
    ],
  ]
};
