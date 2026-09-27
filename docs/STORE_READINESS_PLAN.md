# King Store — Store Readiness / Catalog Plan

Status: **DRAFT for owner review** · Prepared 2026-09-27 · No Shopify changes were made to produce this document.

All store facts below were read (read-only) from the Shopify Admin API for `m7f00g-vv.myshopify.com` on 2026-09-27. Where the handoff brief and the live store disagree, the live store is reported and the difference is flagged.

---

## 0. Headline findings (read first)

The handoff brief says the store has **zero products** and little business content. **That is no longer true.** Between 15:13 and 15:23 UTC today, someone created products and policies directly in Shopify. The store is further along than the brief says, but it now has **inconsistencies that must be fixed before any launch**:

| # | Finding | Severity |
|---|---------|----------|
| F1 | **4 products exist** (status ACTIVE, but published to **0 sales channels**, so customers can't see them). One is a **duplicate** (Moroccan black soap is listed twice). | High |
| F2 | **Confirmed by owner (2026-09-27): products were imported with DSers (AliExpress dropshipping).** SKUs (e.g. `200009122:100015911#2pcs`) are AliExpress variant IDs, and stock counts (514, 268) are supplier stock, not King Store stock. | High |
| F3 | The Terms of Service promise **"delivery within the UAE in 1–2 business days"**. Cross-border dropshipping can't reliably meet that. | Critical |
| F4 | Shipping promises disagree: the ToS says **AED 15, free over AED 150**. The actual rates are **AED 25** plus a second **AED 0** rate with the same name ("قياسي"). An **International zone (27 countries, AED 70)** is also active even though the business is UAE-only. | High |
| F5 | The business address disagrees: the policies say **Abu Dhabi**, the store address says **Dubai**, the location is named **"Ajman"**, and the privacy policy says **"Ajman, dubai DU"**. | High |
| F6 | The Legal Notice has **unfilled placeholders** (trade licence number, TRN) and an **example email that isn't real** (`support@king-store.com`). The public contact email is a personal Gmail address. | Critical (must not go live) |
| F7 | Product copy makes **claims that can't be verified and are regulated**: skin "whitening / lightening" (تفتيح), "100% natural", "results from the first use", bee-venom "reduces pigmentation". None have supporting documentation. | Critical (regulatory) |
| F8 | **Language mismatch**: English is the only published language and Arabic is installed but **unpublished**. Every product and most policies are written in **Arabic**, while the theme hero is in **English**. The draft theme was never QA'd in Arabic/RTL. | High |
| F9 | Two active Markets cover the same country (`uae` and `United Arab Emirates` / `ae`). | Medium |
| F10 | Product data is incomplete: no product type, no tags, no SEO fields, **no image alt text** (33 images), one variant has no SKU, no barcodes, and handles are long Arabic URL-encoded strings. | Medium |
| F11 | The theme branch head is **`fbc3e3d`** (hero richtext `<p>` fix), which is one commit newer than the `b76686b` recorded in the handoff. Confirm draft `188510142663` was pushed from `fbc3e3d`. | Low |

What still matches the brief: the live theme `188507160775` is unchanged and still lacks `templates/index.*`. The draft `188510142663` is still unpublished. Store currency is AED, the plan is Basic, the timezone is +04 and the country is AE.

---

## 1. Current verified state

| Area | Verified state |
|------|----------------|
| Plan / currency / country | Basic · AED · United Arab Emirates · UTC+4 |
| Live theme | `king-store-sense-branded-theme` (188507160775). Homepage returns 404 (no index template). **Do not touch.** |
| Draft theme | `king-store-sense-preview-20260926-2130` (188510142663). Unpublished. Branded Sense, 351 files, Theme Check 0 errors. |
| Git | `theme/king-store-sense` @ `fbc3e3d`. `main` holds only the init commit. |
| Products | 4 (1 duplicate), all ACTIVE, **0 channel publications** |
| Collections | 1 (`frontpage` / "Home page") holding 1 product (argan serum) |
| Pages | Contact (published) |
| Policies | Contact info, Legal notice, Privacy (Shopify template), Refund (custom, Arabic), Terms (custom, Arabic). **No Shipping policy.** |
| Markets | 2 active (duplicate UAE) |
| Shipping | General profile: Domestic AE (AED 25 + AED 0 "Standard"), International 27 countries AED 70 |
| Locations | 1 ("Ajman", city recorded as dubai) |
| Languages | en (primary, published), ar (unpublished) |
| Payments / COD / taxes / notifications | **Not verified.** The API scopes available here don't expose them. The owner should check them in Admin → Settings. |

## 2. Already complete

- Branded Sense theme, statically QA'd (Theme Check 0 errors; JSON, reference and asset checks pass).
- Brand palette and hero copy.
- AED currency and an active UAE market.
- The live-theme 404 root cause is identified (missing index template on the live theme only).
- First drafts of Refund, Terms, Contact and Legal policies (in Arabic). These need correction; see F3–F6.
- A first product direction exists in practice: Moroccan hair and body care (argan serum, black soap, bee-venom cream).

## 3. Missing / must fix

1. **Owner decisions** (section 6). Nothing below can be finalised without them.
2. **Sourcing confirmation** and a fulfilment model that is consistent with the delivery promises.
3. **Regulatory status of cosmetic products** (section 7).
4. **Real business identity data**: trade licence number and issuing emirate, registered address, support email on a business domain or a dedicated mailbox, TRN if VAT-registered.
5. **Shipping policy page.** Correct shipping rates, remove or justify the International zone, merge the duplicate markets.
6. **Language strategy**, plus Arabic/RTL QA of the draft theme.
7. **Product data completion**: types, tags, SKUs, alt text, SEO fields, handles, compliant descriptions. Remove the duplicate product.
8. **Collections and navigation.**
9. **Payment and COD configuration**, and order notifications.
10. **End-to-end test order** using Shopify's test/Bogus gateway, never a real card.

## 4. Recommended initial catalog structure

**Recommendation: launch narrow. One category, 8–15 SKUs, not a general "beauty, fashion and lifestyle" store.**

Why:
- The only real products are **Moroccan hair and body care**. That is a clear, differentiated niche that resonates in the UAE (hammam rituals, argan oil, hijab-friendly hair care).
- Fashion needs sizing, returns handling, and far more SKUs and photography. A mixed catalog of 4–15 SKUs looks empty and weakens trust.
- Low weights (0.12–0.4 kg) suit courier shipping.
- Each extra category brings its own compliance burden (cosmetics, textiles, electronics).

Proposed launch structure (**maximum 5 collections**):

| Collection | Type | Contents |
|------------|------|----------|
| Hair Care / العناية بالشعر | Custom or smart (product type) | Argan serum, hair oils/masks |
| Body & Hammam / الحمام المغربي | Custom or smart | Black soap, kessa glove, ghassoul, body scrubs |
| Face Care / العناية بالبشرة | Custom. **Only after F7 is resolved** | Moisturisers etc. **No whitening claims.** |
| Sets & Bundles / مجموعات | Custom | Hammam kit, 2-pack offers (replaces "2pcs" variants over time) |
| New Arrivals / وصل حديثاً | Smart (by created date or tag) | Automatic |

Deferred until the first category proves demand: fashion, accessories, lifestyle.

**Brand-copy consequence:** the hero currently says "beauty, style and lifestyle". If the owner accepts the narrow launch, the hero body copy should later be adjusted to match. That is a content-only edit in the Theme Editor on the draft theme and **requires owner approval**.

**Product-specific recommendation:** do **not** launch the bee-venom "whitening" cream (كريم سم النحل للتفتيح) until it has registration or documentation. Skin-lightening products are a known regulatory and health-risk category. If kept, remove all whitening/lightening claims.

## 5. Product sourcing options

| Model | Startup cost | Margin | Delivery speed to UAE customer | Inventory risk | QC | Branding | UAE suitability |
|-------|-------------|--------|-------------------------------|----------------|----|----------|-----------------|
| **A. Cross-border dropshipping** (AliExpress/CJ etc.) — *what the SKUs indicate today* | Very low | Medium–low after shipping and COD losses | **Slow (typically 7–20+ days)**. Contradicts the current "1–2 days" promise. | None | **Weak**. You never see the product. | Weak (generic packaging) | **Poor for cosmetics.** Imported cosmetics are unregistered and hard to back with claims. COD refusals are costly. |
| **B. Bulk import + local stock** (small MOQ from verified manufacturer, e.g. Moroccan cooperative/exporter) | Medium (stock + registration fees) | **High** | Fast (1–2 days via local courier) | Medium | Strong (you inspect every batch) | Medium–high | **Good**, and this route supports registration. |
| **C. Local UAE wholesaler / distributor** of already-registered brands | Low–medium | Medium | Fast | Low–medium (smaller MOQs) | Good (registered goods) | Low (reseller) | **Very good.** Lowest compliance risk. |
| **D. Private label** (own "King Store" branded argan/black-soap line) | High (MOQ, packaging, registration) | Highest | Fast once stocked | High | Strong | **Highest** | Good long-term. Phase 2+. |
| **E. Local 3PL fulfilment** (combined with B, C or D) | Low setup + per-order fees | — | Fast, handles COD collection | — | — | — | Recommended once volume is over ~5 orders/day |
| Print-on-demand / affiliate | — | — | — | — | — | — | Not a fit for this niche |

**Recommendation:** **C now, with B/D later.** Launch with registered products from a UAE distributor or wholesaler, held in stock locally (small quantities). Validate demand, then move best-sellers to direct import (B) and eventually private label (D). If the owner wants to continue with A, then **every delivery promise, the refund policy and all product claims must be rewritten** to match cross-border reality, and the cosmetics registration question must be answered first.

No supplier has been chosen or contacted. That decision belongs to the owner.

### 5a. DSers-specific actions (owner confirmed DSers on 2026-09-27)

Staying on DSers is a legitimate way to test demand, but the store must stop promising what AliExpress fulfilment can't deliver. Before launch:

1. **Check each product in DSers:** ship-from country, shipping method and its quoted delivery time to the UAE, and landed cost (product + shipping). Record these per SKU. Some AliExpress listings ship from a local or regional warehouse and many ship from China. The delivery promise must follow the slowest product in the catalog.
2. **Rewrite the delivery promises to match** the quoted times, in the ToS, the new Shipping policy and product pages. Remove "1–2 business days" unless every SKU ships from inside the UAE.
3. **Remove the duplicate black soap product safely.** In DSers, first confirm which of the two Shopify products (`…-100غ` or `…-100غ-1`) is mapped to the AliExpress supplier. Delete only the unmapped one, otherwise orders will stop routing. This needs owner approval because it is a delete.
4. **Treat inventory as supplier stock.** DSers syncs AliExpress stock into Shopify, so the numbers can change, and a supplier can go out of stock or delist a product without warning. Enable DSers' out-of-stock/delist notifications and keep a backup supplier for each best-seller.
5. **Price for real margins.** For each SKU: retail (AED, VAT-inclusive if registered) − AliExpress cost − shipping − payment/COD fees − an allowance for COD refusals and returns. Cross-border COD is risky, because refused parcels usually can't be returned economically. Consider prepaid-only for dropshipped items, or a COD fee.
6. **Stop DSers overwriting edited product copy.** After rewriting titles, descriptions and claims (F7), check DSers' sync settings. Price, stock and product-info sync should not reintroduce supplier text or change prices without review.
7. **Order flow test:** place one Shopify test order and confirm it appears in DSers as an order to be placed. **Do not place the AliExpress order** unless you intend to buy.
8. **Cosmetics compliance for imports** **[?]:** cosmetics sent directly from AliExpress to UAE customers under King Store's name raise the question of who the importer is, and whether the products must be registered (Montaji or the relevant emirate authority). This is unresolved and needs checking with the licensing authority or a customs/regulatory adviser before selling cosmetics this way.
9. **Supplier images:** check whether the AliExpress seller permits reuse of the images. Replace any images that show other brands' logos or watermarks.

## 6. Information needed from the owner

**Business identity**
1. Trade licence number, issuing emirate, and licensed activities. Does the licence cover e-commerce and cosmetics trading?
2. The single correct registered address (Abu Dhabi, Dubai or Ajman?)
3. Support email: a business mailbox, not a personal Gmail.
4. WhatsApp number confirmation (+971 52 223 3989 appears in policies) and real support hours.
5. VAT: registered (TRN) or not? Do prices include VAT?

**Commercial**
6. Sourcing model (section 5): which option? Who is the actual supplier?
7. ~~Which app imported the products?~~ **Answered: DSers.** Still open: is DSers/AliExpress the long-term model, or a way to test demand before moving to local stock?
8. Launch product list: which SKUs, real cost prices, target retail prices in AED.
9. Real stock on hand (if any) vs supplier stock.
10. Delivery partner (Aramex, Quiqup, Jeebly, Shipa, etc.), real delivery times, real rates, free-shipping threshold.
11. Ship to UAE only? (Recommendation: yes. Disable the International zone.)
12. Payment: Shopify Payments availability, other gateways (Tabby/Tamara BNPL?), COD yes/no and any COD fee.
13. Returns: keep a 7-day unopened-only window? Refund method?

**Content & brand**
14. Primary language: Arabic-first, English-first, or bilingual? (Recommendation: **bilingual, Arabic published**, because the target customer and all product copy are Arabic.)
15. Keep the broad "beauty, style and lifestyle" positioning, or narrow to the hair/body care niche for launch?
16. Real product photography: supplier images are used today. Rights to use them?

**Regulatory**
17. Cosmetic product registration status (Dubai Municipality Montaji / other emirate authority) for each cosmetic SKU.

## 7. UAE commercial setup checklist

Legend: **[V]** = verified from an authoritative or primary source during this review. **[R]** = recommendation. **[?]** = must be verified with the authority or an adviser; no conclusion given.

**Legal / regulatory**
- [ ] **[V]** Cosmetic products sold in Dubai must be registered with Dubai Municipality via **Montaji** before sale. Only a UAE company with a valid trade licence can register. ([source](https://arnifi.com/blog/dubai-municipality-product-registration-cosmetic/), [source](https://nextmoveservices.ae/dubai-municipality-product-registration-montaji-guide-2/); these are secondary sources, so confirm on the official DM portal.)
- [ ] **[?]** Requirements in Abu Dhabi and Ajman, and for products shipped from another emirate. Confirm with the licensing authority of the emirate where the licence is issued.
- [ ] **[V]** E-commerce is governed by **Federal Decree-Law No. 14 of 2023 on Trading by Modern Technological Means** (in force since 2023). It requires clear business identification, contact details, product information and all-inclusive pricing. ([MoET PDF](https://www.moet.gov.ae/documents/20121/0/Federal+Decree-Law+No.+14+of+2023+on+Trading+by+Modern+Technological+Means.pdf))
- [ ] **[V]** Consumer-protection rules expect product, contract, payment and warranty information in **Arabic** ([BDO summary](https://www.bdolegal.ae/en-gb/insights/e-commerce-in-the-uae-understanding-the-impact-of-trading-by-modern-technological-means-law)). This is a further reason to publish the Arabic locale.
- [ ] **[?]** Whether the refund policy (opened-product exclusion, COD blacklisting clause, refund method) complies with the UAE Consumer Protection Law and its executive regulations. Legal review recommended.
- [ ] **[R]** Remove all unverifiable efficacy claims (whitening, "100% natural", "first use results") until supporting documentation exists.

**Tax**
- [ ] **[V]** VAT registration is mandatory once taxable supplies/imports exceed **AED 375,000** over 12 months; the voluntary threshold is AED 187,500. The late-registration penalty is AED 10,000. ([FTA](https://tax.gov.ae/en/taxes/Vat/vat.topics/registration.for.vat.aspx))
- [ ] **[R]** If not registered: remove "prices include 5% VAT" from the ToS and don't charge VAT in Shopify. If registered: enable tax-inclusive pricing and show the TRN.

**Store settings (Shopify Admin)**
- [ ] Merge the duplicate markets into one UAE market.
- [ ] Currency AED (done). Confirm prices are tax-inclusive per the VAT decision.
- [ ] Shipping: one domestic zone with real rates. Free-shipping rule matches the policy text. Disable International unless decided.
- [ ] Rename the location and correct its address.
- [ ] Payments: activate the gateway. Configure COD (manual payment method) if wanted.
- [ ] Checkout: phone number required (needed for couriers and COD). Address fields suit the UAE (emirate/area).
- [ ] Order notifications: store name, sender email, Arabic templates, staff order notifications.
- [ ] Customer accounts: decide on new vs classic accounts.

## 8. Required pages / policies

| Page | Status | Action |
|------|--------|--------|
| Privacy Policy | Shopify template, address "Ajman, dubai" | Correct the address and email. Add Arabic. |
| Terms of Service | Custom Arabic draft | Fix delivery times, shipping fee, VAT clause and address. Add English. |
| Refund / Return Policy | Custom Arabic draft | Align the shipping fee (15 vs 25). Legal check of the blacklist clause. Add English. |
| **Shipping Policy** | **Missing** | Draft after the courier and rates decision |
| Contact Information | Draft | Correct the address and email |
| Legal Notice | Draft with placeholders | **Fill in or hide before launch** |
| Contact page | Published, form only | Add support hours, WhatsApp and response time after confirmation |
| About Us | Missing | Optional. Real story only, no invented heritage. |
| FAQ | Missing | Recommended (delivery, COD, returns, product usage) |

## 9. SEO requirements

- Homepage title and meta description: bilingual, brand + niche, no keyword stuffing.
- **Handles:** replace the long Arabic URL-encoded handles with short Latin handles (e.g. `moroccan-argan-hair-serum`). Arabic titles stay as they are. Short handles share better on WhatsApp and are easier to debug.
- Product SEO title (≤ 60 characters) and description (≤ 155 characters) for every product.
- **Alt text on all 33 product images** (currently empty), in both languages once Arabic is published.
- Collection descriptions and SEO fields.
- Social sharing image and favicon from brand assets (check the draft theme settings).
- Once live: submit the sitemap in Google Search Console and verify the domain.
- Remove the duplicate product first, to avoid duplicate content.
- Custom domain: not in scope. **Do not use ricohunt.com.**

## 10. Analytics requirements

| Tool | Recommendation |
|------|---------------|
| Shopify Analytics | Built-in. Enough for launch. |
| Google Search Console | Yes, at launch (free, indexing health). |
| Google Analytics 4 | Only if paid Google Ads or deeper funnel analysis is planned. Install via the Google & YouTube app. |
| Meta Pixel / CAPI | Only if running Instagram/Facebook ads. Install via the Facebook & Instagram app. |
| TikTok Pixel | Only if running TikTok ads. |
| Cookie/consent banner | Required once any ad pixel is added. Shopify Customer Privacy settings. |

Default: **Shopify Analytics + Search Console only**, until an ad channel is decided.

## 11. Launch checklist

**Catalog**
- [ ] Duplicate product removed (owner approval, because it is a delete)
- [ ] Every product: type, vendor (the real brand, not "King store L.L.C" unless private label), compliant bilingual description, SKU, barcode where applicable, weight, alt text, SEO, short handle, tags, collection
- [ ] Inventory reflects **real** available stock
- [ ] Products published to the Online Store channel (only at launch)

**Store**
- [ ] Sections 6 and 7 answered and configured
- [ ] Policies corrected. Shipping policy added. No placeholders anywhere.
- [ ] Navigation: main menu = collections + contact. Footer = policies + contact + FAQ.
- [ ] Arabic locale published, and draft theme QA'd in RTL (header, menu drawer, cart, product page, checkout)

**Journey test (use Shopify Bogus Gateway / test mode, never a real card)**
- [ ] Home → Collection → Product → Variant → Add to cart → Cart → Checkout → Test order
- [ ] Customer confirmation email/SMS received and in the correct language
- [ ] Admin order visible → fulfil → shipping notification
- [ ] COD path (if enabled)
- [ ] Search, 404, contact form submission
- [ ] Mobile (iOS Safari, Android Chrome), both languages
- [ ] Test orders archived or cancelled afterwards

**Go-live (all require explicit owner approval)**
- [ ] Publish draft theme `188510142663`. This also fixes the live homepage 404.
- [ ] Remove the store password (if one is enabled)
- [ ] Search Console

## 12. Order of operations

1. **Owner decisions:** sourcing model, launch SKUs, language, UAE-only, business identity (section 6). *Blocks everything else.*
2. **Regulatory check:** cosmetic registration path; drop or re-word high-risk products (F7).
3. **Business-data corrections:** address, email, licence, VAT stance, duplicate market, location name (F4–F6, F9). Reversible settings changes, but still owner-approved.
4. **Shipping and payments:** courier, rates, COD, International zone off.
5. **Policies:** correct the existing ones, add the Shipping policy, publish bilingual versions.
6. **Catalog build:** remove the duplicate, complete product data, create ≤ 5 collections, fix handles and SEO (F1, F10).
7. **Language:** publish Arabic; RTL QA of the draft theme (content/QA only unless a defect is found).
8. **Homepage population:** point the featured collection at the lead collection; adjust hero copy if the positioning narrows. Edit in the draft Theme Editor only.
9. **End-to-end test order** in test mode.
10. **Launch approval → publish the draft theme.**

## Operating constraints honoured by this document

- No Shopify writes: no product, theme, policy, market, shipping or publication changes.
- Live theme `188507160775` untouched. Draft `188510142663` untouched. No new themes.
- No products, suppliers, business details, prices or legal conclusions invented. Regulatory items are marked verified [V] or to-verify [?].
- `main` and `theme/king-store-dawn` untouched.
