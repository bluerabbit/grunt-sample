test("User#say", function () {
    var user = new User('a');
    var mock = sinon.mock(user);
    mock.expects("say").withArgs("test")
    user.say("test");
    ok(mock.verify(), "method say called.");
});
