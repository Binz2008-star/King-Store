# King Store

Shopify storefront source for **King Store L.L.C.**

- Platform: Shopify
- Base theme: Shopify Sense 16
- Target market: UAE
- Primary brand palette: gold, rose-gold, cream, dark brown

## Theme branch

The active development branch is `theme/king-store-sense`.

The complete branded Sense ZIP is the canonical source for the theme import. The ZIP contains the full Shopify theme tree; it must not be replaced by the incomplete Dawn experiment.

### Brand system

- `assets/king-store-brand.css` — storefront styling and responsive brand system
- `assets/king-store-logo.svg` — scalable storefront logo
- `sections/king-store-hero.liquid` — branded homepage hero
- `templates/index.json` — homepage section order/configuration

## Importing the complete theme

The GitHub connector can create Git blobs/trees, but it cannot directly transfer a local ZIP's binary contents into those blobs. The safe solution is to perform the final ZIP-to-Git transfer on a machine that has the ZIP and Git authentication.

A PowerShell importer is included:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\import-sense-theme.ps1 -ZipPath "C:\path\to\King-Store-Sense-Branded-Theme(1).zip"
```

The script:

1. Fetches `theme/king-store-sense`.
2. Resets only that branch to its current remote state.
3. Extracts the complete ZIP.
4. Replaces the branch contents with the ZIP contents.
5. Creates one commit.
6. Pushes only `theme/king-store-sense`.

It does **not** modify `main` or `theme/king-store-dawn`.

## Shopify deployment

The repository is the source of truth for theme code. Production changes should be reviewed before publishing in Shopify.

Do not commit:

- Shopify access tokens
- API secrets
- payment credentials
- customer data
- private supplier credentials
