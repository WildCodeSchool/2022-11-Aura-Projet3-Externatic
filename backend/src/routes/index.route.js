const router = require("express").Router();

const compagny = require("./compagny.route");
const loginCompagny = require("./login.compagny.route");

router.use("/compagny", compagny);
router.use("/login", loginCompagny);

module.exports = router;
