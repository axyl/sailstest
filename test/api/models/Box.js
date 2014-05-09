/**
 * Box.js
 *
 * @description :: A box that contains individual products.  Box location can move through the warehouse, be empty etc.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

	attributes: {	// TODO : Add locations
		// What's the SKU for the box.
		boxSKU: {
			type: 'STRING',
			required: true
		},
		status: 'STRING',	// TODO : Change to on table, pallet, etc etc.
		ItemCount: {	// How many items in the box?  Should default to 0
			type: 'INTEGER',
			required: true
		},
		boxGroup: {
			model:'boxGroup',
			required: true
		}

	}

};
