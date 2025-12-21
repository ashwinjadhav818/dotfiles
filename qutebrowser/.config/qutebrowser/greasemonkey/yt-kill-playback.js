// ==UserScript==
// @name         YouTube Kill Playback Only (Fixed)
// @version      7.1.0
// @author       A S H
// @match        *://*.youtube.com/*
// @run-at       document-start
// ==/UserScript==

(() => {
    'use strict';

    /* 1️⃣ HARD BLOCK play() */
    const realPlay = HTMLMediaElement.prototype.play;
    HTMLMediaElement.prototype.play = function() {
        this.pause();
        this.muted = true;
        this.volume = 0;
        return Promise.resolve();
    };

    /* 2️⃣ FORCE STOP VIDEO */
    const killVideo = v => {
        if (!v || v.paused) return;
        v.pause();
        v.muted = true;
        v.volume = 0;
        v.currentTime = 0;
        v.removeAttribute('src');
        v.load();
    };

    /* 3️⃣ OBSERVER SETUP (SAFE) */
    const startObserver = () => {
        const root = document.documentElement || document.body;
        if (!root) return false;

        new MutationObserver(muts => {
            for (const m of muts) {
                for (const n of m.addedNodes) {
                    if (n instanceof HTMLVideoElement) killVideo(n);
                    if (n.querySelectorAll)
                        n.querySelectorAll('video').forEach(killVideo);
                }
            }
        }).observe(root, {
            childList: true,
            subtree: true
        });

        return true;
    };

    /* 4️⃣ RETRY UNTIL DOM EXISTS */
    if (!startObserver()) {
        const retry = setInterval(() => {
            if (startObserver()) clearInterval(retry);
        }, 50);
    }

    /* 5️⃣ INITIAL PASS */
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('video').forEach(killVideo);
    });

    /* 6️⃣ SPA NAVIGATION */
    document.addEventListener('yt-navigate-finish', () => {
        document.querySelectorAll('video').forEach(killVideo);
    });
})();
