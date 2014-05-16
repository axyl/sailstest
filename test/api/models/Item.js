/**
* Item.js
*
* @description :: A record for an item stored inside a box.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

	attributes: {
		sku: {	// Bar Code for the item - not unique...as there might be multiple SKU's in a box that are the same.
			type: 'STRING',
			required: true
		},
		packedBy: {	// Who packed this item?
			type: 'STRING'
		},
		box: {	// What box is this in?
			model:'box',
			required: true
		}
	}
};

