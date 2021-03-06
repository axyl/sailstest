/**
 * SkuController.js 
 *
 * @description :: Handles SKU lists.
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */

module.exports = {

  /**
   * `SkuController.create`
   * @description :: Providing SKU, Category (in text), Description, Quantity being added, Box group ID and URL.  We support updating an existing SKU, because of quantity changes.
   */

  create: function (req, res) {
	sails.log.info("Create SKU - looking for category");
	// Validate Fields
	if (!req.param('category')) {
		return res.badRequest('Sorry, need to provide category');
	};
	if (!req.param('boxgroup')) {
		return res.badRequest('Sorry, need to provide an boxgroup');
	}; 
	if (!req.param('sku')) {
		return res.badRequest('Sorry, need to provide sku');
	};
	if (!req.param('quantity')) {
		return res.badRequest('Sorry, need to provide quantity');
	};
	if (!req.param('description')) {
		return res.badRequest('Sorry, need to provide description');
	};
	if (!req.param('misc')) {
		return res.badRequest('Sorry, need to provide misc');
	};
	if (!req.param('sortJob')) {
		return res.badRequest('Sorry, need to provide sortJob');
	};

	// TODO validate that the sortJob exists...

	// Create or Find the Category....
	Category.findOrCreate({name:req.param('category')},{name:req.param('category')}).exec(function (err, record) {
		if (err) return res.send(err,500);
		
		// and the SKU entry?
		sails.log.info("Found Category ("+ record.id+ ") - now SKU.");
		SKU.findOne({SKU:req.param('sku'),sortJob:req.param('sortJob')}).exec(function(err, sku_record) {
			if (err) return res.send(err,500);
			// BoxGroup?
			BoxGroup.findOrCreate({groupID:req.param('boxgroup'),sortJob:req.param('sortJob')},{groupID:req.param('boxgroup'),sortJob:req.param('sortJob')}).exec(function (err, boxGroupRecord) {
				if (err) return res.send(err, 500);
				sails.log.info("BoxGroup sorted with "+ boxGroupRecord.id);
			
				// Record exists - update some values...maybe category's changed?
				if (sku_record) {
					sails.log.info("Updating SKU");
					sku_record.items= sku_record.items+ parseInt(req.param('quantity'));
					sku_record.description= req.param('description');
					sku_record.category=record.id;	// TODO : This doesn't seem to change.
					sku_record.boxGroup= boxGroupRecord.id;	// TODO : See above todo?
					sku_record.save();
					return res.json({id:sku_record.id});
				} else {
					sails.log.info("Creating new SKU");
					SKU.create({SKU:req.param('sku'),items:req.param('quantity'),
					  category:record.id,boxGroup:boxGroupRecord.id,description:req.param('description'),misc:req.param('misc'),sortJob:req.param('sortJob')}).exec(function (err, sku_record) {
						if (err) return res.send(err, 500);
						sails.log.info("Created new SKU with ID "+ sku_record.id);
						return res.json({id:sku_record.id});
					});
					sails.log.info("end of creating new SKU");
					return true;
				};
				sails.log.info("Outside if sku_record");
			});		// end of boxGroup.findOrCreate...
			sails.log.info("Outside boxGroup findorCreate");
		});
		sails.log.info("Outside SKU find.");
	
	});
	sails.log.info("Finished.");
  },	// End of create
  
  
    /**
   * `SkuController.findPackingBox`
   * @description :: Providing an SKU, gives back a box to put the item in, if there is one.  Otherwise if an item SKU, says need a new box with box:none...If the SKU is for a box, then returns the box details.
   */
  findPackingBox: function (req, res) {
	sails.log.info("Pack Item");
	if (!req.param('sku')) {
		return res.badRequest('Sorry, need to provide sku');
	};
	if (!req.param('sortJob')) {
		return res.badRequest('Sorry, need to provide sortJob');
	};

	
	SKU.findOne({SKU:req.param('sku'),sortJob:req.param('sortJob')}).exec(function(err, sku_record) {
		// TODO : Handle parameter checks - http://beta.sailsjs.org/#!documentation/reference/CustomResponses/CustomResponses.html
		if (err) return res.send(err,500);	
		if (!sku_record) {
			// No SKU exists for that name - if it's a box instead, then return that data..as user might be trying to pack it.
			sails.log.info('Not a product SKU, checking if box sku.');
			Box.findOne({boxSKU:req.param('sku'),status:'packing',sortJob:req.param('sortJob')}).exec(function (err, boxRecord) {
				if (boxRecord) {
					sails.log.info('SKU is for a box...returning box.');
					return res.json({box:boxRecord,sku:'box'});
				} else {
					return res.json({sku:'invalid'});
				}
			});
		} else {
			// Open Box?
			Box.findOne({boxGroup:sku_record.boxGroup,status:'packing',sortJob:req.param('sortJob')}).populate('location').exec(function (err, boxRecord) {
				if (err) return res.send(err,500);
				if (boxRecord) {
					sails.log.info("Box in packing state, returning record.");
					return res.json({box:boxRecord,sku:sku_record});	// return the boxRecord...
				} else {
					sails.log.info("No box currently in packing state.");
					return res.json({box:'none',sku:sku_record});	// No box that we're currently packing.
				};
			});	// end of Box.findOne
		};	// end of else !sku_record
	});	// End of SKU.findOne
  
  }  // End of packItem
  
  
};
