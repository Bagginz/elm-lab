const login = require('../../data/login');

async function checkLogin(param) {
    const result = await login.checkLogin(param);
    return result;
}

module.exports = {
    checkLogin
};