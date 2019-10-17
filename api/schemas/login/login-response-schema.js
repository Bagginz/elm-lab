const Joi = require('joi')

const loginResponseSchema = Joi.object().keys({
    login: Joi.boolean().required()
})

function validateLoginResponse(data) {
    const v = Joi.validate(data, loginResponseSchema, { stripUnknown: true })
    if (v.error) {
        throw new Error(v.error.message)
    }
    return v.value
}
module.exports = {
    validateLoginResponse
}