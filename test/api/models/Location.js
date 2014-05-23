/**
* Location.js
*
* @description :: Represents a location where a box (or boxes) are positioned throughout the warehouse.  Some locations may have multiple boxes, others specifically can only have one box...
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {

  	locationSKU: {	// Bar Code for the location
  		type: 'STRING',
  		required: true,
  		unique: true
  	},
  	name: {	// Textual description of location
  		type: 'STRING',
  		required: true
  	},
  	multipleBoxes: {	// Does this location allow multiple boxes?
  		type: 'boolean',
  		required: true,
  		defaultsTo: false
  	},
    boxes: {   // What boxes belong to this location?
      collection: 'box',
      via: 'location'
    }
  }
};

