/* eslint-disable react/prop-types */
/* eslint-disable react/destructuring-assignment */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable react/function-component-definition */
import { useState, useEffect } from "react";
import { HiOutlineStar } from "react-icons/hi";
import { Button } from "@mui/material";
import { useUser } from "../../../contexts/UserContext";
import useApi from "../../../services/useApi";

const OfferEmploi = ({ results }) => {
  const [selected, setSelected] = useState(false);
  const user = useUser();
  const api = useApi();
  console.warn(user);

  useEffect(() => {}, []);

  const handleIconClick = () => {
    setSelected(!selected);
    api
      .post(`offers/${results.id}/like`, { candidateId: user.user.id })
      .then((response) => {
        setSelected(!selected);
        console.warn(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return (
    <div className="offersemploi-offer_container">
      <div className="offersemploi-offer_logo">logo</div>
      <div className="offersemploi-offer_info">
        <div className="offersemploi-offer_info-main">
          <h3 className="offersemploi-offer_title">
            {results.jobTitleDetails}
          </h3>
          <h3 className="offersemploi-offer_salary">
            {results.salary} euro/an
          </h3>
        </div>
        <div className="offersemploi-offer_info-contract">
          <h3 className="offersemploi-offer_type-contract">type de contrat</h3>
          <h3 className="offersemploi-offer_remote">travail: remote</h3>
          <h3 className="offersemploi-offer_city">{results.city_name}</h3>
          <div>
            <HiOutlineStar
              className={
                selected
                  ? "offersemploi-icon_star-selected"
                  : "offersemploi-icon_star"
              }
              onClick={handleIconClick}
              size={50}
            />
          </div>
        </div>
      </div>
      <Button id="offersemploi-offer_button-info" variant="contained">
        Plus d'infos
      </Button>
    </div>
  );
};

export default OfferEmploi;
