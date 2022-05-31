setInterval(() => {
    const btn = document.querySelector('.videoAdUiSkipButton, .ytp-ad-skip-button');
    if (btn) btn.click();

    const ad = [...document.querySelector('.ad-showing')][0];
    if (ad) {
        document.querySelector('video').playbackRate = 10;
    }

}, 50);
