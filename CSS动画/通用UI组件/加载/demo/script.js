// for restarting the animation
window.addEventListener("DOMContentLoaded", () => {
    const replay = document.getElementById("replay");
    let resetTimeout = null;
    let btnTimeout = null;
    // prevent keyboard interaction while the button is hidden
    const tempHideBtn = btn => {
        if (btn) {
            const btnCS = window.getComputedStyle(btn);
            let btnAnimDur = btnCS.getPropertyValue("animation-duration");

            btnAnimDur = +btnAnimDur.split("s")[0] * 1e3;
            btn.disabled = true;

            clearTimeout(btnTimeout);
            btnTimeout = setTimeout(() => {
                btn.disabled = false;
            }, btnAnimDur);
        }
    };

    if (replay) {
        let spinnerEls = [
            "circle",
            "worm-a",
            "worm-b"
        ];
        spinnerEls = spinnerEls.map(e => document.querySelector(`.check-spinner__${e}`));
        // hide the button at start
        tempHideBtn(replay);

        replay.addEventListener("click", function () {
            // kill the animations
            spinnerEls.forEach(e => {
                e.style.animation = "none";
            });
            this.style.animation = "none";

            // restore them, hide the button again
            clearTimeout(resetTimeout);
            resetTimeout = setTimeout(() => {
                spinnerEls.forEach(e => {
                    e.removeAttribute("style");
                });
                this.removeAttribute("style");
                tempHideBtn(this);
            }, 0);
        });
    }
});