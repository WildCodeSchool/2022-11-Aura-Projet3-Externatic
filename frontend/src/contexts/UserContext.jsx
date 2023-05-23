/* eslint-disable react/jsx-no-constructed-context-values */
/* eslint-disable react/prop-types */
import { useState, useContext, createContext } from "react";
// Définir mon contexte utilisateur
const UserContext = createContext(null);

// Création du provider
function UserProvider({ children }) {
  const [user, setUser] = useState(null);
  const [myRecruiter, setMyRecruiter] = useState(null);

  return (
    <UserContext.Provider
      value={{ user, setUser, myRecruiter, setMyRecruiter }}
    >
      {children}
    </UserContext.Provider>
  );
}
// Création de mon hook personnalisé
export const useUser = () => useContext(UserContext);
// Export du provider
export default UserProvider;
