import React, { useEffect, useState } from 'react';
function ExampleComponent() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetchData();
  }, []);

  async function fetchData() {
    try {
      const response = await fetch(process.env.REACT_APP_API_URL);
      const jsonData = await response.json();
      setData(jsonData);
    } catch (error) {
      console.log('Error fetching data:', error);
    }
  }

  return (
    <div>
      <p>Data from api</p>
      {data ? (
        <div>
          <pre>{JSON.stringify(data, null, 2)}</pre>
        </div>
      ) : (
        <div>Loading data...</div>
      )}
    </div>
  );
}

export default ExampleComponent;
