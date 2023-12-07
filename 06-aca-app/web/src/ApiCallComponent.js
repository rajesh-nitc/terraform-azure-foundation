import React, { useState, useEffect } from 'react';

const ApiCallComponent = () => {
  const [apidata, setApiData] = useState([]);

  useEffect(() => {
    get_api_data();
  }, []);

  const get_api_data = async () => {
    try {
      console.log(process.env.REACT_APP_APIM_URL)
      const requestOptions = {
        method: 'GET',
        headers: {
          'Ocp-Apim-Subscription-Key': process.env.REACT_APP_APIM_KEY,
          'Content-Type': 'application/json',
        },
        cache: "no-cache",
      };
      const response = await fetch(process.env.REACT_APP_APIM_URL, requestOptions);
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
