import { headers } from 'next/headers'

async function getData() {
  const headersInstance = headers()
  headersInstance.forEach((value, key) => {
    console.log(`Request Header - ${key}: ${value}`);
  });


  const API_URL: string = process.env.API_URL ?? ""
  console.log(`API_URL - ${process.env.API_URL}`)

  const response = await fetch(API_URL, {
    cache: "no-store",
    headers: headersInstance,
  })

  const responseHeaders = response.headers;
  responseHeaders.forEach((value, key) => {
    console.log(`Response Header - ${key}: ${value}`);
  });

  let data;
  try {
    const json = await response.json();
    data = json;
    console.log(`Data - ${JSON.stringify(data)}`);
  } catch (error) {
    console.error('Error parsing JSON:', error);
    data = { "message": "Received no json or error parsing json", "user_name": "!"};
  }

  return data;

}

export default async function Home() {
  const data = await getData()
  return (
    <div>
      <p>{data.message} {data.user_name}!</p>
    </div>
  )
}
