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
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const jsonData = await response.json();
      setData(jsonData);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  return (
    <div>
      <p>{data.message} {data.user_name}!</p>
    </div>
  );
};

export default ApiCallComponent;
