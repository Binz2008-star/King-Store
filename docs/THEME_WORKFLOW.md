# King Store Theme Workflow

## Branching

- `main`: stable branch
- `theme/king-store-sense`: active Shopify theme development

## Safe change flow

1. Make a focused theme change.
2. Commit it to the feature/theme branch.
3. Validate Liquid, JSON, CSS and responsive behavior.
4. Open a pull request to `main`.
5. Review the diff.
6. Publish the reviewed theme through Shopify.

## Current branded changes

The branch currently contains the King Store brand layer:

- responsive gold/rose-gold/cream visual system
- King Store homepage hero
- scalable SVG logo
- updated homepage configuration
- project documentation

## Production safety

Never commit credentials, customer data, Shopify access tokens, payment details, or private supplier credentials.
