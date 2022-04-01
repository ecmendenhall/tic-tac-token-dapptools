import { HashRouter, Routes, Route } from "react-router-dom";
import Game from "../pages/Game";
import Home from "../pages/Home";

const Router = () => {
  return (
    <HashRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/games/:id" element={<Game />} />
      </Routes>
    </HashRouter>
  );
};

export default Router;
