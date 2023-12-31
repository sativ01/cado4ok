/*
  Warnings:

  - You are about to drop the column `adminOfSchoolId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `note` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `parentOfSchoolId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `teacherOfSchoolId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `AddedList` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ExcuseList` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `groupId` to the `Kid` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "AmendActions" AS ENUM ('ADD', 'REMOVE');

-- DropForeignKey
ALTER TABLE "AddedList" DROP CONSTRAINT "AddedList_kidId_fkey";

-- DropForeignKey
ALTER TABLE "ExcuseList" DROP CONSTRAINT "ExcuseList_kidId_fkey";

-- DropForeignKey
ALTER TABLE "Kid" DROP CONSTRAINT "Kid_parentId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_adminOfSchoolId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_parentOfSchoolId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_teacherOfSchoolId_fkey";

-- AlterTable
ALTER TABLE "Kid" ADD COLUMN     "groupId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "adminOfSchoolId",
DROP COLUMN "note",
DROP COLUMN "parentOfSchoolId",
DROP COLUMN "role",
DROP COLUMN "teacherOfSchoolId";

-- DropTable
DROP TABLE "AddedList";

-- DropTable
DROP TABLE "ExcuseList";

-- CreateTable
CREATE TABLE "Group" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "schoolId" TEXT NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Parent" (
    "userId" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'PARENT',
    "schoolId" TEXT NOT NULL,
    "note" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Teacher" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'TEACHER',
    "schoolId" TEXT NOT NULL,
    "note" TEXT NOT NULL,

    CONSTRAINT "Teacher_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Admin" (
    "userId" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ADMIN',
    "schoolId" TEXT NOT NULL,
    "note" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "AmendList" (
    "date" TIMESTAMP(3) NOT NULL,
    "type" "AmendActions" NOT NULL DEFAULT 'ADD',
    "groupId" TEXT NOT NULL,

    CONSTRAINT "AmendList_pkey" PRIMARY KEY ("date")
);

-- CreateTable
CREATE TABLE "AmendListNote" (
    "kidId" TEXT NOT NULL,
    "amendListDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AmendListNote_pkey" PRIMARY KEY ("kidId","amendListDate")
);

-- CreateTable
CREATE TABLE "_GroupToTeacher" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_AmendListToKid" (
    "A" TIMESTAMP(3) NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Parent_userId_key" ON "Parent"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher_userId_key" ON "Teacher"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_userId_key" ON "Admin"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "AmendList_date_key" ON "AmendList"("date");

-- CreateIndex
CREATE UNIQUE INDEX "_GroupToTeacher_AB_unique" ON "_GroupToTeacher"("A", "B");

-- CreateIndex
CREATE INDEX "_GroupToTeacher_B_index" ON "_GroupToTeacher"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AmendListToKid_AB_unique" ON "_AmendListToKid"("A", "B");

-- CreateIndex
CREATE INDEX "_AmendListToKid_B_index" ON "_AmendListToKid"("B");

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "School"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Parent" ADD CONSTRAINT "Parent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Parent" ADD CONSTRAINT "Parent_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "School"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Teacher" ADD CONSTRAINT "Teacher_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Teacher" ADD CONSTRAINT "Teacher_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "School"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "School"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Parent"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AmendList" ADD CONSTRAINT "AmendList_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AmendListNote" ADD CONSTRAINT "AmendListNote_kidId_fkey" FOREIGN KEY ("kidId") REFERENCES "Kid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AmendListNote" ADD CONSTRAINT "AmendListNote_amendListDate_fkey" FOREIGN KEY ("amendListDate") REFERENCES "AmendList"("date") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GroupToTeacher" ADD CONSTRAINT "_GroupToTeacher_A_fkey" FOREIGN KEY ("A") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GroupToTeacher" ADD CONSTRAINT "_GroupToTeacher_B_fkey" FOREIGN KEY ("B") REFERENCES "Teacher"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AmendListToKid" ADD CONSTRAINT "_AmendListToKid_A_fkey" FOREIGN KEY ("A") REFERENCES "AmendList"("date") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AmendListToKid" ADD CONSTRAINT "_AmendListToKid_B_fkey" FOREIGN KEY ("B") REFERENCES "Kid"("id") ON DELETE CASCADE ON UPDATE CASCADE;
