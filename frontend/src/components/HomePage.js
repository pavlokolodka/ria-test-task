import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useNavigate } from "react-router-dom";

const HomePage = () => {
  const [posts, setPosts] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    axios.get('/api/posts').then(response => setPosts(response.data.data)).catch(e => console.log('error', e));
  }, []);

  const handleCreatePost = () => {
    navigate("/create");
  };

  return (
    <div>
      <h1>All Posts</h1>
      {posts.length === 0 ? (
        <div className="post-list">
          <p>No posts available.</p>
          <button style={{ backgroundColor: 'darkslategrey'}} onClick={handleCreatePost}>Create a new post</button>
        </div>
      ) : (
        <div>
          <button style={{marginLeft: "38%", backgroundColor: 'darkslategrey'}} onClick={handleCreatePost}>Create a new post</button>
          <div className="post-list">
            {posts.map((post) => (
              <div key={post.id} className="post">
                <p className="timestamp">{new Date(post.inserted_at).toLocaleString()}</p>
         
                <h2>{post.title}</h2>
                <p>{post.body}</p>
                <button onClick={() => navigate(`/post/${post.id}`)}>View Post</button>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default HomePage;
