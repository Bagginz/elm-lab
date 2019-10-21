function checkLogin(param) {
  let result = {
    login: false,
    username: "test",
    password: "test",
    errorMessage: "null"
  };
  if (param.username == "bagginz" && param.password == "1234") {
    result.login = true;
  }
  return result;
}

module.exports = {
  checkLogin
};
