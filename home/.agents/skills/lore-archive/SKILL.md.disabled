---
name: lore-archive
description: "Process URLs from inbox scrolls, create structured knowledge entries with captures, categorize into appropriate archives"
---

# Lore Archive

*Forging knowledge from the streams of the realm*

The Lore Archive is tasked

## When to Invoke

Summon this skill when:
- Ancient scrolls (inbox files) contain URLs to be catalogued
- Knowledge fragments need to be forged into permanent records
- Visual captures (screenshots) must be preserved in the archives
- Content requires sorting into proper archive chambers

## Inbox Scroll Format

The inbox scroll contains knowledge fragments marked with rune-identifiers:

```
#RUNE:https://example.com/url
```

Common scroll types:
- **X Scrolls** (x.com URLs) - messages from the social realm
- **GitHub Tomes** (github.com URLs) - code grimoires
- **Blog Codices** (blog/article URLs) - wisdom from the web
- **Research Tomes** (arxiv.org, papers) - scholarly knowledge

## Archive Chamber Assignment

| Scroll Type | Archive Chamber |
|-------------|-----------------|
| ML/AI X Scrolls | `ML/x_threads/` |
| Agent-related X Scrolls | `ML/Agents/x_threads/` |
| Research Tomes | `ML/Papers/` or `ML/x_threads/` |
| GitHub Tomes (Agents) | `ML/Agents/Repos/` |
| GitHub Tomes (ML/Other) | `ML/Repos/` |
| Productivity/Business | `programming/Blogs/` |
| Programming Scrolls | `programming/Blogs/` |

## Knowledge Entry Template

```markdown
---
type: X_Post | GitHub_Repo | Blog_Post
source_url: https://...
date_saved: YYYY-MM-DD
tags: #...

 Key Insight
[1-2 sentence summary]

 Why Useful
[Context for your projects]

 Screenshot
![](./static_assets/[identifier]_screenshot.png)
```

## Ritual of Processing

### Phase 1: Reading the Scroll
- Peruse the inbox scroll to understand its contents
- Identify scroll types from URLs and context

### Phase 2: For Each Fragment

For each URL to be catalogued:

1. **Summon** - Use puppeteer to conjure the URL
2. **Extract** - Gather the essence (content summary, key insights)
3. **Capture** - Preserve a visual记忆 (screenshot) to `static_assets/`
4. **Chamber** - Determine the correct archive location
5. **Inscribe** - Create the markdown record using the template

### Phase 3: Visual Preservation

Screenshots are stored in the archives with mystical naming:
- X Scrolls: `static_assets/x_[rune]_screenshot.png`
- GitHub Tomes: `static_assets/gh_[tome-name]_screenshot.png`
- Blog Codices: `static_assets/blog_[codex-name]_screenshot.png`

### Phase 4: Updating the Scroll

After cataloguing, inscribe the inbox scroll with completion markers:
- Add checkmarks or mark as processed
- Inscribe the path to each created record

## Tools of the Trade

- **puppeteer**: Conjure URLs, extract knowledge, capture visions
- **read**: Peruse inbox scrolls and existing records
- **write**: Inscribe new knowledge entries
- **bash**: Navigate the file kingdom

## Verification Rite

Before declaring the ritual complete, verify:
- [ ] Each URL has a corresponding knowledge entry
- [ ] Each X scroll has a visual记忆 in the archives
- [ ] Entries follow the sacred template format
- [ ] Inbox scroll bears the mark of completion
- [ ] Content resides in its proper chamber

## Example Transformation

Inbox scroll:
```
#WX:https://x.com/user/status/123456
#JV:https://github.com/user/repo
```

Becomes inscribed records:
- `ML/x_threads/x_WX.md` + `static_assets/x_WX_screenshot.png`
- `ML/Repos/gh_repo.md` + `static_assets/gh_repo_screenshot.png`

## Edge Cases & Dark Paths

- **Private/Guarded URLs**: Mark as inaccessible, continue the ritual
- **Broken Scrolls (404)**: Note the failure, proceed to next fragment
- **Duplicate Runes**: Append suffix (x_WX_2.md)
- **Vanishing Visions**: Use fetch to retrieve content, note capture unavailable
