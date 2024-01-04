import { useQuery } from "react-query"
import { getTestParentId } from "../parent"

export const useGetTestParentId = () => useQuery("getTestParentId", getTestParentId).data
