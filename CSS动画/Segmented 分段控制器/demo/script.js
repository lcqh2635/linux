new Vue({
    el: "#nav",
    data: {
        selected: 1
    },
    methods: {
        select(i) {
            this.selected = i;
        }
    }
});