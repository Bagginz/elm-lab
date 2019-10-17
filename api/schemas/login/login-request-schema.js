const Joi = require('joi')
const InvalidRequestError = require('../../errors/invalid-request-error')

const loginRequestSchema = Joi.object().keys({
    username: Joi.string().required(),
    password: Joi.string().required(),
})

function validateLoginRequest(data) {
    const v = Joi.validate(data, loginRequestSchema, { stripUnknown: true })
    if (v.error) {
        throw new InvalidRequestError('Invalid Request', v.error.message)
    }
    return v.value
}


module.exports = {
    validateLoginRequest
}