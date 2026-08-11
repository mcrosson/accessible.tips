---
title: "_ Test _"
authors:
  - KemoNine
date: 2024-01-01
toc: true
draft: true
tags:
  - organizers
changelog:
  - date: 2024-01-01
    text: Initial creation
---

This is a test page for the `tips` section. It exercises the formatting features that the page templates support, so verification work on theme changes has a single place to look.

## Headings and structure

This is a `##` section. The `back_to_top` shortcode goes on the next line.

{{< back_to_top >}}

A second section follows. This one has a `###` sub-section under it.

### Sub-section

This is a `###` sub-section, used for nested content under the parent `##`.

{{< end_section >}}

## Lists, links, and inline code

A bulleted list:

- First item with `inline code`.
- Second item with a [link to Google](https://google.com).
- Third item.

A multiline paragraph continues. The text spans multiple paragraphs naturally.

## Code block

Here's a fenced code block, exercising keywords, strings, numbers, comments, classes, functions, and template literals:

```javascript
// Shopping cart with tax calculation
const DEFAULT_TAX_RATE = 0.0825;
const MAX_QUANTITY = 99;

class OutOfStockError extends Error {
    constructor(message) {
        super(message);
        this.name = "OutOfStockError";
    }
}

function formatCurrency(amount, currency = "USD") {
    return new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: currency,
    }).format(amount);
}

class ShoppingCart {
    #items = [];
    #taxRate;

    constructor(taxRate = DEFAULT_TAX_RATE) {
        this.#taxRate = taxRate;
    }

    addItem({ name, price, quantity = 1 }) {
        if (quantity < 1 || quantity > MAX_QUANTITY) {
            throw new OutOfStockError(`Invalid quantity: ${quantity}`);
        }
        this.#items.push({ name, price, quantity });
    }

    get subtotal() {
        return this.#items.reduce(
            (sum, item) => sum + item.price * item.quantity,
            0
        );
    }

    get tax() {
        return this.subtotal * this.#taxRate;
    }

    get total() {
        return this.subtotal + this.tax;
    }

    checkout() {
        return `Subtotal: ${formatCurrency(this.subtotal)}, ` +
               `Tax: ${formatCurrency(this.tax)}, ` +
               `Total: ${formatCurrency(this.total)}`;
    }
}

// Example usage
const cart = new ShoppingCart(0.10);
cart.addItem({ name: "Apple", price: 1.50, quantity: 3 });
cart.addItem({ name: "Bread", price: 4.25 });
console.log(cart.checkout());
```



## Admonition color buckets

The 21 admonition types, alphabetized within each severity band (least → most severe).

{{< back_to_top >}}

### Neutral (site teal)

> [!CODE]
> A code snippet that the user should pay attention to.

> [!QUOTE]
> A quotation.

### Info (blue)

> [!ABSTRACT]
> A summary of the content that follows.

> [!CONCLUSION]
> A conclusion or a summary of the content.

> [!EXAMPLE]
> An example or a representative case.

> [!INFO]
> Useful information that the user does not have to read.

> [!MEMO]
> A reminder or a note to remember.

> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!NOTIFY]
> A notification or a message that requires attention.

> [!QUESTION]
> A question or a curiosity.

### Tip (green)

> [!EXPERIMENT]
> An experiment or a test.

> [!GOAL]
> A goal or an objective.

> [!IDEA]
> An idea or a suggestion.

> [!SUCCESS]
> A success or confirmation message.

> [!TASK]
> A task that the user should complete.

> [!TIP]
> Optional information to help a user be more successful.

### Important (purple)

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

### Warning (amber)

> [!CAUTION]
> Negative potential consequences of an action.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

### Danger (red)

> [!DANGER]
> Dangerous certain consequences of an action.

> [!ERROR]
> An error or a problem that needs to be addressed.

{{< end_section >}}
