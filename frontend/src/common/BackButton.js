// src/components/BackButton.js
import React from "react";
import { useNavigate } from "react-router-dom";

const BackButton = () => {
  const navigate = useNavigate();

  return (
    <button
      onClick={() => navigate("/")}
      className="back-button"
    >
      Back to Posts
    </button>
  );
};

export default BackButton;
