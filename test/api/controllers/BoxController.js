/**
 * BoxController.js 
 *
 * @description ::
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */

module.exports = {
	/**
	 * `BoxController.move`
	 * @description :: Moves a box from one location to another, changing it's status too.
	 */
	 move: function (req, res) {
		// Must provide a BoxSKU, LocationSKU and PackedBy.  Status is optional
		if (!req.param('boxSKU')) {
			return res.badRequest('Sorry, need to provide boxSKU');
		};
		if (!req.param('locationSKU')) {
			return res.badRequest('need to provide locationSKU');
		}
		if (!req.param('packedBy')) {
			return res.badRequest('Sorry, need to provide packedBy');
		}

		sails.log.info("Request to Move Box "+ req.param('boxSKU')+ " to "+ req.param('locationSKU')+ " by " + req.param('packedBy'));

		// Does the box exist...fetching the old location for now.
		Box.findOne({boxSKU:req.param('boxSKU')}).exec(function(err, box_record) {
			if (box_record) {
				sails.log.info("Box found");
				// Does the location exist.
				Location.findOne({locationSKU:req.param('locationSKU')}).populate('boxes').exec(function(err, location_record) {
					if (location_record) {
						sails.log.info("Location found.");
						// Check if location ias a box already...and doesn't allow multiple boxes ... and isn't our own box
						if (!location_record.multipleBoxes && location_record.boxes.length> 0 && location_record.boxes[0].id!= box_record.id) {
							// Don't allow the change in location..because there's a box there already.
							sails.log.info("Location already has one box and doesn't allow multiples.");
							return res.badRequest("Location already has box ("+ location_record.boxes[0].boxSKU+ ").  Only one box allowed in Location.");
						} else {
							// Location can accept box!
							box_record.location= location_record.id;
							// Was there a status update?
							if (req.param('status')) {
								box_record.status= req.param('status');
							}
							sails.log.info("Moving box to new location.");
							box_record.save(function(err,s){
								if (err) { 
									sails.log.info("Error saving box record "+ err);
									return res.badRequest(err);
								} else {
									return res.json(s);
								}
							});							
						}

					} else {
						// Location doesn't exist.
						sails.log.info("Location does not exist.");
						return res.badRequest("No location found with that SKU.");
					}

				});  // end of Location.findOne

			} else {
				// Didn't find box.
				sails.log.info("No box found...");
				return res.badRequest("No box found with that SKU.");
			}

		});  // end of Box.findOne

	 
	 },	// end of move function.	

	 /** BoxController.list`
	 * @description :: Gives back the list of boxes for generating a CSV...
	 */
	 list: function(req, res) {
	 	// Must provide a SortJob.
	 	if (!req.param('sortJob')) {
	 		return res.badRequest('Need to provide a sortJob to fetch a list for.');
	 	};
	 	// TODO : Error checking? 
	 	Box.find({sortJob:req.param('sortJob')}).populate('location').populate('boxGroup').populate('items').exec(function listItems(err, Boxes){
	 		res.type('text/csv');
	 		res.set('Content-Disposition','inline; filename="boxes.csv"');
	 		return res.view({layout: "csv", boxes: Boxes}, 'box/list');
	 	});
	 },  // end of list function.	 

	 /** BoxController.findItemSKU `
	 * @description :: Returns all boxes and their locations that contain the Item SKU provided.
	 */
	 findItemSKU: function(req, res) {
	 	// Must provide an itemSKU...
	 	if (!req.param('ItemSKU')) {
	 		return res.badRequest('Sorry, need to provide ItemSKU to find.');
	 	};

	 	Item.find({sku:req.param('ItemSKU')}).populate('box').exec(function boxesList(err, Boxes){
	 		var validBoxes= []; 
	 		// Create a list of boxes...
	 		while (Boxes.length) {
	 			validBoxes.push(Boxes.pop().box.id);
	 		}
	 		// Now do a find across the boxes.
	 		Box.find({id:validBoxes}).populate('location').populate('items').populate('sortJob').exec(function yeah(err, validBoxes){
	 			return res.json(validBoxes);

	 		});

	 	});

	}


};
