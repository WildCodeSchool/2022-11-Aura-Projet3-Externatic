/* eslint-disable react/destructuring-assignment */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable react/function-component-definition */
import { useState } from "react";
import { HiOutlineStar } from "react-icons/hi";
import { AiTwotoneEdit } from "react-icons/ai";
import { toast } from "react-toastify";
import { Button } from "@mui/material";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";
import { useUser } from "../../../contexts/UserContext";
import useApi from "../../../services/useApi";

const OfferEmploi = ({ offer, userId }) => {
  const [selected, setSelected] = useState(offer.candidateId === userId);
  const user = useUser();
  const api = useApi();
  const urlFile = import.meta.env.VITE_APP_URL;
  const { setOfferData } = useUser();

  const handleEditClick = () => {
    setOfferData(offer);
  };

  const handleIconClick = () => {
    setSelected(!selected);
    api
      .post(`offers/${offer.id}/like`, { candidateId: user.user.id })

      .then(() => {
        setSelected(!selected);
      })
      .catch(() => {
        toast.error("Une erreur s'est produite", {
          position: "top-center",
          autoClose: 5000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "colored",
        });
      });
  };

  return (
    <div className="offersemploi-offer_container">
      <img
        src={`${urlFile}/${offer.Logo}`}
        className="offersemploi-offer_logo"
        alt=""
      />
      <div className="offersemploi-offer_info">
        <div className="offersemploi-offer_info-main">
          <h3 className="offersemploi-offer_title">{offer.job_title}</h3>
          <h3 className="offersemploi-offer_salary">{offer.salary} euro/an</h3>
        </div>
        <div className="offersemploi-offer_info-contract">
          <h3 className="offersemploi-offer_type-contract">
            {offer.contract_type}
          </h3>
          <h3 className="offersemploi-offer_remote">{offer.remote_type}</h3>
          <h3 className="offersemploi-offer_city">{offer.city_name}</h3>
          {user?.user?.userType === "recruiters" &&
            userId === offer.recruiterId && (
              <Link to="/update-offer">
                <AiTwotoneEdit
                  size={30}
                  className="offersemploi-con_edit"
                  onClick={handleEditClick}
                />
              </Link>
            )}

          <div>
            {user.user === null || user?.user.userType !== "candidates" ? (
              ""
            ) : (
              <HiOutlineStar
                className={
                  selected
                    ? "offersemploi-icon_star-selected"
                    : "offersemploi-icon_star"
                }
                onClick={handleIconClick}
                size={50}
              />
            )}
          </div>
        </div>
      </div>

      <Link to={`/offers/${offer.id}`}>
        <Button id="offersemploi-offer_button-info" variant="contained">
          Plus d'infos
        </Button>
      </Link>
    </div>
  );
};

OfferEmploi.propTypes = {
  userId: PropTypes.number,
  offer: PropTypes.shape({
    id: PropTypes.number.isRequired,
    candidateId: PropTypes.number,
    job_title: PropTypes.string.isRequired,
    salary: PropTypes.string.isRequired,
    contract_type: PropTypes.string.isRequired,
    city_name: PropTypes.string.isRequired,
    remote_type: PropTypes.string.isRequired,
    numberOfEmployees: PropTypes.string.isRequired,
    Logo: PropTypes.string.isRequired,
    recruiterId: PropTypes.number.isRequired,
  }).isRequired,
};
OfferEmploi.defaultProps = {
  userId: null,
};

export default OfferEmploi;
