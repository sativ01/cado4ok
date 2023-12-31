import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// create a new user
export const createNewUser = async () => await prisma.user.create({
  data: {
    lastName: "Dough",
    firstName: "John",
    email: `john-${Math.random()}@example.com`,
    phone: `${Math.random() * 1000000}`
  },
});

