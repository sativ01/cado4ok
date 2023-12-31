-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'TEACHER', 'PARENT');

-- CreateTable
CREATE TABLE "Kid" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "parentNote" TEXT,
    "hasDailyLunch" BOOLEAN NOT NULL DEFAULT false,
    "parentId" INTEGER NOT NULL,

    CONSTRAINT "Kid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'PARENT',
    "note" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExcuseList" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "kidId" INTEGER NOT NULL,
    "note" TEXT,

    CONSTRAINT "ExcuseList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AddedList" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "kidId" INTEGER NOT NULL,
    "note" TEXT,

    CONSTRAINT "AddedList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DayStats" (
    "date" TIMESTAMP(3) NOT NULL,
    "addedIds" INTEGER[],
    "absentIds" INTEGER[],
    "lunchCount" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "DayStats_date_key" ON "DayStats"("date");

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExcuseList" ADD CONSTRAINT "ExcuseList_kidId_fkey" FOREIGN KEY ("kidId") REFERENCES "Kid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AddedList" ADD CONSTRAINT "AddedList_kidId_fkey" FOREIGN KEY ("kidId") REFERENCES "Kid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
