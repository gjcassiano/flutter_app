const express = require('express');
const app = express();
app.use(express.json());

const { Gstore, instances } = require('gstore-node');
const { Datastore } = require('@google-cloud/datastore');
const gstore = new Gstore();

const datastore = new Datastore({
    projectId: 'giovanic',
});
gstore.connect(datastore);

instances.set('giovanic', gstore);

const routerUsers = require('./user/user.router');

app.get('/', (req, res) => {
	res.send('<h1>TBD</h1>');
});

// logger
app.use(function (req, res, next) {
    console.log('%s %s %s', req.method, req.url, req.user);
    next()
});

app.use('/api/users', routerUsers);

const server = app.listen(8080, () => {
  const port = server.address().port;
  console.log(`listening at port:${port}`);
});
