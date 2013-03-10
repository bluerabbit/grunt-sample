test("Animal#name", function () {
    var animal = new Animal('a');
    ok(animal.name == "a");
});
;
//test("application#", function () {
//});
;
test("Foo.age", function () {
    var foo = new Foo(20);
    equal(foo.age, 20);
});

test("Foo.fuga", function () {
    var foo = new Foo(20);
    equal(foo.fuga(), 23);
});
;
module("sinon.spy jQuery.ajax", {
    setup: function () {
    },
    teardown: function () {
        jQuery.ajax.restore();
    }
});

test("jQuery.getJSON", function () {
    var spy = sinon.spy(jQuery, "ajax");
    jQuery.getJSON("/some/resource");
    ok(spy.calledOnce, "method is called once");
    equal(spy.getCall(0).args[0].url, "/some/resource", "url parameter");
    equal(spy.getCall(0).args[0].dataType, "json", "dataType parameter");
});

module("sinon.mock");
test('mock.expects, mock.twice', function() {
    var Hoge = function(){};
    Hoge.prototype.foo = function(name){
        return name;
    };
    var hoge = new Hoge();

    var mock = sinon.mock(hoge);
    mock.expects("foo").withArgs("test")
    hoge.foo("test");

    ok(mock.verify(), "method foo called.");
});

test("sinon.stub, sinon.returns", function(){
    var Hoge = function(){};
    Hoge.prototype.ok = function() {
        return true;
    };
    var hoge = new Hoge();
    equal(hoge.ok(), true);
    var stub = sinon.stub(hoge, "ok");
    stub.returns(false);
    equal(hoge.ok(), false, "return false");
    stub.restore();
});;
test("User#say", function () {
    var user = new User('a');
    var mock = sinon.mock(user);
    mock.expects("say").withArgs("test")
    user.say("test");
    ok(mock.verify(), "method say called.");
});
