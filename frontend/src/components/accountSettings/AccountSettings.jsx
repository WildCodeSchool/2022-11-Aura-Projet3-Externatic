import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import "./AccountSettings.css";

import useApi from "../../services/useApi";
import { useUser } from "../../contexts/UserContext";

function AccountSettings() {
  const [passInit, setPassInit] = useState("");
  const [pass1, setPass1] = useState("");
  const [pass2, setPass2] = useState("");
  const [validPwd, setValidPwd] = useState(false);
  const [validMatch, setValidMatch] = useState(true);
  const [reload, setReload] = useState(0);
  const [success, setSuccess] = useState(true);
  const [deleteSucces, setDeleteSucces] = useState(false);
  const [modal, setModal] = useState(false);
  const navigate = useNavigate();

  const api = useApi();
  const { user } = useUser();
  const userInfo = user;

  const PWD_REDEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%]).{8,24}$/;

  useEffect(() => {
    const result = PWD_REDEX.test(pass1);
    setValidPwd(result);
    const match = pass1 === pass2;
    setValidMatch(match);
  }, [pass1, pass2]);

  const handleDelete = () => {
    const deleteAccountApi = `candidates/${userInfo.id}`;
    api
      .delete(deleteAccountApi)
      .then(() => {
        setDeleteSucces(true);
        setTimeout(() => {
          navigate("/");
          setTimeout(() => {
            window.location.reload();
          }, 1000);
        }, 2000);
      })
      .catch((err) => {
        console.error(err);
      });
  };

  const handleModal = () => {
    setModal(true);
  };

  const handleCloseModal = () => {
    setModal(false);
  };

  const handleSubmit = (e) => {
    const verifyPasswordApi = `login/candidates/${userInfo.id}/changepassword`;

    e.preventDefault();

    const dataPassword = {
      password: passInit,
      newPassword: pass1,
    };
    api
      .put(verifyPasswordApi, dataPassword)
      .then((res) => {
        console.warn(res);
        setSuccess(true);
        setReload(reload + 1);
        setTimeout(() => {
          setReload(0);
        }, 2000);
      })
      .catch((err) => {
        setSuccess(false);
        console.warn(err);
      });
  };

  return reload > 0 ? (
    <p className="update-succes_p">Mise à jour ...</p>
  ) : (
    <div>
      <form onSubmit={handleSubmit}>
        <label htmlFor="passInit" className="form-label">
          Mot de passe actuelle :
          <input
            type="password"
            id="passInit"
            value={passInit}
            onChange={(e) => setPassInit(e.target.value)}
            className="form-input"
          />
          <span className={success ? "signup-hide" : "signup-invalid"}>
            {" "}
            Mauvais mot de passe
          </span>
        </label>

        <label htmlFor="pass1" className="form-label">
          Nouveau mot de passe :
          <input
            type="password"
            id="pass1"
            value={pass1}
            onChange={(e) => setPass1(e.target.value)}
            className="form-input"
          />
          <span
            className={validPwd || !pass1 ? "signup-hide" : "signup-invalid"}
          >
            Mot de passe invalide
          </span>
        </label>
        <label htmlFor="pass2" className="form-label">
          Confirmer le mot nouveau de passe :
          <input
            type="password"
            id="pass2"
            value={pass2}
            onChange={(e) => setPass2(e.target.value)}
            className="form-input"
          />
          <span
            className={validMatch || !pass2 ? "signup-hide" : "signup-invalid"}
          >
            Les mots de passe ne correspondent pas
          </span>
        </label>
        <div className="form-btn-container">
          <button disabled={!validMatch} type="submit" className="form-btn">
            Valider
          </button>
        </div>
      </form>
      <div className="btn-delete_container">
        <h2 className="btn-delete_h2">Compte : </h2>
        <button className="btn-delete" type="button" onClick={handleModal}>
          Supprimer mon compte
        </button>
      </div>

      {modal ? (
        <div className="delete-modal_container">
          <div className="delete-modal_column">
            <h2 className="delete-modal_h2">
              Voulez vous vraiment supprimer votre compte ?
            </h2>
            <button
              className="delete-modal_btn btn-yes"
              type="button"
              onClick={handleDelete}
            >
              Oui
            </button>
            <button
              className="delete-modal_btn btn-no"
              type="button"
              onClick={handleCloseModal}
            >
              Non
            </button>
          </div>
        </div>
      ) : (
        ""
      )}
      {deleteSucces ? (
        <div className="delete-succes_modal-container">
          <h2 className="delete-succes_modal-h2">
            Compte supprimé avec succès
          </h2>
        </div>
      ) : (
        ""
      )}
    </div>
  );
}

export default AccountSettings;
