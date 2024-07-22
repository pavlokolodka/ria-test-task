import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import BackButton from "../common/BackButton";
const PostPage = () => {
  const [post, setPost] = useState(null);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const { id } = useParams();

  useEffect(() => {
    axios
      .get(`/api/posts/${id}`)
      .then((response) => setPost(response.data.data))
      .catch((err) => {
        if (err.response && err.response.status === 404) {
          setError("Post not found.");
        } else {
          setError("An unexpected error occurred. Please try again.");
        }
      });
  }, [id]);

  const handleDelete = () => {
    // eslint-disable-next-line no-restricted-globals
    const isDelete = confirm("Are you sure you want to delete this post?");
    if (!isDelete) return

    axios
      .delete(`/api/posts/${id}`)
      .then(() => {
        alert("Post deleted successfully.");
        navigate("/");
      })
      .catch((err) => {
        alert("An error occurred while deleting the post.");
      });
  };

  if (error) return <div className="error">{error}</div>;

  if (!post) return <div>Loading...</div>;

  return (
    <div>
       <BackButton />
       <div key={post.id} className="main-post">
     
     <h1>{post.title}</h1>
     <p>{post.body}</p>
     <p className="timestamp">Created at: {new Date(post.inserted_at).toLocaleString()}</p>
     <p className="timestamp">Updated at: {new Date(post.updated_at).toLocaleString()}</p>
     <div className="button-group">
       <button onClick={() => navigate(`/edit/${post.id}`)}>Edit</button>
       <button className="delete-button" onClick={handleDelete}>Delete</button>
     </div>
   </div>
    </div>
   
  );
};

export default PostPage;
