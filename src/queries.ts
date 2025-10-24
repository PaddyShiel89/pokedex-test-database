import { PrismaClient } from "@prisma/client";
import { withAccelerate } from "@prisma/extension-accelerate";

const prisma = new PrismaClient().$extends(withAccelerate());

// A `main` function so that we can use async/await
async function main() {
  // Retrieve all Pokémon in Let's Go, Pikachu!
  const lgpPokemon = await prisma.gameCompatiblePokemon.findMany({
    where: {
      gameId: 1,
    },
  });
  console.log(`Pokémon compatible with "Let's Go, Pikachu!" (${lgpPokemon.length}): `, lgpPokemon);
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
