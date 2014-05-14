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
			required: true
		},
		status: {
			type: 'STRING',
			enum: ['packing','packed','empty','dispatched'],
			defaultsTo: 'empty'
		},
		ItemCount: {	// How many items in the box?  Should default to 0
			type: 'INTEGER',
			required: true,
			defaultsTo: 0
		},
		boxGroup: {		// Many boxes share the same group of contents....
			model:'boxGroup',
			required: true
		},
		location: {		// Where's this box located?
			type: 'STRING',
			required: true,
			defaultsTo: 'stores'
		}
	}

};
