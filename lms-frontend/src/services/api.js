import axios from "axios";

// Use environment variable for API base URL
// Use environment variable for API base URL
const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://academy.trendtacticsdigital.com/api';

// Create axios instance with default config
const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Request interceptor for adding auth token
apiClient.interceptors.request.use((config) => {
    console.log(`API Request: ${config.method.toUpperCase()} ${config.baseURL}${config.url}`);
    const token = localStorage.getItem('token');
    if (token) {
        config.headers = config.headers || {};
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
}, (error) => {
    return Promise.reject(error);
});

// Response interceptor for handling common errors
apiClient.interceptors.response.use((response) => {
    // Validate response data
    if (!response.data) {
        throw new Error('Invalid response: No data received');
    }
    return response;
}, (error) => {
    // Handle network errors
    if (!error.response) {
        throw new Error('Network error: Unable to connect to server');
    }
    // Handle specific HTTP status codes
    switch (error.response.status) {
        case 400:
            throw new Error(error.response.data?.message || 'Bad request: Please check your input');
        case 401:
            // Clear local storage for unauthorized access
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            throw new Error('Unauthorized: Please log in again');
        case 403:
            throw new Error('Forbidden: You do not have permission to perform this action');
        case 404:
            throw new Error('Not found: The requested resource does not exist');
        case 500:
            throw new Error('Server error: Please try again later');
        default:
            console.error('API Error Response:', error.response);
            throw new Error(error.response.data?.message || error.response.data?.error || `Error ${error.response.status}: ${error.response.statusText || 'An unexpected error occurred'}`);
    }
});

// Generic GET request function
export const get = async (url, config) => {
    try {
        const response = await apiClient.get(url, config);
        return response.data;
    }
    catch (error) {
        throw new Error(error.message || 'Failed to fetch data');
    }
};

// Generic POST request function
export const post = async (url, data, config) => {
    try {
        const response = await apiClient.post(url, data, config);
        return response.data;
    }
    catch (error) {
        throw new Error(error.message || 'Failed to submit data');
    }
};

// Generic PUT request function
export const put = async (url, data, config) => {
    try {
        const response = await apiClient.put(url, data, config);
        return response.data;
    }
    catch (error) {
        throw new Error(error.message || 'Failed to update data');
    }
};

// Generic DELETE request function
export const del = async (url, config) => {
    try {
        const response = await apiClient.delete(url, config);
        return response.data;
    }
    catch (error) {
        throw new Error(error.message || 'Failed to delete data');
    }
};

export default apiClient;