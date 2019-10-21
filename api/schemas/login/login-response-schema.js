const Joi = require("joi");

const loginResponseSchema = Joi.object().keys({
  login: Joi.boolean().required(),
  username: Joi.string().required(),
  password: Joi.string().required(),
  errorMessage: Joi.string().required()
});

function validateLoginResponse(data) {
  const v = Joi.validate(data, loginResponseSchema, { stripUnknown: true });
  if (v.error) {
    throw new Error(v.error.message);
  }
  return v.value;
}
module.exports = {
  validateLoginResponse
};
