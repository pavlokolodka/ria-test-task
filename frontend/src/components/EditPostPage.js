import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate, useParams } from "react-router-dom";
import { convertValidationErrorsToStringArray } from "../utils/errors";
import BackButton from "../common/BackButton";

const EditPostPage = () => {
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [error, setError] = useState(null);

  const navigate = useNavigate();
  const { id } = useParams();

  useEffect(() => {
    axios.get(`/api/posts/${id}`).then((response) => {
      const responseData = response.data.data
      setTitle(responseData.title);
      setBody(responseData.body);
    }).catch((err) => {
      if (err.response && err.response.status === 404) {
        setError("Post not found.");
      } else {
        setError("An unexpected error occurred. Please try again.");
      }
    });
    ;
  }, [id]);

  const handleSubmit = (event) => {
    event.preventDefault();
    setError(null); 
    axios.put(`/api/posts/${id}`, { title, body }).then(() => {
      navigate(`/post/${id}`);
    }).catch((err) => {
      if (err.response && err.response.status === 422) {
        const errors = err.response.data.errors;
        const errorToDisplay = convertValidationErrorsToStringArray(errors)

        setError(errorToDisplay || "Invalid post data");
      } else {
        console.log('erere', err)
        setError("An unexpected error occurred. Please try again.");
      }
    });
  };

  return (
    <div>
      <BackButton />
      <div className="form-container">
      <h2>Edit the post</h2>
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
        <button type="submit">Edit Post</button>
      </form>
    </div>
    </div>
   
  ); 
};

export default EditPostPage;
