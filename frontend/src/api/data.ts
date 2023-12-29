const workingDaysOfTheWeek = [1, 2, 3, 4, 5];
const week = [0, 1, 2, 3, 4, 5, 6]
const weekLength = week.length;

type Week = Date[]
type Weeks = Week[]

/*
 * Get days from today to the end of the week
 * And days for following {weekCount} amount of weeks
 */
export const getDates = (weekCount = 3) => {
  const today = new Date()
  const monday = new Date()
  monday.setDate(today.getDate() - today.getDay() + 1);
  const rosterWeeks: Weeks = [];

  for (let i = 0; i < weekCount; i++) {
    const weekAdjust = i * weekLength;
    const thisWeek: Week = []
    const nextDate = new Date();

    week.forEach(doW => {
      nextDate.setDate(monday.getDate() + weekAdjust + doW)
      const shouldDisplay = workingDaysOfTheWeek.includes(nextDate.getDay()) && nextDate >= today;
      if (shouldDisplay) {
        thisWeek.push(new Date(nextDate))
      }
    }
    )
    rosterWeeks.push(thisWeek)
  }
  return rosterWeeks
}
