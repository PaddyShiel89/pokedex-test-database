/*
  Warnings:

  - You are about to drop the `_GameToRegionDexSpecies` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[id,title]` on the table `Game` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[speciesFormId,gender]` on the table `Pokemon` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,speciesFormName]` on the table `Pokemon` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,speciesFormName,gender]` on the table `Pokemon` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[regionDex,index]` on the table `RegionDexSpecies` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,name]` on the table `Species` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,name]` on the table `SpeciesForm` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `afterGender` to the `Evolution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `afterName` to the `Evolution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `beforeGender` to the `Evolution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `beforeName` to the `Evolution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `regionDex` to the `Game` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gameTitle` to the `GameCompatiblePokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pokemonGender` to the `GameCompatiblePokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pokemonName` to the `GameCompatiblePokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `speciesFormName` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `regionDex` to the `RegionDexSpecies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `speciesName` to the `RegionDexSpecies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `speciesName` to the `SpeciesForm` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `SpeciesForm` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "RegionDex" AS ENUM ('RBY', 'GSC', 'RSE', 'FRLG', 'DP', 'PLATINUM', 'HGSS', 'BW', 'BW2', 'LETSGO');

-- CreateEnum
CREATE TYPE "ElementalType" AS ENUM ('BUG', 'DARK', 'DRAGON', 'ELECTRIC', 'FAIRY', 'FIGHTING', 'FIRE', 'FLYING', 'GHOST', 'GRASS', 'GROUND', 'ICE', 'NORMAL', 'POISON', 'PSYCHIC', 'ROCK', 'STEEL', 'STELLAR', 'UNKNOWN', 'WATER');

-- DropForeignKey
ALTER TABLE "public"."Evolution" DROP CONSTRAINT "Evolution_afterId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Evolution" DROP CONSTRAINT "Evolution_beforeId_fkey";

-- DropForeignKey
ALTER TABLE "public"."GameCompatiblePokemon" DROP CONSTRAINT "GameCompatiblePokemon_gameId_fkey";

-- DropForeignKey
ALTER TABLE "public"."GameCompatiblePokemon" DROP CONSTRAINT "GameCompatiblePokemon_pokemonId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Pokemon" DROP CONSTRAINT "Pokemon_speciesFormId_fkey";

-- DropForeignKey
ALTER TABLE "public"."RegionDexSpecies" DROP CONSTRAINT "RegionDexSpecies_speciesId_fkey";

-- DropForeignKey
ALTER TABLE "public"."SpeciesForm" DROP CONSTRAINT "SpeciesForm_speciesId_fkey";

-- DropForeignKey
ALTER TABLE "public"."_GameToRegionDexSpecies" DROP CONSTRAINT "_GameToRegionDexSpecies_A_fkey";

-- DropForeignKey
ALTER TABLE "public"."_GameToRegionDexSpecies" DROP CONSTRAINT "_GameToRegionDexSpecies_B_fkey";

-- AlterTable
ALTER TABLE "Evolution" ADD COLUMN     "afterGender" "Gender" NOT NULL,
ADD COLUMN     "afterName" TEXT NOT NULL,
ADD COLUMN     "beforeGender" "Gender" NOT NULL,
ADD COLUMN     "beforeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Game" ADD COLUMN     "regionDex" "RegionDex" NOT NULL;

-- AlterTable
ALTER TABLE "GameCompatiblePokemon" ADD COLUMN     "gameTitle" TEXT NOT NULL,
ADD COLUMN     "pokemonGender" "Gender" NOT NULL,
ADD COLUMN     "pokemonName" TEXT NOT NULL,
ALTER COLUMN "availability" SET DEFAULT 'NATIVE';

-- AlterTable
ALTER TABLE "Pokemon" ADD COLUMN     "shinyUrl" TEXT,
ADD COLUMN     "speciesFormName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "RegionDexSpecies" ADD COLUMN     "regionDex" "RegionDex" NOT NULL,
ADD COLUMN     "speciesName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Species" ADD COLUMN     "japaneseName" TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE "SpeciesForm" ADD COLUMN     "speciesName" TEXT NOT NULL,
ADD COLUMN     "type" "ElementalType" NOT NULL,
ADD COLUMN     "type2" "ElementalType",
ALTER COLUMN "isSpeciesDefault" SET DEFAULT false;

-- DropTable
DROP TABLE "public"."_GameToRegionDexSpecies";

-- CreateIndex
CREATE UNIQUE INDEX "Game_id_title_key" ON "Game"("id", "title");

-- CreateIndex
CREATE UNIQUE INDEX "Pokemon_speciesFormId_gender_key" ON "Pokemon"("speciesFormId", "gender");

-- CreateIndex
CREATE UNIQUE INDEX "Pokemon_id_speciesFormName_key" ON "Pokemon"("id", "speciesFormName");

-- CreateIndex
CREATE UNIQUE INDEX "Pokemon_id_speciesFormName_gender_key" ON "Pokemon"("id", "speciesFormName", "gender");

-- CreateIndex
CREATE UNIQUE INDEX "RegionDexSpecies_regionDex_index_key" ON "RegionDexSpecies"("regionDex", "index");

-- CreateIndex
CREATE UNIQUE INDEX "Species_id_name_key" ON "Species"("id", "name");

-- CreateIndex
CREATE UNIQUE INDEX "SpeciesForm_id_name_key" ON "SpeciesForm"("id", "name");

-- AddForeignKey
ALTER TABLE "Evolution" ADD CONSTRAINT "Evolution_beforeId_beforeName_beforeGender_fkey" FOREIGN KEY ("beforeId", "beforeName", "beforeGender") REFERENCES "Pokemon"("id", "speciesFormName", "gender") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Evolution" ADD CONSTRAINT "Evolution_afterId_afterName_afterGender_fkey" FOREIGN KEY ("afterId", "afterName", "afterGender") REFERENCES "Pokemon"("id", "speciesFormName", "gender") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCompatiblePokemon" ADD CONSTRAINT "GameCompatiblePokemon_gameId_gameTitle_fkey" FOREIGN KEY ("gameId", "gameTitle") REFERENCES "Game"("id", "title") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCompatiblePokemon" ADD CONSTRAINT "GameCompatiblePokemon_pokemonId_pokemonName_pokemonGender_fkey" FOREIGN KEY ("pokemonId", "pokemonName", "pokemonGender") REFERENCES "Pokemon"("id", "speciesFormName", "gender") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pokemon" ADD CONSTRAINT "Pokemon_speciesFormId_speciesFormName_fkey" FOREIGN KEY ("speciesFormId", "speciesFormName") REFERENCES "SpeciesForm"("id", "name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RegionDexSpecies" ADD CONSTRAINT "RegionDexSpecies_speciesId_speciesName_fkey" FOREIGN KEY ("speciesId", "speciesName") REFERENCES "Species"("id", "name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpeciesForm" ADD CONSTRAINT "SpeciesForm_speciesId_speciesName_fkey" FOREIGN KEY ("speciesId", "speciesName") REFERENCES "Species"("id", "name") ON DELETE RESTRICT ON UPDATE CASCADE;
