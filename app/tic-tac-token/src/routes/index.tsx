import { BrowserRouter, Routes, Route } from "react-router-dom";
import Game from "../pages/Game";
import Home from "../pages/Home";

const Router = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/games/:id" element={<Game />} />
      </Routes>
    </BrowserRouter>
  );
};

export default Router;
