const loginService = require("../../services/login");
const { expressHandler } = require("../express-handler");
const {
  validateLoginRequest
} = require("../../schemas/login/login-request-schema");
const {
  validateLoginResponse
} = require("../../schemas/login/login-response-schema");

async function loginHandler(req) {
  const loginRequest = validateLoginRequest(req.body);
  const loginResponse = await loginService.checkLogin(loginRequest);
  return loginResponse;
}

module.exports = {
  loginHandler: expressHandler({
    handler: loginHandler,
    validator: validateLoginResponse
  })
};
