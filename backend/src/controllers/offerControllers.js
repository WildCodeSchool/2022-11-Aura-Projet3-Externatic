const joi = require("joi");
const models = require("../models");

const validate = (data, forCreation = true) => {
  const presence = forCreation ? "required" : "optional";
  return joi
    .object({
      salary: joi.string().max(45).presence(presence),
      remoteId: joi.number().integer().presence(presence),
      teamPicture: joi.string().max(45).presence(presence),
      jobOfferPresentation: joi.string().max(1000).presence(presence),
      desiredProfile: joi.string().max(1000).presence(presence),
      recruitmentProcess: joi.string().max(1000).presence(presence),
      numberOfEmployees: joi.string().max(45).presence(presence),
      jobTitleDetails: joi.string().max(1000).presence(presence),
      cityId: joi.number().integer().presence(presence),
      consultantId: joi.number().integer().presence(presence),
      recruiterId: joi.number().integer().presence(presence),
      contratId: joi.number().integer().presence(presence),
      jobTitleId: joi.number().integer().presence(presence),
    })
    .validate(data, { abortEarly: false }).error;
};
const add = (req, res) => {
  const {
    salary,
    remoteId,
    teamPicture,
    jobOfferPresentation,
    desiredProfile,
    recruitmentProcess,
    numberOfEmployees,
    jobTitleDetails,
    cityId,
    consultantId,
    recruiterId,
    contratId,
    jobTitleId,
  } = req.body;
  const validationError = validate(req.body);
  if (validationError) {
    // Si les données ne sont pas valides, renvoyer une erreur 400
    res.status(422).json({ error: validationError.message }); // Utiliser validationError.message pour obtenir le message d'erreur
  }
  models.offer
    .insert({
      salary,
      remoteId,
      teamPicture,
      jobOfferPresentation,
      desiredProfile,
      recruitmentProcess,
      numberOfEmployees,
      jobTitleDetails,
      cityId,
      consultantId,
      recruiterId,
      contratId,
      jobTitleId,
    })
    .then(([result]) => {
      return res.location(`/offers/${result.insertId}`).sendStatus(201);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const browse = (req, res) => {
  const { page = 1, limit = 4 } = req.query;
  const { filter, typeFilter } = req.query;
  const { allOffers } = req.query;
  const limit2 = parseInt(limit, 10);

  if (allOffers) {
    models.offer
      .findAllFilter()
      .then(([rows]) => {
        return res.send(rows);
      })
      .catch((err) => {
        console.error(err);
        return res.sendStatus(500);
      });
  } else if (typeFilter) {
    // est ce que typefilter existe ?
    // si oui on fait un switch sur type filter
    // et dans ce switch on appelle le modèle avec la bonne requête
    switch (parseInt(typeFilter, 10)) {
      case 1:
        models.offer
          .findAllJobs(filter)
          .then(([rows]) => {
            res.send(rows);
          })
          .catch((err) => {
            console.error(err);
            res.sendStatus(500);
          });
        break;
      case 2:
        models.offer
          .findAllRemote(filter)
          .then(([rows]) => {
            res.send(rows);
          })
          .catch((err) => {
            console.error(err);
            res.sendStatus(500);
          });
        break;
      case 3:
        models.offer
          .findAllContract(filter)
          .then(([rows]) => {
            res.send(rows);
          })
          .catch((err) => {
            console.error(err);
            res.sendStatus(500);
          });
        break;
      case 4:
        models.offer
          .findAllCity(filter)
          .then(([rows]) => {
            res.send(rows);
          })
          .catch((err) => {
            console.error(err);
            res.sendStatus(500);
          });
        break;
      default:
        res.sendStatus(422);
    }
  }
  // sinon
  else {
    models.offer
      .findAll(page, limit2)
      .then(([rows]) => {
        res.send(rows);
      })
      .catch((err) => {
        console.error(err);
        res.sendStatus(500);
      });
  }
};

const getjobtitle = (req, res) => {
  models.offer
    .getjobs()
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const remotefilter = (req, res) => {
  models.offer
    .getremote()
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const contractfilter = (req, res) => {
  models.offer
    .getcontract()
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const cityfilter = (req, res) => {
  models.offer
    .getcity()
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const read = (req, res) => {
  models.offer
    .find(parseInt(req.params.id, 10))
    .then(([rows]) => {
      if (rows[0] == null) {
        res.sendStatus(404);
      } else {
        res.send(rows[0]);
      }
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const multifilter = (req, res) => {
  const {
    jobmultifilter,
    remotemultifilter,
    contractmultifilter,
    citymultifilter,
  } = req.query.filter;
  models.offer
    .getmultifilter(
      parseInt(jobmultifilter, 10),
      parseInt(remotemultifilter, 10),
      parseInt(contractmultifilter, 10),
      parseInt(citymultifilter, 10)
    )
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

module.exports = {
  add,
  browse,
  getjobtitle,
  remotefilter,
  contractfilter,
  read,
  cityfilter,
  multifilter,
};
