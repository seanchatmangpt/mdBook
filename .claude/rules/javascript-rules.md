---
paths:
  - "**/*.js"
  - "**/*.mjs"
---

# JavaScript Rules for mdBook

## Code Style

### ESLint Compliance
- All JavaScript must pass `npm run lint`
- Follow the project's eslint.config.mjs
- No disabling rules without justification

### Formatting
- Use consistent indentation (2 spaces)
- Use semicolons
- Use single quotes for strings

## Browser Compatibility

### Supported Browsers
- Chrome, Firefox, Safari, Edge (current and recent versions)
- iOS Safari, Android Chrome
- No IE11 support required

### Best Practices
- Avoid cutting-edge features without fallbacks
- Test in multiple browsers
- Consider mobile viewports
- Use feature detection, not browser detection

## DOM Manipulation

### Prefer Modern APIs
```javascript
// Good
document.querySelector('.chapter');
element.classList.add('active');
element.addEventListener('click', handler);

// Avoid
document.getElementsByClassName('chapter')[0];
element.className += ' active';
element.onclick = handler;
```

### Event Handling
- Use event delegation when appropriate
- Remove event listeners when no longer needed
- Handle keyboard navigation (accessibility)

## Security

### XSS Prevention
- Use `textContent` instead of `innerHTML` when possible
- Escape user content before DOM insertion
- Validate URLs before navigation

### No Dangerous Patterns
- No `eval()`
- No `new Function()`
- No inline event handlers with dynamic data

## Performance

### Loading
- Defer non-critical JavaScript
- Minimize blocking scripts
- Use async for independent scripts

### Runtime
- Avoid layout thrashing
- Batch DOM updates
- Use requestAnimationFrame for animations

## Accessibility

### Keyboard Support
- All interactive elements must be keyboard accessible
- Use proper focus management
- Provide skip links

### ARIA
- Use semantic HTML first
- Add ARIA attributes when needed
- Test with screen readers
