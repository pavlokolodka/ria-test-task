# Blog app

## Description 

This is a test task to create a simple blog application. The main requirement was to create JSON-API for CRUD operations on Post entity. As for the technologies for this assignment, on the backend side it was required to use Elixir & Phoenix Framework and on the frontend side any UI approach, React was chosen.

## Project tree

```
.
├── api
│   ├── config
│   │   ├── config.exs
│   │   ├── dev.exs
│   │   ├── prod.exs
│   │   ├── runtime.exs
│   │   └── test.exs
│   ├── docker-compose.yaml
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── lib
│   │   ├── blog_api
│   │   │   ├── application.ex
│   │   │   ├── posts
│   │   │   │   └── post.ex
│   │   │   ├── posts.ex
│   │   │   ├── release.ex
│   │   │   └── repo.ex
│   │   ├── blog_api.ex
│   │   ├── blog_api_web
│   │   │   ├── controllers
│   │   │   │   ├── changeset_json.ex
│   │   │   │   ├── error_json.ex
│   │   │   │   ├── fallback_controller.ex
│   │   │   │   ├── post_controller.ex
│   │   │   │   ├── post_json.ex
│   │   │   │   └── posts_controller.ex
│   │   │   ├── endpoint.ex
│   │   │   ├── gettext.ex
│   │   │   ├── router.ex
│   │   │   └── telemetry.ex
│   │   └── blog_api_web.ex
│   ├── mix.exs
│   ├── mix.lock
│   ├── priv
│   │   ├── gettext
│   │   │   ├── en
│   │   │   │   └── LC_MESSAGES
│   │   │   │       └── errors.po
│   │   │   └── errors.pot
│   │   ├── repo
│   │   │   ├── migrations
│   │   │   │   └── 20240720094047_create_posts.exs
│   │   │   └── seeds.exs
│   │   └── static
│   │       ├── favicon.ico
│   │       └── robots.txt
│   ├── README.md
│   ├── rel
│   │   └── overlays
│   │       └── bin
│   │           ├── migrate
│   │           ├── migrate.bat
│   │           ├── server
│   │           └── server.bat
│   └── test
│       ├── blog_api
│       │   ├── posts
│       │   │   └── post_test.exs
│       │   └── posts_test.exs
│       ├── blog_api_web
│       │   └── controllers
│       │       ├── error_json_test.exs
│       │       └── post_controller_test.exs
│       ├── support
│       │   ├── conn_case.ex
│       │   ├── data_case.ex
│       │   └── fixtures
│       │       └── posts_fixtures.ex
│       └── test_helper.exs
├── frontend
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── logo192.png
│   │   ├── logo512.png
│   │   ├── manifest.json
│   │   └── robots.txt
│   ├── README.md
│   └── src
│       ├── App.css
│       ├── App.js
│       ├── App.test.js
│       ├── axios.config.js
│       ├── common
│       │   └── BackButton.js
│       ├── components
│       │   ├── CreatePostPage.js
│       │   ├── EditPostPage.js
│       │   ├── HomePage.js
│       │   └── PostPage.js
│       ├── index.css
│       ├── index.js
│       ├── logo.svg
│       ├── reportWebVitals.js
│       ├── setupTests.js
│       └── utils
│           └── errors.js
└── README.md
```

## Run the app

In order to run the application, you need to have Docker installed on your machine.

### Backend:

```
docker compose -f ./api/docker-compose.yaml up -d
```

### Frontend:

```
docker build -t react-app ./frontend
```

```
docker run -p 3000:3000 react-app
```

## Open the app

### Backend

```
http://localhost:4000/api/posts
```

### Frontend

```
http://localhost:3000/
```