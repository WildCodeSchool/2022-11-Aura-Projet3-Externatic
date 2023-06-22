/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable react/function-component-definition */
import PropTypes from "prop-types";
import { FiMapPin } from "react-icons/fi";
import { CgEuro } from "react-icons/cg";
import { SiReacthookform } from "react-icons/si";
import "./DetailsOfferHero.css";

const DetailsOfferHero = (props) => {
  const { offer } = props;

  const urlFile = import.meta.env.VITE_APP_URL;
  return (
    <div className="detailsOfferHero-container">
      <div
        className="detailsOfferHero-image"
        style={{
          backgroundImage: offer?.teamPicture
            ? `url(${urlFile}/${offer.teamPicture})`
            : null,
        }}
      >
        {offer?.Logo && (
          <img
            src={`${urlFile}/${offer.Logo}`}
            alt="Logo de l'entreprise"
            className="detailsOfferHero-logo"
          />
        )}

        <h2 className="detailsOfferHero-title">{offer.jobTitleDetails}</h2>
        <div className="detailsOfferHero-subtitles">
          <h3 className="detailsOfferHero-city detailsOfferHero-subtitle_title">
            <FiMapPin className="detailsOfferHero-icon" /> {offer.city_name} -
            {offer.postalCode}
          </h3>
          <h3 className="detailsOfferHero-contrat detailsOfferHero-subtitle_title">
            <SiReacthookform className="detailsOfferHero-icon" />
            {offer.contrat_type}
            {offer.remoteWork === 1 ? " -Télétravail complet" : ""}
          </h3>
          <h3 className="detailsOfferHero-salary detailsOfferHero-subtitle_title">
            <CgEuro size={30} className="detailsOfferHero-icon" />
            {offer.salary} Eur par an
          </h3>
        </div>
      </div>
    </div>
  );
};

DetailsOfferHero.propTypes = {
  offer: PropTypes.shape({
    Logo: PropTypes.string,
    jobTitleDetails: PropTypes.string.isRequired,
    city_name: PropTypes.string.isRequired,
    postalCode: PropTypes.string.isRequired,
    recruiterPostalCode: PropTypes.string.isRequired,
    contrat_type: PropTypes.string.isRequired,
    remoteWork: PropTypes.number.isRequired,
    salary: PropTypes.number.isRequired,
    teamPicture: PropTypes.string.isRequired,
  }),
};
DetailsOfferHero.defaultProps = {
  offer: null,
};

export default DetailsOfferHero;
