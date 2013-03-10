test("Foo.age", function () {
    var foo = new Foo(20);
    equal(foo.age, 20);
});

test("Foo.fuga", function () {
    var foo = new Foo(20);
    equal(foo.fuga(), 23);
});
