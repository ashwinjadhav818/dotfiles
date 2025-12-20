// ==UserScript==
// @name         Remove youtube vid player
// @version      1.0.0
// @author       A S H
// @match        *://*.youtube.com/*
// ==/UserScript==


document.addEventListener('load', () => {
    const removeElements = () => {
        // Select both elements using a comma-separated CSS selector
        const elementsToRemove = document.querySelectorAll('#full-bleed-container, #player');

        elementsToRemove.forEach(el => {
            el.remove();
            console.log(`Removed element: ${el.id}`);
        });
    };

    // If using in your Userscript with a MutationObserver:
    const observer = new MutationObserver(removeElements);
    observer.observe(document.body, { childList: true, subtree: true });

    // Run immediately
    removeElements();
}, true);
