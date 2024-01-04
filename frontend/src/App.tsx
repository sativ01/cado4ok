import { Typography } from '@mui/material';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';

import { getDates } from './api/data';
import { useGetTestParentId } from './api/hooks/useGetTestParentId';

export default function App() {
  const parentId = useGetTestParentId();
  return (
    <Container maxWidth="sm">
      <Box sx={{ my: 4 }}>
        {getDates().map(week => week.map(day => <Typography key={day.toUTCString()}> {day.toUTCString()} </Typography>))}
      </Box>
      <Typography>{parentId}</Typography>
    </Container>
  );
}
