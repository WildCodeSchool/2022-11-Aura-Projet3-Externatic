import React from "react";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";

function Success({ success }) {
  if (success === "candidates") {
    return (
      <div>
        <section className="registration-succes_msg">
          Merci, vous pouvez vous{" "}
          <Link className="registration-succes_msg-connexion" to="/connect">
            {" "}
            connecter
          </Link>
        </section>
      </div>
    );
  }
  if (success === "recruiters") {
    return (
      <div>
        <section className="registration-succes_msg">
          Recruteur ajouté !
        </section>
      </div>
    );
  }
  return null;
}

Success.propTypes = {
  success: PropTypes.string,
};

Success.defaultProps = {
  success: null,
};

export default Success;
