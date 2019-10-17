function checkLogin(param) {
    let result = { login: false };
    if (param.username == "bagginz" && param.password == "1234") {
        result.login = true;
    }
    return result;
}

module.exports = {
    checkLogin
}