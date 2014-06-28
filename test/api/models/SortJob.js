/**
* SortJob.js
*
* @description :: Represents a specific Incoming Sorting job that SKU's, Items and Boxes belong to.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
  	name : {	// Name for this Sort Job.
  		type: 'STRING',
  		required: true,
  		unique: true
  	},
  	comment: {
  		type: 'STRING'
  	}
  }
};

