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
		items:'INTEGER',
		category:{
			model:'category'
		},
		description: {
			type: 'string',
			required: true
		},
		misc: 'STRING'
	}

};
