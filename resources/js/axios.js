import axios from 'axios';

// Create an Axios instance
const apiClient = axios.create({
  baseURL: window.location.origin + '/api', // Adjust the base URL according to your API endpoint
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
});

// Set up the request interceptor to include the Bearer token
apiClient.interceptors.request.use(function (config) {
  const token = localStorage.getItem('api_token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
}, function (error) {
  return Promise.reject(error);
});

export default apiClient;
