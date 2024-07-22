/* eslint-disable import/first */
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
// import { config } from "dotenv";
// config()
import './axios.config'
// console.log('axious', process.env.BASE_URL)
import HomePage from './components/HomePage';
import PostPage from './components/PostPage';
import CreatePostPage from './components/CreatePostPage';
import EditPostPage from './components/EditPostPage';
import './App.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/"  Component={HomePage} />
        <Route path="/post/:id" Component={PostPage} />
        <Route path="/create" Component={CreatePostPage} />
        <Route path="/edit/:id" Component={EditPostPage} />
      </Routes>
    </Router>
  );
}

export default App;
