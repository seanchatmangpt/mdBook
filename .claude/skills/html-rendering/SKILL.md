---
name: html-rendering
description: Expert HTML rendering for mdBook. Use when working with HTML templates, themes, JavaScript, CSS, Handlebars templates, or browser compatibility issues.
allowed-tools: ["Read", "Edit", "Write", "Grep", "Glob", "Bash"]
---

# HTML Rendering Skill for mdBook

You are an expert in mdBook's HTML rendering system.

## Architecture Overview

### mdbook-html Crate
- Internal crate (not semver stable)
- Generates static HTML from book content
- Uses Handlebars templating
- Includes search functionality (optional feature)

## Theme System

### Default Theme Files
```
theme/
├── index.hbs          # Main HTML template
├── head.hbs           # <head> content
├── header.hbs         # Page header
├── css/
│   ├── general.css
│   ├── chrome.css
│   ├── print.css
│   └── variables.css
├── book.js            # Main JavaScript
├── highlight.js       # Syntax highlighting
└── fonts/             # Font files
```

### Customizing Themes
Users can override by placing files in `theme/` directory of their book.

## Handlebars Templates

### Available Variables
```handlebars
{{title}}              <!-- Book title -->
{{path_to_root}}       <!-- Relative path to root -->
{{content}}            <!-- Chapter content -->
{{chapter_title}}      <!-- Current chapter title -->
{{previous}}           <!-- Previous chapter link -->
{{next}}               <!-- Next chapter link -->
```

### Partials
```handlebars
{{> head}}
{{> header}}
```

## JavaScript Components

### Search System
- Uses elasticlunr for indexing
- Search index generated at build time
- Keyboard shortcut: `s` to focus

### Theme Switcher
- Light, Rust, Coal, Navy, Ayu themes
- Persisted in localStorage

### Sidebar Navigation
- Collapsible chapters
- Keyboard navigation
- Mobile-responsive

## CSS Architecture

### CSS Variables
```css
:root {
    --bg: #fff;
    --fg: #333;
    --sidebar-bg: #fafafa;
    --sidebar-fg: #333;
}
```

### Print Styles
- Optimized for printing
- Removes navigation elements
- Proper page breaks

## Browser Compatibility

### Supported Browsers
- Chrome, Firefox, Safari, Edge
- Windows, macOS, Linux, iOS, Android
- Keep compatible with recent versions

### Best Practices
- Avoid cutting-edge CSS features
- Test in multiple browsers
- Provide fallbacks
- Consider mobile viewports

## Security Considerations

### XSS Prevention
- Escape all user content
- Use Handlebars' automatic escaping
- Be careful with `{{{triple-braces}}}`

### Content Security
- No inline event handlers
- Careful with dynamic script loading
