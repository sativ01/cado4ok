import axios from "axios"


export const getTestParentId = async () => {
  let testParentIdString = "loading"
  try {
    const testParentApiUrl = "/testParentId"
    console.log(import.meta.env.BASE_URL)
    const baseUrl = "http://localhost:3000"
    testParentIdString = await axios.get(`${baseUrl}${testParentApiUrl}`)
  } catch (_err) {
    console.log(_err.message)
    return testParentIdString
  }
  return testParentIdString.data;
}
