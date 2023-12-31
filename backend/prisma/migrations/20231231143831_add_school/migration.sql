/*
  Warnings:

  - The primary key for the `AddedList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `ExcuseList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Kid` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "AddedList" DROP CONSTRAINT "AddedList_kidId_fkey";

-- DropForeignKey
ALTER TABLE "ExcuseList" DROP CONSTRAINT "ExcuseList_kidId_fkey";

-- DropForeignKey
ALTER TABLE "Kid" DROP CONSTRAINT "Kid_parentId_fkey";

-- AlterTable
ALTER TABLE "AddedList" DROP CONSTRAINT "AddedList_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "kidId" SET DATA TYPE TEXT,
ADD CONSTRAINT "AddedList_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "AddedList_id_seq";

-- AlterTable
ALTER TABLE "ExcuseList" DROP CONSTRAINT "ExcuseList_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "kidId" SET DATA TYPE TEXT,
ADD CONSTRAINT "ExcuseList_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "ExcuseList_id_seq";

-- AlterTable
ALTER TABLE "Kid" DROP CONSTRAINT "Kid_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "parentId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Kid_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Kid_id_seq";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ADD COLUMN     "adminOfSchoolId" TEXT,
ADD COLUMN     "parentOfSchoolId" TEXT,
ADD COLUMN     "teacherOfSchoolId" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- CreateTable
CREATE TABLE "School" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "School_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "School_email_key" ON "School"("email");

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_adminOfSchoolId_fkey" FOREIGN KEY ("adminOfSchoolId") REFERENCES "School"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_teacherOfSchoolId_fkey" FOREIGN KEY ("teacherOfSchoolId") REFERENCES "School"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_parentOfSchoolId_fkey" FOREIGN KEY ("parentOfSchoolId") REFERENCES "School"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExcuseList" ADD CONSTRAINT "ExcuseList_kidId_fkey" FOREIGN KEY ("kidId") REFERENCES "Kid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AddedList" ADD CONSTRAINT "AddedList_kidId_fkey" FOREIGN KEY ("kidId") REFERENCES "Kid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
