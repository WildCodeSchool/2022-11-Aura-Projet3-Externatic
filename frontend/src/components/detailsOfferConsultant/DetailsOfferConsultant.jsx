/* eslint-disable react/function-component-definition */
import PropTypes from "prop-types";
import "./DetailsOfferConsultant.css";
import PictureConsultant from "../../assets/picture-consultantbis.jpg";

const DetailsOfferConsultant = (props) => {
  const { offer } = props;

  return (
    <div className="detailsOfferConsultant-container">
      <h2 className="detailsOfferConsultant-title">
        Votre contact pour ce job
      </h2>
      <div className="detailsOfferConsultant-subtitle">
        <img
          src={PictureConsultant}
          alt="consultant"
          className="detailsOfferConsultant-picture"
        />
        <div className="detailsOfferConsultant-contact">
          <h2 className="detailsOfferConsultant-identity">
            {offer.consultantFirstname} {offer.consultantName}
          </h2>
          <h2 className="detailsOfferConsultant-city">
            Consultant recrutement IT à {offer.cityName}
          </h2>
        </div>
      </div>
    </div>
  );
};

DetailsOfferConsultant.propTypes = {
  offer: PropTypes.shape({
    consultantPicture: PropTypes.string,
    consultantFirstname: PropTypes.string,
    consultantName: PropTypes.string,
    cityName: PropTypes.string,
  }).isRequired,
};

export default DetailsOfferConsultant;
