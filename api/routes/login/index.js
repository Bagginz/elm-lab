const loginController = require('../../controller/login');

function setup(app) {
    app.post('/login/checklogin', loginController.loginHandler);
}

module.exports = {
    setup
}