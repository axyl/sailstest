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
	// Create or Find the Category....
	Category.findOrCreate({name:req.param('category')},{name:req.param('category')}).exec(function (err, record) {
		if (err) return res.send(err,500);
		
		// and the SKU entry?
		sails.log.info("Found Category ("+ record.id+ ") - now SKU.");
		SKU.findOne({SKU:req.param('sku')}).exec(function(err, sku_record) {
			if (err) return res.send(err,500);
			// Record exists - update some values...maybe category's changed?
			if (sku_record) {
				sails.log.info("Updating SKU");
				sku_record.items= sku_record.items+ parseInt(req.param('quantity'));
				sku_record.description= req.param('description');
				sku_record.category=record.id;	// TODO : This doesn't seem to change.
				sku_record.save();
				return res.json({id:sku_record.id});
			} else {
				sails.log.info("Creating new SKU");
				SKU.create({SKU:req.param('sku'),items:req.param('quantity'),
				  category:record.id,description:req.param('description'),misc:req.param('misc')}).exec(function (err, sku_record) {
					if (err) return res.send(err, 500);
					sails.log.info("Created new SKU with ID "+ sku_record);
					return true;
				});
				return true;
			};
		
		});
	
	});
  }	// End of create
  
  
};
