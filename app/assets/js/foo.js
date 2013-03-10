var Foo = function (age) {
    this.age = age;
};

Foo.prototype.fuga = function () {
    var piyo = 1;
    return piyo + 2 + this.age;
};
