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

	/**
	 * `ItemController.destroy`
	 * @description :: Overrides the existing destroy.  Requires an Item SKU and a Box SKU to remove the item from.
	 */
	 destroy: function (req, res) {
		// Must provide a boxSKU...
		if (!req.param('boxSKU')) {
			return res.badRequest('Sorry, need to provide boxSKU');
		};
		if (!req.param('itemSKU')) {
			return res.badRequest('Sorry, need to provide an itemSKU');
		};
		
		// Find the ID of the Box SKU provided...
		sails.log.info("Searching for Box SKU provided.");
		Box.findOne({boxSKU:req.param('boxSKU')}).populate('items').exec(function (err, box_record) {
			if (box_record) {
				sails.log.info("Box Found.");
				var foundItem= false;
				// Now find an item from it that matches the Item SKU?
				while (box_record.items.length) {
					sails.log.info("Looping box Items... "+ box_record.items.pop().sku);
					if (box_record.items.pop().sku== req.param('itemSKU')) {
						// found a matching item...
						sails.log.info("Found matching item...");
						foundItem= true;
						Item.destroy({id:box_record.items.pop().id}).exec(function (err) {
							sails.log.info("Item record deleted.");
							// TODO : Boxes with no items?
							return res.json({item:"deleted"});
						});
						break;
					};
				};

				// Find an item?
				if (!foundItem) {
					sails.log.warn("No item SKU found in that box that matches.");
					return res.badRequest('No Item found with that SKU in that Box.');
				};
			} else {
				// Didn't find a box.
				sails.log.info("No box found...");
				return res.badRequest('No box found with that SKU.');
			};
		});	// end of box.findOne...
	 }  // end of destroy function.
};

