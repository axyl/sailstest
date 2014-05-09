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
		},
		items: {
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
		misc: 'STRING'
	}

};
