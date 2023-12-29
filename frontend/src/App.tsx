import { Typography } from '@mui/material';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import { getDates } from './api/data';

export default function App() {
  return (
    <Container maxWidth="sm">
      <Box sx={{ my: 4 }}>
        {getDates().map(week => week.map(day => <Typography> {day.toUTCString()}) </Typography>))}
      </Box>
    </Container>
  );
}
