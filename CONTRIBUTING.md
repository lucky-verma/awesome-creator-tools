# Contribution Guidelines

Thank you for your interest in contributing to Awesome Creator Tools!

## Adding a New Tool

Please ensure your pull request adheres to the following guidelines:

### Requirements

- **Relevant**: The tool must be useful for content creators (YouTubers, streamers, podcasters, etc.). Tools aimed at app developers, agencies, or general business use are usually a poor fit even when they are good tools.
- **Established**: There should be evidence other people already use it. For open-source projects that means real stars, forks, or contributors and a history beyond the initial commit. A repository created in the same week as the pull request will be declined, however promising the idea is.
- **Maintained**: No archived repositories, and nothing that has gone roughly a year without a release or a commit.
- **Free to actually use**: A free tier, not a free trial. Time-limited trials and "eligible users may receive credits" do not count.
- **Official source**: Link the real product or repository. Reseller front ends that wrap somebody else's model, and organisation pages that are not the project repository, will be declined.
- **Stable home**: A product that asks people to sign in, and especially one that asks for OAuth access to a creator's account, needs its own domain rather than a free preview subdomain.
- **Description**: A concise description of what the tool does.
- **Correct Section**: Place the tool in the appropriate category.

### Descriptions

Describe what the tool does, not how impressive it is. Please avoid:

- Figures that go stale, such as free credit counts, user or customer totals, and integration counts. These are the first thing to rot in a list like this, and the maintainer has to strip them later.
- Superlatives that cannot be checked, such as "the only platform that…" or "outperforms X in blind tests".
- Name-dropping well-known creators as users unless the vendor says so publicly.

### Format

Use the following format:

```markdown
- [Tool Name](https://link-to-tool.com/) - Brief description of what the tool does.
```

- Keep descriptions short (under 100 characters ideally)
- End descriptions with a period
- No trailing whitespace
- Alphabetical order within sections (automated)

### Open Source Preference

We prefer open-source tools when available. For open-source projects:

```markdown
- [Tool Name](https://github.com/user/repo) - Brief description.
```

### What NOT to Submit

- Tools that are abandoned or unmaintained
- Tools with malware or security issues
- Duplicate entries
- Self-promotion without disclosure
- Tools behind excessive paywalls with no free tier
- Anything built on breaking another platform's terms: watermark strippers, bulk downloaders for other people's posts, bulk DM senders, and automated liking, following, or reposting
- Templates, spreadsheets, and single files. This is a list of tools
- Products whose main purpose is mass-producing low-effort content

### If You Made the Tool

Self-submissions are welcome, and plenty of good entries arrive that way. Say so in the pull request, and understand that the bar above still applies. The most common reason a self-submission is declined is not the disclosure, it is that the project is a week old with no users yet. That is not a permanent no. Come back once it has some traction.

## Creating a New Category

If you want to add a new category:

1. Ensure at least 3 tools would fit in the category
2. Add the category to the Table of Contents
3. Add a brief description of what the category covers

## Pull Request Process

1. Fork the repository
2. Create a new branch (`git checkout -b add-new-tool`)
3. Make your changes
4. Commit with a clear message (`git commit -m "Add ToolName to Video Editing"`)
5. Push to your fork (`git push origin add-new-tool`)
6. Open a Pull Request

## Automated Checks

Your PR will be automatically checked for:

- ✅ Valid awesome-list format (awesome-lint)
- ✅ Working links (link checker)
- ✅ Proper markdown formatting

Please fix any issues reported by the automated checks.

## Code of Conduct

- Be respectful and inclusive
- No spam or self-promotion without value
- Help maintain quality over quantity

## Questions?

Open an issue if you have questions or suggestions for improving the list.

Thank you for contributing! 🎉
