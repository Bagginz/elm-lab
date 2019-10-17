const app = require('./server');
const { setup } = require('./connections/setup');

const port = 3000
setup(app)
    .then(() => {
        const server = app.listen(port, () => console.log(`App listening on port ${port}!`));
    });