/**
 * ResetController
 *
 * @description :: Server-side logic for managing resets.  Resets all data or all data but location details.
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
	


  /**
   * `ResetController.clearAll()`
   */
  clearAll: function (req, res) {
    return res.json({
      todo: 'clearAll() is not implemented yet!'
    });
  },

  /**
   * `ResetController.clearAllButLocationsAndSKUs()`
   * @description :: Removes all local data, except for Location and SKU Information.
   */
  clearBoxItems: function (req, res) {
    sails.log.warn("Deleting all boxes and their items.");
    
    Item.count({}).exec(function(err, records){
      if (records> 0) {
        sails.log.info("Deleting "+ records+ " Items.");
        Item.destroy({}).exec(function(err) {
          if (err) {
            return console.log(err);
          }
        });  
      }
    });

    Box.count({}).exec(function(err, records){
      if (records> 0) {
        sails.log.info("Deleting Box "+ records+ " records.");
        Box.destroy({}).exec(function(err) {
          if (err) {
            return console.log(err);
          }
        });
      }
    });

    return res.json({
      clearBoxItems: 'done'
    });
  },

  /**
   * `ResetController.clearAllButLocations()`
   * @description :: Removes all local data, except for Location Information.
   */
  clearAllButLocations: function (req, res) {
    sails.log.warn("Deleting all local data except locations.");
    
    Item.count({}).exec(function(err, records){
      if (records> 0) {
        sails.log.info("Deleting "+ records+ " Items.");
        Item.destroy({}).exec(function(err) {
          if (err) {
            return console.log(err);
          }
        });  
      }
    });

    Box.count({}).exec(function(err, records){
      if (records> 0) {
        sails.log.info("Deleting Box "+ records+ " records.");
        Box.destroy({}).exec(function(err) {
          if (err) {
            return console.log(err);
          }
        });
      }
    });

    sails.log.info("Deleting Box Group records.");
    BoxGroup.destroy({}).exec(function(err) {
      if (err) {
        return console.log(err);
      }
    });
    sails.log.info("Deleting Categories.");
    Category.destroy({}).exec(function(err) {
      if (err) {
        return console.log(err);
      }
    });
    sails.log.info("Deleting SKUs.");
    SKU.destroy({}).exec(function(err) {
      if (err) {
        return console.log(err);
      }
    });

    sails.log.info("Deleting Jobs.");
    SortJob.destroy({}).exec(function(err) {
      if (err) {
        return console.log(err);
      }
    });


    
    sails.log.info("All removed - except locations.");

    return res.json({
      clearAllButLocations: 'done'
    });
  }
};

