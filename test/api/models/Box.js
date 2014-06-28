/**
 * Box.js
 *
 * @description :: A box that contains individual products.  Box location can move through the warehouse, be empty etc.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

	attributes: {	// TODO : Add locations
		// What's the SKU for the box.
		boxSKU: {	// What Bar Code does this box have?
			type: 'STRING',
			required: true,
			unique: true
		},
		status: {
			type: 'STRING',
			enum: ['packing','packed','empty','dispatched','packedNotAllocated'],
			defaultsTo: 'empty'
		},
		items: {
			collection: 'item',
			via: 'box'
		},
		boxGroup: {		// Many boxes share the same group of contents....
			model:'boxGroup',
			required: true
		},
		location: {		// Where's this box located?  Some locations can handle multiple boxes...others can't.
			model: 'location',
			required: true
		},
		sortJob: { 	// What sort Job do we belong to?
			model: 'sortJob',
			required: true
		}
	}

};
