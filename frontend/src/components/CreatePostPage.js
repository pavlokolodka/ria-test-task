import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { convertValidationErrorsToStringArray } from "../utils/errors";
import BackButton from "../common/BackButton";

const CreatePostPage = () => {
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [error, setError] = useState(null);

  const navigate = useNavigate();

  const handleSubmit = (event) => {
    event.preventDefault();
    setError(null);

    axios
    .post("/api/posts", { title, body })
    .then(() => {
      navigate("/");
    })
    .catch((err) => {
      if (err.response && err.response.status === 422) {
        const errors = err.response.data.errors;
        const errorToDisplay = convertValidationErrorsToStringArray(errors)
        setError(errorToDisplay || "Invalid post data");
      } else {
        setError("An unexpected error occurred. Please try again.");
      }
    });
  };

  return (
    <div>
       <BackButton />
       <div className="form-container">
     
     <h2>Create a new post</h2>
     {error?.length && error.map(e => <p className="error">{e}</p>) }
     <form onSubmit={handleSubmit}>
       <div className="form-group">
         <label style={{paddingRight: "16px"}} htmlFor="title">Title:</label>
         <input
           type="text"
           id="title"
           value={title}
           onChange={(e) => setTitle(e.target.value)}
           required
         />
       </div>
       <div className="form-group">
         <label style={{paddingRight: "10px"}} htmlFor="body">Body:</label>
         <textarea
           type="text"
           id="body"
           value={body}
           onChange={(e) => setBody(e.target.value)}
           required
         />
       </div>
       <button type="submit">Create Post</button>
     </form>
   </div>
    </div>
   
  );
};

export default CreatePostPage;
