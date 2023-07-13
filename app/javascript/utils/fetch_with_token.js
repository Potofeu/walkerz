const fetchWithToken = (url, options) => {
  options.headers = {
    "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
    ...options.headers
  };

  return fetch(url, options);
}

export default fetchWithToken;
export { fetchWithToken };
