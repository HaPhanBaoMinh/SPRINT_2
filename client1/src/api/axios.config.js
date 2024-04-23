import axios from "axios";

const baseURL = true ? import.meta.env.VITE_API_URL : "http://localhost:9000/api";

const API = axios.create({
  baseURL,
  withCredentials: true,
  headers: {
    "Content-Type": "application/json",
  },
});

API.interceptors.request.use(
  function (req) {
    const token = JSON.parse(localStorage.getItem("token"));
    if (token) req.headers.Authorization = `Bearer ${token}`;
    return req;
  },
  function (error) {
    return Promise.reject(error);
  }
);

export default API;
