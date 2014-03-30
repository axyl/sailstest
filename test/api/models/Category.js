/**
 * Category.js
 *
 * @description :: Each unique category of products.  Only one category is processed at a time.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

	attributes: {
		name:{
			type: 'STRING',
			required: true
		},
		SKUs:{
			collection: 'SKU',
			via:'category'
		}
	}

};
