/*
  Warnings:

  - You are about to drop the column `friendshipLevel` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `heldItem` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `item` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `letsGoSteps` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `level` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `location` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `move` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `region` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `time` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `trade` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the column `unique` on the `Evolution` table. All the data in the column will be lost.
  - You are about to drop the `_EvolutionToGame` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."_EvolutionToGame" DROP CONSTRAINT "_EvolutionToGame_A_fkey";

-- DropForeignKey
ALTER TABLE "public"."_EvolutionToGame" DROP CONSTRAINT "_EvolutionToGame_B_fkey";

-- AlterTable
ALTER TABLE "Evolution" DROP COLUMN "friendshipLevel",
DROP COLUMN "heldItem",
DROP COLUMN "item",
DROP COLUMN "letsGoSteps",
DROP COLUMN "level",
DROP COLUMN "location",
DROP COLUMN "move",
DROP COLUMN "region",
DROP COLUMN "time",
DROP COLUMN "trade",
DROP COLUMN "unique",
ADD COLUMN     "tradeEvo" BOOLEAN NOT NULL DEFAULT false;

-- DropTable
DROP TABLE "public"."_EvolutionToGame";
