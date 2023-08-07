import React, { useState, useEffect } from 'react';

const ApiCallComponent = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    // Call the API once the component mounts
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      console.log(process.env.REACT_APP_API_URL)
      const response = await fetch(process.env.REACT_APP_API_URL);
      console.log(response)
      const jsonData = await response.json();
      setData(jsonData);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  return (
    <div>
      <p>{JSON.stringify(data)}</p>
    </div>
  );
};

export default ApiCallComponent;
