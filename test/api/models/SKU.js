/**
 * SKU.js
 *
 * @description :: Bar Code record for a product.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

	attributes: {
		SKU: {
			type: 'string',
			required: true
			// unique: true		// TODO : What about unique handling across this and the sort Job?
		},
		items: {		// Count of items?
			type: 'INTEGER',
			required: true
		},
		category:{		// What product category does this belong to?
			model:'category',
			required: true
		},
		boxGroup:{		// What group of boxes will this need to end up in?
			model:'boxGroup',
			required: true
		},
		description: {
			type: 'string',
			required: true
		},
		sortJob: {		// What sort Job does this SKU belong to?
			model: 'sortJob',
			required: true
			// unique: true		/// Can't do a composite key with this and SKU....
		},
		misc: 'STRING'	// Just text stuff....
	}

};
