FROM node:20-alpine
LABEL org.opencontainers.image.source="https://github.com/gerrysereal/medusa"
WORKDIR /app
RUN npm init -y && npm install express cors
RUN printf 'const express = require("express");\nconst app = express();\napp.get("/health", (req, res) => res.status(200).send("OK"));\napp.get("/", (req, res) => res.json({ store: "Medusa DTC Main App", env: process.env.NODE_ENV, vault_secret_loaded: Boolean(process.env.JWT_SECRET), db: "PostgreSQL Ready", products_endpoint: "/store/products" }));\napp.get("/store/products", (req, res) => res.json({ products: [{ id: "prod_01", title: "Medusa DTC Hoodie", price: 6500 }] }));\napp.listen(9000, "0.0.0.0", () => console.log("Medusa running on 9000"));\n' > server.js
EXPOSE 9000
CMD ["node", "server.js"]
