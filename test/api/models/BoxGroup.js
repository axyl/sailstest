/**
 * BoxGroup.js
 *
 * @description :: A group of boxes contains the same (or will) product SKU's as defined by the warehouse operator (Tommy!).  This groups
 multiple boxes as storing the same type of contents...
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

	attributes: {
		groupID:{		// Internal ID for the group..
			type: 'STRING',
			required: true
		},
		name: 'STRING',	// what name's given to the group - defined by Warehouse Operator.
		SKUs: {			// What list of product SKU's/barcodes do we want in boxes that belong to this group?
			collection: 'SKU',
			via:'boxGroup'
		},
		boxes: {	// What boxes belong to this group?
			collection: 'box',
			via:'boxGroup'
		}
	}

};
