/**
 * ItemController
 *
 * @description :: Server-side logic for managing items
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
	/**
	 * `ItemController.create`
	 * @description :: Providing an Item SKU and Box SKU..pack this item into this box...
	 */
	 create: function (req, res) {
		// Must provide a boxSKU...
		if (!req.param('boxSKU')) {
			res.badRequest('Sorry, need to provide boxSKU');
		};
		// TODO : Validate that the item SKU is in the category we're handling...and is in the SKU items list?
		// TODO : Is this item allowed in this box? (part of the boxGroup?)
		// Find the ID of the Box SKU provided...
		sails.log.info("Searching for Box SKU provided.");
		Box.findOne({boxSKU:req.param('boxSKU'),status:'packing'}).exec(function(err, box_record) {
			if (box_record) {
				sails.log.info("Box Exists, creating item record.");
				// TODO : Change the box state to packing...check its current state for validation?
				Item.create({sku:req.param('sku'),packedBy:req.param('packedBy'),box:box_record.id}).exec(function (err, item_record){
					sails.log.info("Item recorded in box.");
					return res.json(item_record);
				});
			} else {
				// Didn't find a box.
				sails.log.info("No box found...");
				res.badRequest('No open box found with that SKU.');
			};
		});	// end of box.findOne...
	 
	 },	// end of create function.

	 /** ItemController.list`
	 * @description :: Gives back the list of Items for generating a CSV...
	 */
	 list: function(req, res) {
	 	// TODO : Error checking? 
	 	Item.find({}).populate('box').exec(function listItems(err, Items){
	 		return res.view('item/list', {items: Items});
	 	});
	 }  // end of list function.
};

