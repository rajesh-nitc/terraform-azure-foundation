import React, { useState, useEffect } from 'react';

const ApiCallComponent = () => {
  const [easyauthdata, setEasyAuthData] = useState([]);
  const [apidata, setApiData] = useState([]);

  useEffect(() => {
    if (process.env.REACT_APP_ENV !== "development") {
      get_easy_auth_data();
    }
    get_api_data();
  }, []);

  const get_easy_auth_data = async () => {
    try {
      const response = await fetch("/.auth/me", {
        method: 'GET',
        redirect: 'follow',
        cache: "no-cache",
        credentials: "include",
      });
      const jsonData = await response.json();
      console.log(jsonData)
      setEasyAuthData(jsonData);
    } catch (error) {
      console.error('Error in get_easy_auth_data:', error);

    }
  }

  const get_api_data = async () => {
    try {
      console.log(process.env.REACT_APP_API_URL)
      const headers = new Headers();
      if (process.env.REACT_APP_ENV !== "development" && easyauthdata.length > 0) {
        headers.append("Authorization", "Bearer " + easyauthdata[0].access_token);
      }
      const requestOptions = {
        method: 'GET',
        headers: headers,
        cache: "no-cache",
      };
      const response = await fetch(process.env.REACT_APP_API_URL, requestOptions);
      const jsonData = await response.json();
      console.log(jsonData)
      setApiData(jsonData);
    } catch (error) {
      console.error('Error in get_api_data:', error);
    }
  };

  return (
    <div>
      <p>{JSON.stringify(apidata)}</p>
    </div>
  );
};

export default ApiCallComponent;
