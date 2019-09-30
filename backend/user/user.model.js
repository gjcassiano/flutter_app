
const { instances } = require('gstore-node');
const gstore = instances.get('giovanic');
const { Schema } = gstore;

/**
 * Create the schema for the User Model
*/
const userSchema = new Schema({
    firstname: { type: String, required: true },
    lastname: { type: String, optional: true  },
    email: { type: String, validate: 'isEmail', required: true }
});

const listSettings = {
    limit: 15
};

userSchema.queries('list', listSettings);

module.exports = gstore.model('User', userSchema);