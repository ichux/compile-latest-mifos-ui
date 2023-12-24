window.onload = function() {
    // loaded on first load
    document.querySelector('.container > div:nth-child(2) > div:nth-child(1) > div:nth-child(4)').remove()
    document.querySelector('div.row:nth-child(4)').remove()
    let isRemoved = false;

    const observer = new MutationObserver(list => {
        const evt = new CustomEvent('dom-changed', {
            detail: list
        });
        document.body.dispatchEvent(evt)
    });
    
    observer.observe(document.body, {
        attributes: true,
        childList: true,
        subtree: true
    });

    document.body.addEventListener('dom-changed', e => {
        const one = document.querySelector('#mifos-reskin-body-view > footer:nth-child(4)');
        const two = document.querySelector('.left-nav > ul:nth-child(1) > li:nth-child(14)');
        const three = document.querySelector(
            "#main-menu-right > li:nth-child(2) ul li:first-child"
        );

        if (!one || !two || !three || isRemoved) return

        one.remove();
        two.remove();
        three.remove();

        // console.log("items removed: " + new Date());
        isRemoved = true;

    });

};
