# Before, After, BeforeEach, AfterEach Nuances
https://stackoverflow.com/questions/21418580/what-is-the-difference-between-before-and-beforeeach

```JavaScript
describe("top", function () {
    before(function () {
        console.log("top before");
    });
    after(function () {
        console.log("top after");
    });
    beforeEach(function () {
        console.log("top beforeEach");
    });
    afterEach(function () {
        console.log("top afterEach");
    });
    it("test1", function () {
        console.log("top test1");
    });
    describe("sublevel", function() {
        before(function () {
            console.log("sublevel before");
        });
        after(function () {
            console.log("sublevel after");
        });
        beforeEach(function () {
            console.log("sublevel beforeEach");
        });
        afterEach(function () {
            console.log("sublevel afterEach");
        });
        it("test1", function () {
            console.log("sublevel test1");
        });
        it("test2", function () {
            console.log("sublevel test2");
        });
    });
    it("test2", function () {
        console.log("top test2");
    });
});
```

Outputs as
```text
top before
top beforeEach
top test1
top afterEach
top beforeEach
top test2
top afterEach
sublevel before
top beforeEach
sublevel beforeEach
sublevel test1
sublevel afterEach
top afterEach
top beforeEach
sublevel beforeEach
sublevel test2
sublevel afterEach
top afterEach
sublevel after
top after
```
